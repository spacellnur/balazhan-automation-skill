using System;
using System.Threading;
using System.Collections.Generic;
using System.Runtime.InteropServices;
using System.Windows.Automation;

public class CreateAndSaveCard1 {
    [DllImport("user32.dll", SetLastError = true)]
    public static extern IntPtr OpenDesktop(string lpszDesktop, uint dwFlags, bool fInherit, uint dwDesiredAccess);

    [DllImport("user32.dll", SetLastError = true)]
    public static extern bool SetThreadDesktop(IntPtr hDesktop);

    [DllImport("user32.dll")]
    public static extern bool CloseDesktop(IntPtr hDesktop);

    [DllImport("user32.dll")]
    public static extern bool SetForegroundWindow(IntPtr hWnd);

    const uint DESKTOP_ALL = 0x01FF;

    public static string DoCreateAndSave() {
        string res = "";
        Thread t = new Thread(() => {
            IntPtr hDesk = OpenDesktop("default", 0, false, DESKTOP_ALL);
            if (!SetThreadDesktop(hDesk)) {
                res = "SetThreadDesktop failed";
                return;
            }

            try {
                AutomationElement desktop = AutomationElement.RootElement;
                AutomationElement chrome = desktop.FindFirst(TreeScope.Children, new PropertyCondition(AutomationElement.NameProperty, "BALAZHAN - Google Chrome"));
                if (chrome == null) {
                    res = "Chrome not found";
                    return;
                }

                SetForegroundWindow(new IntPtr(chrome.Current.NativeWindowHandle));
                Thread.Sleep(200);

                // Step 1: Click 'Создать карточку' (button 33)
                var buttons = chrome.FindAll(TreeScope.Descendants, new PropertyCondition(AutomationElement.ControlTypeProperty, ControlType.Button));
                AutomationElement createBtn = null;
                for (int i = 0; i < buttons.Count; i++) {
                    if (buttons[i].Current.Name.Contains("карточку") || buttons[i].Current.Name.Contains("Создать")) {
                        createBtn = buttons[i];
                        break;
                    }
                }

                if (createBtn == null && buttons.Count > 33) {
                    createBtn = buttons[33];
                }

                if (createBtn != null) {
                    ((InvokePattern)createBtn.GetCurrentPattern(InvokePattern.Pattern)).Invoke();
                    Thread.Sleep(1200);
                }

                // Step 2: Toggle checkboxes
                var checks = chrome.FindAll(TreeScope.Descendants, new PropertyCondition(AutomationElement.ControlTypeProperty, ControlType.CheckBox));
                int[] targetChecks = new int[] { 0, 11, 12, 18, 25, 32, 39, 40, 46, 55, 66 };
                foreach (int idx in targetChecks) {
                    if (idx >= 0 && idx < checks.Count) {
                        object tp = null;
                        if (checks[idx].TryGetCurrentPattern(TogglePattern.Pattern, out tp)) {
                            if (((TogglePattern)tp).Current.ToggleState != ToggleState.On) {
                                ((TogglePattern)tp).Toggle();
                            }
                        }
                    }
                }

                Thread.Sleep(300);

                // Step 3: Find and click 'Сохранить карточку'
                buttons = chrome.FindAll(TreeScope.Descendants, new PropertyCondition(AutomationElement.ControlTypeProperty, ControlType.Button));
                AutomationElement saveBtn = null;
                for (int i = buttons.Count - 1; i >= 0; i--) {
                    string n = buttons[i].Current.Name;
                    if (n.Contains("Сохранить") || n.Contains("карточку")) {
                        saveBtn = buttons[i];
                        break;
                    }
                }

                if (saveBtn == null) {
                    res = "Save button not found among " + buttons.Count + " buttons";
                    return;
                }

                ((InvokePattern)saveBtn.GetCurrentPattern(InvokePattern.Pattern)).Invoke();
                Thread.Sleep(1500);

                res = "Card 1 created and saved successfully!";
            } catch (Exception ex) {
                res = "Error: " + ex.Message;
            } finally {
                CloseDesktop(hDesk);
            }
        });

        t.Start();
        t.Join();
        return res;
    }
}
