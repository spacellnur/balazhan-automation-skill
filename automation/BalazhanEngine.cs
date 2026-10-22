using System;
using System.IO;
using System.Text;
using System.Threading;
using System.Globalization;
using System.Collections.Generic;
using System.Runtime.InteropServices;
using System.Windows.Automation;
using System.Web.Script.Serialization;

namespace BalazhanAutomation
{
    /// <summary>
    /// BalazhanEngine - Automated Windows UIAutomation controller for balazhan.nedb.kz.
    /// Provides full programmatic automation for entering student Social Passports
    /// and Curator Observation Cards into the Kazakhstan National Educational Database.
    /// </summary>
    public class BalazhanEngine
    {
        [DllImport("user32.dll", SetLastError = true)]
        private static extern IntPtr OpenDesktop(string lpszDesktop, uint dwFlags, bool fInherit, uint dwDesiredAccess);

        [DllImport("user32.dll", SetLastError = true)]
        private static extern bool SetThreadDesktop(IntPtr hDesktop);

        [DllImport("user32.dll")]
        private static extern bool CloseDesktop(IntPtr hDesktop);

        [DllImport("user32.dll")]
        private static extern bool SetForegroundWindow(IntPtr hWnd);

        private const uint DESKTOP_ALL = 0x01FF;

        /// <summary>
        /// Attaches the calling thread to the interactive default Windows desktop station.
        /// Essential when invoked from non-interactive background agent sessions.
        /// </summary>
        private static IntPtr AttachToInteractiveDesktop()
        {
            IntPtr hDesk = OpenDesktop("default", 0, false, DESKTOP_ALL);
            if (hDesk != IntPtr.Zero)
            {
                SetThreadDesktop(hDesk);
            }
            return hDesk;
        }

        /// <summary>
        /// Locates the Google Chrome window hosting balazhan.nedb.kz.
        /// </summary>
        private static AutomationElement GetBalazhanChromeWindow()
        {
            AutomationElement desktop = AutomationElement.RootElement;
            var condition = new OrCondition(
                new PropertyCondition(AutomationElement.NameProperty, "BALAZHAN - Google Chrome"),
                new PropertyCondition(AutomationElement.ClassNameProperty, "Chrome_WidgetWin_1")
            );

            var windows = desktop.FindAll(TreeScope.Children, condition);
            foreach (AutomationElement win in windows)
            {
                if (win.Current.Name.Contains("BALAZHAN") || win.Current.Name.Contains("Chrome"))
                {
                    return win;
                }
            }
            return null;
        }

        /// <summary>
        /// Calculate student age as of a specific academic reference date.
        /// </summary>
        public static int CalculateAge(string dobString, DateTime referenceDate)
        {
            DateTime dob;
            if (!DateTime.TryParseExact(dobString, "dd.MM.yyyy", CultureInfo.InvariantCulture, DateTimeStyles.None, out dob))
            {
                if (!DateTime.TryParse(dobString, out dob))
                {
                    return 0;
                }
            }
            int age = referenceDate.Year - dob.Year;
            if (referenceDate.Month < dob.Month || (referenceDate.Month == dob.Month && referenceDate.Day < dob.Day))
            {
                age--;
            }
            return age;
        }

