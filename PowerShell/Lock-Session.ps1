# cmldet version

function Lock-Session
{
    [CmdletBinding()]
    [OutputType([String])]
    param
    (
        [Parameter(Mandatory=$false, Position=0)]
        [int]
        $delay = 120
    )

    $shell = New-Object -ComObject wscript.shell
    while($true)
    {
        $shell.SendKeys('{F15}')
        (Get-Date -Format 'yyyy-MM-dd HH:mm:ss') + ' Sending F15 key'
        Start-Sleep -Seconds $delay
    }
}

# minified version for copying
$s=New-Object -C wscript.shell;while(1){$s.SendKeys('{F15}');(Get-Date -F 'yyyy-MM-dd HH:mm:ss')+' Sending F15 key';sleep 5}