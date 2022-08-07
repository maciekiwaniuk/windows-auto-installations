Clear-Host;


Write-Output @"

    ---- Windows auto installations ----

    1. Complex installation of applications (including chocolatey)
    2. Installation of applications
    3. Uninstallation of applications

"@;

$choice = Read-Host 'Please choose option';

$fileName = 'applications.json';
$absolutePathToFile = Resolve-Path "./$fileName";

Clear-Host

if ($choice -eq '1') {
    . ./scripts/install_upgrade_chocolatey.ps1
    installUpgradeChocolatey;

    . ./scripts/install_apps.ps1
    installApps($absolutePathToFile);

} elseif ($choice -eq '2') {
    . ./scripts/install_apps.ps1
    installApps($absolutePathToFile);

} elseif ($choice -eq '3') {
    . ./scripts/uninstall_apps.ps1
    uninstallApps($absolutePathToFile);

}