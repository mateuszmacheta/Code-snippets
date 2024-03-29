# combined https://stackoverflow.com/a/60016244 and https://stackoverflow.com/a/39738567

function Get-Temperature
{
    $t = Get-WmiObject MSAcpi_ThermalZoneTemperature -Namespace "root/wmi"
    $returntemp = @()

    foreach ($temp in $t.CurrentTemperature)
    {


    $currentTempKelvin = $temp / 10
    $currentTempCelsius = $currentTempKelvin - 273.15

    $returntemp += $currentTempCelsius.ToString() + "°C" 
    }
    return $returntemp
}

function Get-Utilization
{
    param(
        [int]$delay = 2
    )
    $totalRam = (Get-CimInstance Win32_PhysicalMemory | Measure-Object -Property capacity -Sum).Sum
    while($true) {
        $date = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
        $cpuTime = (Get-Counter '\Processor(_Total)\% Processor Time').CounterSamples.CookedValue
        $availMem = (Get-Counter '\Memory\Available MBytes').CounterSamples.CookedValue
        $date + ' > CPU: ' + $cpuTime.ToString("#,00.00") + "`t Avail. Mem. " + $availMem.ToString("N0") + 'MB (' + (104857600 * $availMem / $totalRam).ToString("#,00.0") + '%)' `
        ` + "`t Temp: " + (Get-Temperature)
        Start-Sleep -s $delay
    }
}