# Uninstalls apps listed in json file
#
# param {string} - absolute path to json file with listed apps
function applicationsUninstall ([string]$pathToFile) {
    $applicationsArray = (Get-Content $pathToFile) | ConvertFrom-Json;
    $stringArray = getOrganisedStringAsArray($applicationsArray);

    Write-Output "`n------------ Begin uninstallation apps ------------`n";

    Write-Output "Are you sure that you want to uninstall follwing apps? !WARNING!`n$stringArray";
    Write-Output "`nYou can continue or cancel";

    $choice = Read-Host "Please choose option (continue/cancel)";

    if ($choice -eq "continue") {
        # timer - 10 seconds
        $length = 1;
        $XSecondsFromNow = (Get-Date).AddSeconds($length);

        while ((Get-Date) -lt $XSecondsFromNow) {
            Write-Output "Uninstallation will begin in $length [Cancel -> CTRL+C]`n";
            Start-Sleep -Seconds 1;
            $length--;
        }

        foreach ($app in $applicationsArray) {
            Write-Output "`n------------ BEGIN UNINSTALLATION OF '$app' ------------";
            choco uninstall $app -y -n;
            Write-Output "------------ FINISHED UNINSTALLATION OF '$app' ------------";
        }

    } else {
        ./main.ps1
    }

    Write-Output "`n------------ Finished uninstallation apps ------------ `n";
}


# Returns organised string that imitates array
function getOrganisedStringAsArray ([string[]]$elements) {
    $amountOfElements = $elements.Count;    

    $elementsAddedToString = 0;
    $index = 1;

    # there will be more than 3 elements
    if ($amountOfElements -gt 3) {
        $string = "[`n   ";
    } else {
        $string = "[";
    }

    foreach ($element in $elements) {
        if ($index -eq 1) {
            $string = "$string$element";

        } elseif ($amountOfElements -gt 3) {
            # trying to add fourth element to one row
            if ($elementsAddedToString % 3 -eq 0) {
                $string = "$string,`n   $element";

            } else {
                $string = "$string, $element";
            }

        } else {
            $string = "$string, $element";
        }

        $index++;
        $elementsAddedToString++;
    }

    if ($amountOfElements -gt 3) {
        $string = "$string`n]";
    } else {
        $string = "$string]";
    }

    return $string;
} 