# Upgrades chocolatey
function chocolateyUpgrade {
    Write-Output "`n------------ Upgrading chocolatey started ------------`n";

    choco upgrade chocolatey;

    Write-Output "`n------------ Upgrading chocolatey finished ------------`n";
}
