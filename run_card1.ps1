Add-Type -ReferencedAssemblies "UIAutomationClient", "UIAutomationTypes" -Path "c:\Users\nursu\Downloads\antigravity\CreateAndSaveCard1.cs"

$res = [CreateAndSaveCard1]::DoCreateAndSave()
Write-Output $res
