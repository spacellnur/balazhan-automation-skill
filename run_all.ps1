Add-Type -ReferencedAssemblies "UIAutomationClient", "UIAutomationTypes", "System.Web.Extensions" -Path "c:\Users\nursu\Downloads\antigravity\FullStudentAutomation.cs"

[FullStudentAutomation]::RunAllUnder18("c:\Users\nursu\Downloads\antigravity\students.json")
