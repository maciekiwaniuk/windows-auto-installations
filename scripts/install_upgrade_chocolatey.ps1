# Installs chocolatey if it isn"t installed yet, upgrades to newest version
function installUpgradeChocolatey {

    Write-Output "`n------------ Begin installation and upgrading chocolatey script ------------`n";

    Set-ExecutionPolicy Bypass -Scope Process -Force; 
    [System.Net.ServicePointManager]::SecurityProtocol = 
    [System.Net.ServicePointManager]::SecurityProtocol -bor 3072;
    Invoke-Expression ((New-Object System.Net.WebClient).DownloadString("https://community.chocolatey.org/install.ps1"))`

    choco upgrade chocolatey;

    Write-Output "`n------------ Finished installation and upgrading chocolatey script ------------`n";
}
