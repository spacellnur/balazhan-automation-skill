# Technical Architecture: Windows UIAutomation for Web Applications

This document describes the technical architecture behind the **Balazhan Automation Engine**, focusing on how headless and agentic processes interact with interactive Windows desktop sessions and Chromium browsers without requiring WebDriver, Selenium, or ChromeDriver binaries.

---

## 1. Problem Statement: Virtual Sessions & Desktop Isolation

Modern AI development environments, background daemon tasks, and CLI agents often execute inside separate Windows Session boundaries or hidden window stations:
- The user is logged in interactively on Session `N` on Window Station `WinSta0` and Desktop `default`.
- An agent or background runner may spawn inside an isolated session (`WinSta0\exebox-...`) or have a security context where `AutomationElement.RootElement` points to an empty virtual desktop.

### Consequence:
Standard calls like `AutomationElement.RootElement.FindAll(...)` fail to see Google Chrome or report zero child elements.

---

## 2. The Solution: Interactive Desktop Station Attachment

The `BalazhanEngine` circumvents this limitation using native Win32 User32 API imports:

```csharp
[DllImport("user32.dll", SetLastError = true)]
public static extern IntPtr OpenDesktop(string lpszDesktop, uint dwFlags, bool fInherit, uint dwDesiredAccess);

[DllImport("user32.dll", SetLastError = true)]
public static extern bool SetThreadDesktop(IntPtr hDesktop);

[DllImport("user32.dll")]
public static extern bool CloseDesktop(IntPtr hDesktop);
```

### Execution Flow:
1. When invoked, the engine spawns a dedicated worker thread with `ApartmentState.STA` (required by COM and UIAutomation).
2. The thread opens the interactive desktop via `OpenDesktop("default", 0, false, 0x01FF)` (`DESKTOP_ALL`).
3. Calls `SetThreadDesktop(hDesk)`.
4. Now, `AutomationElement.RootElement` seamlessly points to the user's live desktop containing the visible Google Chrome window.
5. In the `finally` block, `CloseDesktop(hDesk)` cleans up handles to prevent resource leaks.

---

## 3. Chromium Accessibility Architecture

Google Chrome renders HTML elements into an internal **Accessibility Tree** (IAccessible2 / UIAutomation).

When `Chrome_WidgetWin_1` receives UIAutomation requests:
1. **Edit Fields:** Implements `ValuePattern`. Calling `((ValuePattern)pat).SetValue(text)` directly writes the text value into the DOM input field without typing key simulations, avoiding clipboard interference and character drops.
2. **Radio Buttons:** Implements `SelectionItemPattern`. Calling `((SelectionItemPattern)pat).Select()` triggers the radio selection event.
3. **Checkboxes:** Implements `TogglePattern`. Checks the current `ToggleState` and calls `.Toggle()` only when needed.
4. **Action Buttons:** Implements `InvokePattern`. Calling `.Invoke()` fires the click handler directly within the web page.

---

## 4. Why UIAutomation Beats Puppeteer / Selenium in This Context

| Metric | Selenium / Puppeteer | Windows UIAutomation (This Engine) |
| :--- | :--- | :--- |
| **Prerequisites** | Node.js, npm, ChromeDriver, matching Chrome versions | Zero dependencies (Built-in Windows .NET / PowerShell) |
| **Authentication** | Must handle complex 2FA / Session cookies | Leverages the user's already logged-in browser session |
| **Tamper Detection** | Portals often block `navigator.webdriver = true` | Zero bot fingerprints; uses native Windows accessibility |
| **Installation** | Heavy `npm install` or binary downloads | Single lightweight C# file compiled in-memory via `Add-Type` |
| **Portability** | Hard to package for non-technical teachers | Double-click script or single AI Agent prompt |
