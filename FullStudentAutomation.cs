using System;
using System.IO;
using System.Text;
using System.Threading;
using System.Globalization;
using System.Collections.Generic;
using System.Runtime.InteropServices;
using System.Windows.Automation;
using System.Web.Script.Serialization;

public class FullStudentAutomation {
    [DllImport("user32.dll", SetLastError = true)]
    public static extern IntPtr OpenDesktop(string lpszDesktop, uint dwFlags, bool fInherit, uint dwDesiredAccess);

    [DllImport("user32.dll", SetLastError = true)]
    public static extern bool SetThreadDesktop(IntPtr hDesktop);

    [DllImport("user32.dll")]
    public static extern bool CloseDesktop(IntPtr hDesktop);

    [DllImport("user32.dll")]
    public static extern bool SetForegroundWindow(IntPtr hWnd);

    const uint DESKTOP_ALL = 0x01FF;

    public static void RunAllUnder18(string jsonPath) {
        Thread t = new Thread(() => {
            IntPtr hDesk = OpenDesktop("default", 0, false, DESKTOP_ALL);
            if (!SetThreadDesktop(hDesk)) {
                Console.WriteLine("SetThreadDesktop failed");
                return;
            }

            try {
                string jsonText = File.ReadAllText(jsonPath, Encoding.UTF8);
                var serializer = new JavaScriptSerializer();
                var rawList = serializer.Deserialize<object[]>(jsonText);

                DateTime today = new DateTime(2026, 10, 22);

                int processed = 0;
                int totalTarget = 0;
                foreach (Dictionary<string, object> s in rawList) {
                    int num = Convert.ToInt32(s["num"]);
                    if (num <= 2) continue;
                    DateTime dob = DateTime.ParseExact(s["dob"].ToString(), "dd.MM.yyyy", CultureInfo.InvariantCulture);
                    int age = today.Year - dob.Year;
                    if (today.Month < dob.Month || (today.Month == dob.Month && today.Day < dob.Day)) age--;
                    if (age < 18) totalTarget++;
                }

                Console.WriteLine("Total under-18 students to add: " + totalTarget);

                foreach (Dictionary<string, object> s in rawList) {
                    int num = Convert.ToInt32(s["num"]);
                    if (num <= 2) continue; // Already added!

                    DateTime dob = DateTime.ParseExact(s["dob"].ToString(), "dd.MM.yyyy", CultureInfo.InvariantCulture);
                    int age = today.Year - dob.Year;
                    if (today.Month < dob.Month || (today.Month == dob.Month && today.Day < dob.Day)) age--;
                    if (age >= 18) {
                        Console.WriteLine("Skipping adult student #{0}: {1} (Age: {2})", num, s["fio"], age);
                        continue;
                    }

                    processed++;
                    string fio = s["fio"].ToString();
                    string iin = s["iin"].ToString();
                    string gender = s["gender"].ToString();
                    Console.WriteLine("[{0}/{1}] Adding student #{2}: {3} ({4}, {5})...", processed, totalTarget, num, fio, iin, gender);

                    // Compute fields
                    string nat = s.ContainsKey("nat") && s["nat"] != null ? s["nat"].ToString() : "";
                    int natRadio = nat.Contains("Казах") ? 0 : 1;

                    string father = s.ContainsKey("father") && s["father"] != null ? s["father"].ToString() : "-";
                    string mother = s.ContainsKey("mother") && s["mother"] != null ? s["mother"].ToString() : "-";
                    string guardian = s.ContainsKey("guardian") && s["guardian"] != null ? s["guardian"].ToString() : "-";

                    string fEduStr = s.ContainsKey("fatherEdu") && s["fatherEdu"] != null ? s["fatherEdu"].ToString() : "";
                    int fEdu = fEduStr.Contains("Высшее") ? 2 : fEduStr.Contains("Техническое") ? 3 : fEduStr.Contains("Среднее") ? 4 : 5;

                    string mEduStr = s.ContainsKey("motherEdu") && s["motherEdu"] != null ? s["motherEdu"].ToString() : "";
                    int mEdu = mEduStr.Contains("Высшее") ? 6 : mEduStr.Contains("Техническое") ? 7 : mEduStr.Contains("Среднее") ? 8 : 9;

                    string fatherJob = s.ContainsKey("fatherJob") && s["fatherJob"] != null ? s["fatherJob"].ToString() : "-";
                    string motherJob = s.ContainsKey("motherJob") && s["motherJob"] != null ? s["motherJob"].ToString() : "-";
                    string guardianJob = s.ContainsKey("guardianJob") && s["guardianJob"] != null ? s["guardianJob"].ToString() : "-";

                    string address = s.ContainsKey("address") && s["address"] != null ? s["address"].ToString() : "-";
                    int areaRadio = s.ContainsKey("areaType") && s["areaType"].ToString() == "Город" ? 10 : 11;

                    string houseStr = s.ContainsKey("houseType") && s["houseType"] != null ? s["houseType"].ToString() : "";
                    int houseRadio = houseStr.Contains("Квартира") ? 12 : houseStr.Contains("Частный дом") ? 13 : houseStr.Contains("Общежитие") ? 14 : 15;

                    string motherPhone = s.ContainsKey("motherPhone") && s["motherPhone"] != null ? s["motherPhone"].ToString() : "-";
                    string fatherPhone = s.ContainsKey("fatherPhone") && s["fatherPhone"] != null ? s["fatherPhone"].ToString() : "-";
                    string studentPhone = s.ContainsKey("phone") && s["phone"] != null ? s["phone"].ToString() : "-";

                    string famStr = s.ContainsKey("familyType") && s["familyType"] != null ? s["familyType"].ToString() : "";
                    int famRadio = famStr.Contains("Полная") ? 16 : 17;

                    string kids = s.ContainsKey("kidsCount") && s["kidsCount"] != null ? s["kidsCount"].ToString() : "1";

                    List<int> chkList = new List<int>();
                    string socCat = s.ContainsKey("socCat") && s["socCat"] != null ? s["socCat"].ToString() : "";
                    if (socCat.Contains("Многодетная")) chkList.Add(4);
                    if (socCat.Contains("жетім") || socCat.Contains("попечения")) chkList.Add(6);

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
                    else chkList.Add(96);

                    chkList.Add(102); // Факторы риска не наблюдаются

                    // Execute single student
                    ExecuteSingleStudent(
                        fio, iin, gender, natRadio,
                        father, mother, guardian,
                        fEdu, mEdu,
                        fatherJob, motherJob, guardianJob,
                        address, areaRadio, houseRadio,
                        motherPhone, fatherPhone, studentPhone,
                        famRadio, kids, chkList.ToArray()
                    );

                    Console.WriteLine(" -> Added successfully: {0}", fio);
                    Thread.Sleep(1500);
                }

                Console.WriteLine("\n=== ALL UNDER-18 STUDENTS COMPLETED SUCCESSFULLY ===");
            } catch (Exception ex) {
                Console.WriteLine("FATAL ERROR: " + ex.Message + "\n" + ex.StackTrace);
            } finally {
                CloseDesktop(hDesk);
            }
        });

        t.Start();
        t.Join();
    }

