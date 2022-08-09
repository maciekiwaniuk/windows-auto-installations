Clear-Host;


Write-Output @"

    ------------ Windows auto installations ------------

    [1] Install chocolatey and applications
    [2] Install applications (required chocolatey)
    [3] Uninstall applications

"@;

$choice = Read-Host "Please choose option (1/2/3)";

$fileName = "applications.json";
$absolutePathToFile = Resolve-Path "./$fileName";

Clear-Host

if ($choice -eq "1") {
    . ./scripts/install_upgrade_chocolatey.ps1
    installUpgradeChocolatey;

    . ./scripts/install_apps.ps1
    installApps($absolutePathToFile);

} elseif ($choice -eq "2") {
    . ./scripts/install_apps.ps1
    installApps($absolutePathToFile);

} elseif ($choice -eq "3") {
    . ./scripts/uninstall_apps.ps1
    uninstallApps($absolutePathToFile);

}