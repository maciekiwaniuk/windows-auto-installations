# Installs apps listed in json file
#
# param {string} - absolute path to json file with listed apps
function applicationsInstall ([string]$pathToFile) {
    $applicationsArray = (Get-Content $pathToFile) | ConvertFrom-Json;

    Write-Output "`n------------ Installation of apps started ------------`n";

    $foundAppNotAvailableToInstall = $false;
    $appsToInstall = @();

    foreach ($app in $applicationsArray) {
        $appAvailableForInstall = (choco find $app).Length -gt 2;
        
        if ($appAvailableForInstall -eq $true) {
            Write-Output "$app is available to install";
            $appsToInstall += $app;
        } else {
            Write-Output "$app is not available to install";
            $foundAppNotAvailableToInstall = $true;
        }
    }

    if ($foundAppNotAvailableToInstall) {
        Write-Output "`nIn your applications list found an application which isn't available to be downloaded.";
        $choice = Read-Host "Do you want to continue? (yes/no)";

        if (($choice -ne 'y') -or ($choice -ne 'yes')) {
            ./main.ps1
        }
    }

    foreach ($app in $appsToInstall) {
        Write-Output "`n------------ BEGIN INSTALLATION OF '$app' ------------";
        choco install $app -y --acceptlicense;
        Write-Output "------------ FINISHED INSTALLATION OF '$app' ------------";
    }

    Write-Output "`n------------ Installation of apps finished ------------ `n";

}
