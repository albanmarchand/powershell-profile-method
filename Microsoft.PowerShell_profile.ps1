$BasePath = "C:\project\test-powershell\"

$Abbreviations = @{sf = "financing" }
$MultipleAbbreviations = @{ mm = "money-market"; mt = "money-market" }

function opensln {
    param (
        $ProjectName
    )
    if($Abbreviations.ContainsKey($ProjectName)) {
        $ProjectName = $Abbreviations[$ProjectName]
    }
    if($MultipleAbbreviations.ContainsKey($ProjectName)) {
        $ProjectName = $MultipleAbbreviations[$ProjectName]
    }
    Write-Output "Begin search for $ProjectName sln" 
    $ProjectPath = "$BasePath$ProjectName"
    try {
        $Slnfile = Get-ChildItem -Path $ProjectPath -Include *.docx -Recurse -Name -ErrorAction Stop | Select-Object -First 1
        Write-Output "$ProjectName sln opening"
        Start-Process "$ProjectPath\$Slnfile"
    }
    catch {
        Write-Output "$ProjectName sln not found" 
        throw
    }
}

function openapp {
    param (
        $ProjectName
    )
    
    Write-Output "Begin search for $ProjectName app folder" 
    $ProjectPath = "$BasePath$ProjectName"
    if($MultipleAbbreviations.Contains($ProjectName)) {
        $MultipleProjectName = $MultipleAbbreviations[$ProjectName]
        $ProjectPath = "$BasePath$MultipleProjectName\$ProjectName"
    } 
    if($Abbreviations.ContainsKey($ProjectName)) {
        $ProjectName = $Abbreviations[$ProjectName]
        $ProjectPath = "$BasePath$ProjectName"
    }
    try {
        $AppFile = Get-ChildItem -Path $ProjectPath -Include app -Directory -Recurse -ErrorAction Stop
        Write-Output "$ProjectName app folder opening" 
        code "$AppFile"
    }
    catch {
        Write-Output "$ProjectName app not found" 
    }
}

function opene2e {
    param (
        $ProjectName
    )
    
    Write-Output "Begin search for $ProjectName e2e folder" 
    $ProjectPath = "$BasePath$ProjectName"
    if($MultipleAbbreviations.Contains($ProjectName)) {
        $MultipleProjectName = $MultipleAbbreviations[$ProjectName]
        $ProjectPath = "$BasePath$MultipleProjectName\$ProjectName"
    } 
    if($Abbreviations.ContainsKey($ProjectName)) {
        $ProjectName = $Abbreviations[$ProjectName]
        $ProjectPath = "$BasePath$ProjectName"
    }
    Write-Output "$ProjectPath"
    try {
        $E2efile = Get-ChildItem -Path $ProjectPath -Include e2e -Directory -Recurse -ErrorAction Stop
        Write-Output "$ProjectName e2e folder opening" 
        code "$E2efile"
    }
    catch {
        Write-Output "$ProjectName e2e not found" 
    }
}

function open {
    param (
        $ProjectName
    )
    $ProjectAppPath = "$BasePath$ProjectName"
    $ProjectSlnPath = "$BasePath$ProjectName"
    if($Abbreviations.ContainsKey($ProjectName)) {
        $ProjectName = $Abbreviations[$ProjectName]
        $ProjectAppPath = "$BasePath$ProjectName"
        $ProjectSlnPath = "$BasePath$ProjectName"
    }
    if($MultipleAbbreviations.Contains($ProjectName)) {
        $MultipleProjectName = $MultipleAbbreviations[$ProjectName]
        $ProjectSlnPath = "$BasePath$MultipleProjectName"
        $ProjectAppPath = "$BasePath$MultipleProjectName\$ProjectName"
    }
    Write-Output "Begin search for $ProjectName sln and app" 
    try {
        $Slnfile = Get-ChildItem -Path $ProjectSlnPath -Include *.docx -Recurse -Name -ErrorAction Stop | Select-Object -First 1
        Write-Output "$ProjectName sln opening"
        Start-Process "$ProjectSlnPath\$Slnfile"
        $AppFile = Get-ChildItem -Path $ProjectAppPath -Include app -Directory -Recurse -ErrorAction Stop
        Write-Output "$ProjectName app folder opening" 
        code "$AppFile"
    }
    catch {
        Write-Output "$ProjectName sln or app not found" 
    } 
}
