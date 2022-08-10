# Upgrades apps listed in json file
#
# param {string} - absolute path to json file with listed apps
function applicationsUpgrade ([string]$pathToFile) {
    $applicationsArray = (Get-Content $pathToFile) | ConvertFrom-Json;

    Write-Output "`n------------ Begin upgrading apps ------------`n";

    $foundAppNotAvailableToUpgrade = $false;
    $appsToUpgrade = @();

    foreach ($app in $applicationsArray) {
        $appAvailableForUpgrade = (choco find $app).Length -gt 2;
        
        if ($appAvailableForUpgrade -eq $true) {
            Write-Output "$app is available to upgrade";
            $appsToUpgrade += $app;
        } else {
            Write-Output "$app is not available to upgrade";
            $foundAppNotAvailableToUpgrade = $true;
        }
    }

    if ($foundAppNotAvailableToUpgrade) {
        Write-Output "`nIn your applications list found an application which isn't available to be downloaded.";
        $choice = Read-Host "Do you want to continue? (yes/no)";

        if (($choice -eq 'n') -or ($choice -eq 'no')) {
            ./main.ps1
        }
    }

    foreach ($app in $appsToUpgrade) {
        Write-Output "`n------------ BEGIN UPGRADING OF '$app' ------------";
        choco upgrade $app -y --acceptlicense;
        Write-Output "------------ FINISHED UPGRADING OF '$app' ------------";
    }

    Write-Output "`n------------ Finished upgrading apps ------------ `n";

}