        /// <summary>
        /// Process all under-18 students from the specified JSON dataset and enter their Social Passports.
        /// </summary>
        public static void SyncSocialPassports(string jsonPath, int maxAge = 18, int startNum = 1, int endNum = 999)
        {
            Thread t = new Thread(() =>
            {
                IntPtr hDesk = AttachToInteractiveDesktop();
                try
                {
                    if (!File.Exists(jsonPath))
                    {
                        Console.WriteLine("[Error] JSON file not found: " + jsonPath);
                        return;
                    }

                    string jsonText = File.ReadAllText(jsonPath, Encoding.UTF8);
                    var serializer = new JavaScriptSerializer();
                    var rawList = serializer.Deserialize<object[]>(jsonText);

                    DateTime today = DateTime.Today;
                    if (today.Year < 2026) today = new DateTime(2026, 10, 22);

                    List<Dictionary<string, object>> targetStudents = new List<Dictionary<string, object>>();

                    foreach (Dictionary<string, object> s in rawList)
                    {
                        int num = Convert.ToInt32(s["num"]);
                        if (num < startNum || num > endNum) continue;

                        string dob = s.ContainsKey("dob") && s["dob"] != null ? s["dob"].ToString() : "";
                        int age = CalculateAge(dob, today);

                        if (age >= maxAge)
                        {
                            Console.WriteLine("[Skip] Student #{0} {1} is {2} y.o. (Adult, >= {3})", num, s["fio"], age, maxAge);
                            continue;
                        }

                        targetStudents.Add(s);
                    }

                    Console.WriteLine("[BalazhanEngine] Under-{0} students queue: {1} candidates", maxAge, targetStudents.Count);

                    int index = 0;
                    foreach (var s in targetStudents)
                    {
                        index++;
                        int num = Convert.ToInt32(s["num"]);
                        string fio = s["fio"].ToString();
                        string iin = s["iin"].ToString();
                        string gender = s.ContainsKey("gender") && s["gender"] != null ? s["gender"].ToString() : "Мужской";

                        Console.WriteLine("\n[{0}/{1}] Entering Student #{2}: {3} ({4})", index, targetStudents.Count, num, fio, iin);

                        // Nationality radio: 0 = Казах, 1 = Другая
                        string nat = s.ContainsKey("nat") && s["nat"] != null ? s["nat"].ToString() : "";
                        int natRadio = nat.Contains("Казах") ? 0 : 1;

                        // Parent / Guardian names
                        string father = s.ContainsKey("father") && s["father"] != null ? s["father"].ToString() : "-";
                        string mother = s.ContainsKey("mother") && s["mother"] != null ? s["mother"].ToString() : "-";
                        string guardian = s.ContainsKey("guardian") && s["guardian"] != null ? s["guardian"].ToString() : "-";

                        // Father Education: 2 = Высшее, 3 = Техническое, 4 = Среднее, 5 = Другое
                        string fEduStr = s.ContainsKey("fatherEdu") && s["fatherEdu"] != null ? s["fatherEdu"].ToString() : "";
                        int fEdu = fEduStr.Contains("Высшее") ? 2 : fEduStr.Contains("Техническое") ? 3 : fEduStr.Contains("Среднее") ? 4 : 5;

                        // Mother Education: 6 = Высшее, 7 = Техническое, 8 = Среднее, 9 = Другое
                        string mEduStr = s.ContainsKey("motherEdu") && s["motherEdu"] != null ? s["motherEdu"].ToString() : "";
                        int mEdu = mEduStr.Contains("Высшее") ? 6 : mEduStr.Contains("Техническое") ? 7 : mEduStr.Contains("Среднее") ? 8 : 9;

                        // Workplace info
                        string fatherJob = s.ContainsKey("fatherJob") && s["fatherJob"] != null ? s["fatherJob"].ToString() : "-";
                        string motherJob = s.ContainsKey("motherJob") && s["motherJob"] != null ? s["motherJob"].ToString() : "-";
                        string guardianJob = s.ContainsKey("guardianJob") && s["guardianJob"] != null ? s["guardianJob"].ToString() : "-";

                        // Address and Area: 10 = Город, 11 = Село
                        string address = s.ContainsKey("address") && s["address"] != null ? s["address"].ToString() : "-";
                        int areaRadio = s.ContainsKey("areaType") && s["areaType"].ToString() == "Село" ? 11 : 10;

                        // Housing: 12 = Квартира, 13 = Частный дом, 14 = Общежитие, 15 = Другое
                        string houseStr = s.ContainsKey("houseType") && s["houseType"] != null ? s["houseType"].ToString() : "";
                        int houseRadio = houseStr.Contains("Квартира") ? 12 : houseStr.Contains("Частный дом") ? 13 : houseStr.Contains("Общежитие") ? 14 : 15;

                        // Phone numbers
                        string motherPhone = s.ContainsKey("motherPhone") && s["motherPhone"] != null ? s["motherPhone"].ToString() : "-";
                        string fatherPhone = s.ContainsKey("fatherPhone") && s["fatherPhone"] != null ? s["fatherPhone"].ToString() : "-";
                        string studentPhone = s.ContainsKey("phone") && s["phone"] != null ? s["phone"].ToString() : "-";

                        // Family type: 16 = Полная семья, 17 = Неполная семья
                        string famStr = s.ContainsKey("familyType") && s["familyType"] != null ? s["familyType"].ToString() : "";
                        int famRadio = famStr.Contains("Неполная") ? 17 : 16;

                        string kids = s.ContainsKey("kidsCount") && s["kidsCount"] != null ? s["kidsCount"].ToString() : "1";

                        // Checkboxes selection
                        List<int> chkList = new List<int>();
                        string socCat = s.ContainsKey("socCat") && s["socCat"] != null ? s["socCat"].ToString() : "";
                        if (socCat.Contains("Многодетная")) chkList.Add(4);
                        if (socCat.Contains("жетім") || socCat.Contains("попечения") || socCat.Contains("сирота")) chkList.Add(6);

                        // Baseline standard positive attributes
                        chkList.Add(28); // не относящиеся к категориям
                        chkList.Add(35); // не относится к госуслугам
                        chkList.Add(36); // Изменений не наблюдается
                        chkList.Add(47); // Стабильная среда

                        string socEnv = s.ContainsKey("socEnv") && s["socEnv"] != null ? s["socEnv"].ToString() : "";
                        if (socEnv.Contains("друзьями")) chkList.Add(48);

                        chkList.Add(54); // Отношения с одногруппниками: Хорошие
                        chkList.Add(61); // Отношения с друзьями: Хорошие
                        chkList.Add(68); // Конфликты: Не наблюдались
                        chkList.Add(75); // Отношения с учителями: Хорошие

                        string relTeachers = s.ContainsKey("relTeachers") && s["relTeachers"] != null ? s["relTeachers"].ToString() : "";
                        if (relTeachers.Contains("уважительные")) chkList.Add(76);

                        chkList.Add(82); // Буллинг: Не наблюдались

                        string diffSit = s.ContainsKey("difficultSit") && s["difficultSit"] != null ? s["difficultSit"].ToString() : "";
                        if (diffSit.Contains("Развод")) chkList.Add(88);
                        else if (diffSit.Contains("другом городе") || diffSit.Contains("вахта")) chkList.Add(90);
                        else if (diffSit.Contains("Смерть")) chkList.Add(91);
                        else chkList.Add(96); // Трудные жизненные ситуации: Отсутствуют

                        chkList.Add(102); // Факторы риска не наблюдаются

                        SubmitStudentModal(
                            fio, iin, gender, natRadio,
                            father, mother, guardian,
                            fEdu, mEdu,
                            fatherJob, motherJob, guardianJob,
                            address, areaRadio, houseRadio,
                            motherPhone, fatherPhone, studentPhone,
                            famRadio, kids, chkList.ToArray()
                        );

                        Console.WriteLine(" -> Student added successfully: {0}", fio);
                        Thread.Sleep(1200);
                    }

                    Console.WriteLine("\n[BalazhanEngine] All under-{0} students processed successfully!", maxAge);
                }
                catch (Exception ex)
                {
                    Console.WriteLine("[Fatal Error in BalazhanEngine]: " + ex.Message + "\n" + ex.StackTrace);
                }
                finally
                {
                    if (hDesk != IntPtr.Zero) CloseDesktop(hDesk);
                }
            });

            t.SetApartmentState(ApartmentState.STA);
            t.Start();
            t.Join();
        }

