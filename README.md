
# Windows auto installations

> ### Projects of console app which automatically installs specific applications

- Application is made as PowerShell script, so it will work only on Windows.


# Installation

Open folder where you want to have project files, open console and then clone the repository

    git clone https://github.com/maciekiwaniuk/windows-auto-installations

# Application usage 

Open PowerShell's console with administrative permission. Change directory to place where you installed application. Then you should run main script.

    ./main.ps1

To modify applications which you want to install or uninstall simply modify application.json file and list there all your wanted applications. Available apps you can find on [chocolatey packages browser](https://community.chocolatey.org/packages).