    private static void ExecuteSingleStudent(
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
        AutomationElement desktop = AutomationElement.RootElement;
        AutomationElement chrome = desktop.FindFirst(TreeScope.Children, new PropertyCondition(AutomationElement.NameProperty, "BALAZHAN - Google Chrome"));
        if (chrome == null) throw new Exception("Chrome not found");

        SetForegroundWindow(new IntPtr(chrome.Current.NativeWindowHandle));
        Thread.Sleep(200);

        // Step 1: Check if already in modal
        bool inModal = false;
        var edits = chrome.FindAll(TreeScope.Descendants, new PropertyCondition(AutomationElement.ControlTypeProperty, ControlType.Edit));
        foreach (AutomationElement e in edits) {
            if (e.Current.Name.Contains("ФИО студента")) {
                inModal = true;
                break;
            }
        }

        if (!inModal) {
            // Click 'Добавить студента' on page
            var buttons = chrome.FindAll(TreeScope.Descendants, new PropertyCondition(AutomationElement.ControlTypeProperty, ControlType.Button));
            foreach (AutomationElement b in buttons) {
                if (b.Current.Name == "Добавить студента") {
                    ((InvokePattern)b.GetCurrentPattern(InvokePattern.Pattern)).Invoke();
                    Thread.Sleep(1000);
                    break;
                }
            }

            // Click 'ОДИН СТУДЕНТ' card
            buttons = chrome.FindAll(TreeScope.Descendants, new PropertyCondition(AutomationElement.ControlTypeProperty, ControlType.Button));
            foreach (AutomationElement b in buttons) {
                if (b.Current.Name.Contains("ОДИН СТУДЕНТ")) {
                    ((InvokePattern)b.GetCurrentPattern(InvokePattern.Pattern)).Invoke();
                    Thread.Sleep(1200);
                    break;
                }
            }
        }

        // Step 2: Query modal controls
        edits = chrome.FindAll(TreeScope.Descendants, new PropertyCondition(AutomationElement.ControlTypeProperty, ControlType.Edit));
        var combos = chrome.FindAll(TreeScope.Descendants, new PropertyCondition(AutomationElement.ControlTypeProperty, ControlType.ComboBox));
        var radios = chrome.FindAll(TreeScope.Descendants, new PropertyCondition(AutomationElement.ControlTypeProperty, ControlType.RadioButton));
        var checks = chrome.FindAll(TreeScope.Descendants, new PropertyCondition(AutomationElement.ControlTypeProperty, ControlType.CheckBox));

        if (edits.Count < 14) throw new Exception("Modal edits count too low: " + edits.Count);

        // 1. Basic info
        SetVal(edits[1], fio);
        SetVal(edits[2], iin);
        if (combos.Count > 3) {
            string gVal = gender == "Мужской" ? "Мальчик" : "Девочка";
            SetVal(combos[3], gVal);
        }

        // 2. Parents & Edits
        SetVal(edits[3], father);
        SetVal(edits[4], mother);
        SetVal(edits[5], guardian);
        SetVal(edits[6], fatherJob);
        SetVal(edits[7], motherJob);
        SetVal(edits[8], guardianJob);
        SetVal(edits[9], address);
        SetVal(edits[10], motherPhone);
        SetVal(edits[11], fatherPhone);
        SetVal(edits[12], studentPhone);
        SetVal(edits[13], childrenCount);

        // 3. Radios
        SelectRadio(radios, natRadioIdx);
        SelectRadio(radios, fatherEduRadioIdx);
        SelectRadio(radios, motherEduRadioIdx);
        SelectRadio(radios, areaRadioIdx);
        SelectRadio(radios, houseRadioIdx);
        SelectRadio(radios, familyRadioIdx);

        // 4. Checks
        if (checkIdxs != null) {
            foreach (int cIdx in checkIdxs) {
                if (cIdx >= 0 && cIdx < checks.Count) {
                    var chk = checks[cIdx];
                    object tp = null;
                    if (chk.TryGetCurrentPattern(TogglePattern.Pattern, out tp)) {
                        if (((TogglePattern)tp).Current.ToggleState != ToggleState.On) {
                            ((TogglePattern)tp).Toggle();
                        }
                    }
                }
            }
        }

        Thread.Sleep(300);

        // 5. Click Submit Button
        var allBtns = chrome.FindAll(TreeScope.Descendants, new PropertyCondition(AutomationElement.ControlTypeProperty, ControlType.Button));
        AutomationElement subBtn = null;
        for (int i = allBtns.Count - 1; i >= 0; i--) {
            if (allBtns[i].Current.Name == "Добавить студента") {
                subBtn = allBtns[i];
                break;
            }
        }

        if (subBtn == null) throw new Exception("Submit button in modal not found");

        ((InvokePattern)subBtn.GetCurrentPattern(InvokePattern.Pattern)).Invoke();
        Thread.Sleep(1800);
    }

    private static void SetVal(AutomationElement el, string val) {
        if (el == null) return;
        if (string.IsNullOrEmpty(val)) val = "-";
        object p = null;
        if (el.TryGetCurrentPattern(ValuePattern.Pattern, out p)) {
            ((ValuePattern)p).SetValue(val);
        }
    }

    private static void SelectRadio(AutomationElementCollection radios, int idx) {
        if (idx >= 0 && idx < radios.Count) {
            object p = null;
            if (radios[idx].TryGetCurrentPattern(SelectionItemPattern.Pattern, out p)) {
                ((SelectionItemPattern)p).Select();
            }
        }
    }
}
