# Installs chocolatey
function chocolateyInstall {
    Write-Output "`n------------ Installation of chocolatey started ------------`n";

    Set-ExecutionPolicy Bypass -Scope Process -Force; 
    [System.Net.ServicePointManager]::SecurityProtocol = 
    [System.Net.ServicePointManager]::SecurityProtocol -bor 3072;
    Invoke-Expression ((New-Object System.Net.WebClient).DownloadString("https://community.chocolatey.org/install.ps1"))`

    Write-Output "`n------------ Installation of chocolatey finished ------------`n";
}
