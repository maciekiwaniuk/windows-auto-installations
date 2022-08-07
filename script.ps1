# Installs chocolatey if it isn't installed yet, upgrades to newest version
function installAndUpdateChocolatey {
    Set-ExecutionPolicy Bypass -Scope Process -Force; 
    [System.Net.ServicePointManager]::SecurityProtocol = 
    [System.Net.ServicePointManager]::SecurityProtocol -bor 3072;
    Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))`;

    choco upgrade chocolatey;
}

# Installs apps listed in json file
function installApplicationsListedInFile {
    $fileName = 'apps_to_install.json';

    $applicationsToInstall = (Get-Content .\$fileName) | ConvertFrom-Json

    foreach ($app in $applicationsToInstall) {
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
                Write-Output "Chocolatey didn't find application '$app'";
            }

        } else {
            # there is already installed certain app in the system
            Write-Output "Requested application '$app' has been found already installed in the system.";
        }
    }
    
    
}


# installAndUpdateChocolatey;
installApplicationsListedInFile;
