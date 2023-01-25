$outlookApplication = New-Object -ComObject 'Outlook.Application'
$namespace = $outlookApplication.GetNamespace("MAPI")
if ($outlookApplication.Session.Offline)
{
    "Switching off Offline Mode"
    ($outlookApplication.ActiveExplorer()).CommandBars.ExecuteMso("ToggleOnline")
}
Start-Sleep -Seconds 2
"Send/Receive triggered"
$namespace.SendAndReceive($true)