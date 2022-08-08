# Uninstalls apps listed in json file
#
# param {string} - absolute path to json file with listed apps
function uninstallApps ([string]$pathToFile) {
    $applicationsArray = (Get-Content $pathToFile) | ConvertFrom-Json;

    Write-Output "`n--- Begin uninstallation apps ---`n";

    $stringArray = getOrganisedStringAsArray($applicationsArray);

    Write-Output "Are you sure that you want to uninstall follwing apps?`n$stringArray";

    Write-Output "`nYou can continue, kick certain or cancel (continue/kick/cancel)";

    $choice = Read-Host 'Please choose option';
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
        $string = '[';
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