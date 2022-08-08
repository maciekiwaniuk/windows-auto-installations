# Installs apps listed in json file
#
# param {string} - absolute path to json file with listed apps
function installApps ([string]$pathToFile) {
    $applicationsArray = (Get-Content $pathToFile) | ConvertFrom-Json;

    Write-Output "`n--- Begin installation apps ---`n";

    foreach ($app in $applicationsArray) {
        # check if there is already installed specific app in the system
        $callback = choco find $app;
        $didntFindInstalledPackage = ($callback.Split(' ')[-3] -eq 0);
    
        # system doesn't have installed certain app
        if ($didntFindInstalledPackage) {
            # check if chocolatey has exact app available to install
            $callback = choco search $app;
            $foundCertainAppAvailableToInstall = ($callback.Split(' ')[-3] -gt 0);

            if ($foundCertainAppAvailableToInstall) {
                choco install $app;

            } else {
                Write-Output "Chocolatey didn't find application '$app'.";
            }

        } else {
            # there is already installed certain app in the system
            Write-Output "Application '$app' has been found already installed in the system.";
        }
    }
    
    Write-Output "`n--- Finished installation apps --- `n";

}