        /// <summary>
        /// Drives the UIAutomation controls inside the 'Добавить 1 студента' modal dialog.
        /// </summary>
        private static void SubmitStudentModal(
            string fio, string iin, string gender,
            int natRadioIdx,
            string father, string mother, string guardian,
            int fatherEduRadioIdx, int motherEduRadioIdx,
            string fatherJob, string motherJob, string guardianJob,
            string address,
            int areaRadioIdx, int houseRadioIdx,
            string motherPhone, string fatherPhone, string studentPhone,
            int familyRadioIdx,
            string childrenCount,
            int[] checkIdxs
        ) {
            AutomationElement chrome = GetBalazhanChromeWindow();
            if (chrome == null) throw new Exception("Chrome window for Balazhan not found.");

            SetForegroundWindow(new IntPtr(chrome.Current.NativeWindowHandle));
            Thread.Sleep(250);

            // Check if modal dialog is already open
            bool inModal = false;
            var edits = chrome.FindAll(TreeScope.Descendants, new PropertyCondition(AutomationElement.ControlTypeProperty, ControlType.Edit));
            foreach (AutomationElement e in edits)
            {
                if (e.Current.Name.Contains("ФИО студента"))
                {
                    inModal = true;
                    break;
                }
            }

            if (!inModal)
            {
                // Click 'Добавить студента' on page header
                var buttons = chrome.FindAll(TreeScope.Descendants, new PropertyCondition(AutomationElement.ControlTypeProperty, ControlType.Button));
                foreach (AutomationElement b in buttons)
                {
                    if (b.Current.Name == "Добавить студента")
                    {
                        ((InvokePattern)b.GetCurrentPattern(InvokePattern.Pattern)).Invoke();
                        Thread.Sleep(1000);
                        break;
                    }
                }

                // Click 'ОДИН СТУДЕНТ' selection card
                buttons = chrome.FindAll(TreeScope.Descendants, new PropertyCondition(AutomationElement.ControlTypeProperty, ControlType.Button));
                foreach (AutomationElement b in buttons)
                {
                    if (b.Current.Name.Contains("ОДИН СТУДЕНТ"))
                    {
                        ((InvokePattern)b.GetCurrentPattern(InvokePattern.Pattern)).Invoke();
                        Thread.Sleep(1200);
                        break;
                    }
                }
            }

            // Retrieve refreshed modal elements
            edits = chrome.FindAll(TreeScope.Descendants, new PropertyCondition(AutomationElement.ControlTypeProperty, ControlType.Edit));
            var combos = chrome.FindAll(TreeScope.Descendants, new PropertyCondition(AutomationElement.ControlTypeProperty, ControlType.ComboBox));
            var radios = chrome.FindAll(TreeScope.Descendants, new PropertyCondition(AutomationElement.ControlTypeProperty, ControlType.RadioButton));
            var checks = chrome.FindAll(TreeScope.Descendants, new PropertyCondition(AutomationElement.ControlTypeProperty, ControlType.CheckBox));

            if (edits.Count < 14) throw new Exception("Modal inputs not ready (Edit fields count: " + edits.Count + ")");

            // Step 1: Basic Identifiers
            SetControlValue(edits[1], fio);
            SetControlValue(edits[2], iin);
            if (combos.Count > 3)
            {
                string gVal = gender == "Мужской" ? "Мальчик" : "Девочка";
                SetControlValue(combos[3], gVal);
            }

            // Step 2: Parents & Addresses
            SetControlValue(edits[3], father);
            SetControlValue(edits[4], mother);
            SetControlValue(edits[5], guardian);
            SetControlValue(edits[6], fatherJob);
            SetControlValue(edits[7], motherJob);
            SetControlValue(edits[8], guardianJob);
            SetControlValue(edits[9], address);
            SetControlValue(edits[10], motherPhone);
            SetControlValue(edits[11], fatherPhone);
            SetControlValue(edits[12], studentPhone);
            SetControlValue(edits[13], childrenCount);

            // Step 3: Radio choices
            SelectRadioOption(radios, natRadioIdx);
            SelectRadioOption(radios, fatherEduRadioIdx);
            SelectRadioOption(radios, motherEduRadioIdx);
            SelectRadioOption(radios, areaRadioIdx);
            SelectRadioOption(radios, houseRadioIdx);
            SelectRadioOption(radios, familyRadioIdx);

            // Step 4: Checkbox toggles
            if (checkIdxs != null)
            {
                foreach (int cIdx in checkIdxs)
                {
                    if (cIdx >= 0 && cIdx < checks.Count)
                    {
                        var chk = checks[cIdx];
                        object tp = null;
                        if (chk.TryGetCurrentPattern(TogglePattern.Pattern, out tp))
                        {
                            if (((TogglePattern)tp).Current.ToggleState != ToggleState.On)
                            {
                                ((TogglePattern)tp).Toggle();
                            }
                        }
                    }
                }
            }

            Thread.Sleep(300);

            // Step 5: Click Submit Button inside modal
            var allBtns = chrome.FindAll(TreeScope.Descendants, new PropertyCondition(AutomationElement.ControlTypeProperty, ControlType.Button));
            AutomationElement submitBtn = null;
            for (int i = allBtns.Count - 1; i >= 0; i--)
            {
                if (allBtns[i].Current.Name == "Добавить студента")
                {
                    submitBtn = allBtns[i];
                    break;
                }
            }

            if (submitBtn == null) throw new Exception("Submit button not found inside modal.");

            ((InvokePattern)submitBtn.GetCurrentPattern(InvokePattern.Pattern)).Invoke();
            Thread.Sleep(1800);
        }

