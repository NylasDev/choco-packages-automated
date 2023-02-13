#Change here the packages you want to install
#Complete list of avaiable packages here: https://community.chocolatey.org/packages
$Packages = @( 
"vscode", 
"git", 
"adobereader", 
"vlc", 
"discord", 
"nodejs", 
"mysql.installer", 
"opera-gx", 
"steam", 
"forticlientvpn", 
"googledrive", 
"notepadplusplus",
"stremio",
"7zip",
"kis",
"geforce-experience",
"autoruns",
"procexp",
"pestudio",
"hxd")

function Install-ChocoPackage {

    [cmdletbinding()]
    param(
        [String]$PackageName
    )

    $ChocoLibPath = "C:\ProgramData\chocolatey\lib"

    if(-not(test-path $ChocoLibPath)){
        Set-ExecutionPolicy Bypass -Scope Process -Force; 
        [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072;
        Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
    }
    
    #Test if the package folder exists on Choco Lib folder
    if (!((test-path "$ChocoLibPath\$PackageName"))) {

        Write-Host "[INFO]Installing $PackageName..." -ForegroundColor Yellow
        $start_time = Get-Date
        #Install the package without confirmation prompt
        choco install -y -v $PackageName 
        Write-Host "Time taken: $((Get-Date).Subtract($start_time).Seconds) second(s)"

    }
    else {

        Write-host  "[INFO]$PackageName is already installed." -ForegroundColor Green
    }
}

#Loop through each package to install them
foreach($Package in $Packages){
    Install-ChocoPackage -PackageName $Package
}