# https://adventofcode.com/2015/day/1

$InputFilePath = ".\input.txt"
$InputContent = Get-Content -Path:$InputFilePath

$Floor = 0

for($i = 0; $i -lt $InputContent.length; $i++) {
    $Direction = $InputContent[$i]
    #Write-Host $Direction

    if ($Direction -eq '(') {
        $Floor = $Floor + 1;
    }
    else {
        $Floor = $Floor - 1;
    }
    #Write-Host $Floor
}

Write-Host "Floor:"$Floor
