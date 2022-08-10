# Upgrades chocolatey
function chocolateyUpgrade {
    Write-Output "`n------------ Begin upgrading chocolatey ------------`n";

    choco upgrade chocolatey;

    Write-Output "`n------------ Finished upgrading chocolatey ------------`n";
}
