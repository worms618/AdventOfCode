# https://adventofcode.com/2015/day/1#part2

$InputFilePath = "..\..\inputs\2015\day1\input.txt"
$InputContent = Get-Content -Path:$InputFilePath

$Floor = 0
$PositionIntoBasement = 0;

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
    if ($Floor -eq -1) {
        $PositionIntoBasement = $i + 1
        break
    }
}

Write-Host "PositionIntoBasement:"$PositionIntoBasement