        /// <summary>
        /// Creates and saves a Curator Observation Card for the currently opened student profile.
        /// </summary>
        public static string SaveCurrentCuratorObservationCard(int[] observationCheckboxIndices = null)
        {
            string result = "";
            Thread t = new Thread(() =>
            {
                IntPtr hDesk = AttachToInteractiveDesktop();
                try
                {
                    AutomationElement chrome = GetBalazhanChromeWindow();
                    if (chrome == null)
                    {
                        result = "Chrome window not found.";
                        return;
                    }

                    SetForegroundWindow(new IntPtr(chrome.Current.NativeWindowHandle));
                    Thread.Sleep(200);

                    // 1. Click 'Создать карточку'
                    var buttons = chrome.FindAll(TreeScope.Descendants, new PropertyCondition(AutomationElement.ControlTypeProperty, ControlType.Button));
                    AutomationElement createBtn = null;
                    for (int i = 0; i < buttons.Count; i++)
                    {
                        if (buttons[i].Current.Name.Contains("карточку") || buttons[i].Current.Name.Contains("Создать"))
                        {
                            createBtn = buttons[i];
                            break;
                        }
                    }

                    if (createBtn != null)
                    {
                        ((InvokePattern)createBtn.GetCurrentPattern(InvokePattern.Pattern)).Invoke();
                        Thread.Sleep(1200);
                    }

                    // 2. Default standard positive observation attributes if not specified
                    if (observationCheckboxIndices == null)
                    {
                        observationCheckboxIndices = new int[] { 0, 11, 12, 18, 25, 32, 39, 40, 46, 55, 66 };
                    }

                    var checks = chrome.FindAll(TreeScope.Descendants, new PropertyCondition(AutomationElement.ControlTypeProperty, ControlType.CheckBox));
                    foreach (int idx in observationCheckboxIndices)
                    {
                        if (idx >= 0 && idx < checks.Count)
                        {
                            object tp = null;
                            if (checks[idx].TryGetCurrentPattern(TogglePattern.Pattern, out tp))
                            {
                                if (((TogglePattern)tp).Current.ToggleState != ToggleState.On)
                                {
                                    ((TogglePattern)tp).Toggle();
                                }
                            }
                        }
                    }

                    Thread.Sleep(300);

                    // 3. Click 'Сохранить карточку'
                    buttons = chrome.FindAll(TreeScope.Descendants, new PropertyCondition(AutomationElement.ControlTypeProperty, ControlType.Button));
                    AutomationElement saveBtn = null;
                    for (int i = buttons.Count - 1; i >= 0; i--)
                    {
                        string n = buttons[i].Current.Name;
                        if (n.Contains("Сохранить") || n.Contains("карточку"))
                        {
                            saveBtn = buttons[i];
                            break;
                        }
                    }

                    if (saveBtn == null)
                    {
                        result = "Save button not found.";
                        return;
                    }

                    ((InvokePattern)saveBtn.GetCurrentPattern(InvokePattern.Pattern)).Invoke();
                    Thread.Sleep(1500);

                    result = "Observation Card saved successfully!";
                }
                catch (Exception ex)
                {
                    result = "Error: " + ex.Message;
                }
                finally
                {
                    if (hDesk != IntPtr.Zero) CloseDesktop(hDesk);
                }
            });

            t.SetApartmentState(ApartmentState.STA);
            t.Start();
            t.Join();

            return result;
        }

        private static void SetControlValue(AutomationElement el, string val)
        {
            if (el == null) return;
            if (string.IsNullOrEmpty(val)) val = "-";
            object p = null;
            if (el.TryGetCurrentPattern(ValuePattern.Pattern, out p))
            {
                ((ValuePattern)p).SetValue(val);
            }
        }

        private static void SelectRadioOption(AutomationElementCollection radios, int idx)
        {
            if (idx >= 0 && idx < radios.Count)
            {
                object p = null;
                if (radios[idx].TryGetCurrentPattern(SelectionItemPattern.Pattern, out p))
                {
                    ((SelectionItemPattern)p).Select();
                }
            }
        }
    }
}
