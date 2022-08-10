Clear-Host;


Write-Output @"

    ------------ Windows auto installations ------------

    [1] Install chocolatey
    [2] Upgrade chocolatey
    [2] Install applications (required chocolatey)
    [3] Uninstall applications (required chocolatey)

"@;

$choice = Read-Host "Please choose option (1/2/3)";

$fileName = "applications.json";
$absolutePathToFile = Resolve-Path "./$fileName";

Clear-Host

if ($choice -eq "1") {
    . ./scripts/chocolatey/install.ps1
    chocolateyInstall;

} elseif ($choice -eq "2") {
    . ./scripts/chocolatey/upgrade.ps1
    chocolateyUpgrade;

} elseif ($choice -eq "3") {
    . ./scripts/applications/install.ps1
    applicationsInstall($absolutePathToFile);

} elseif ($choice -eq "4") {
    . ./scripts/applications/uninstall.ps1
    applicationsUninstall($absolutePathToFile);
}