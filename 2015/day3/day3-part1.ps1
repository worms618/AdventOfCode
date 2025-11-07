# https://adventofcode.com/2015/day/3

$InputFilePath = ".\input.txt"
$InputContent = Get-Content -Path:$InputFilePath

$visitedHouses = [string[]]@("0,0")
$currentX = 0
$currentY = 0

for($i = 0; $i -lt $InputContent.length; $i++) {
    $Direction = $InputContent[$i]
    #Write-Host $Direction  

    if ($Direction -eq ">") {
        $currentX += 1
    }

    if ($Direction -eq "<") {
        $currentX -= 1
    }

    if ($Direction -eq "^") {
        $currentY -= 1
    }


    if ($Direction -eq "v") {
        $currentY += 1
    }

    $NewLocation = $currentX.ToString() + "," + $currentY.ToString()
    if ($visitedHouses -cnotcontains $NewLocation) {
        $visitedHouses += $NewLocation
    }
}

Write-Host "Total visited houses:", $visitedHouses.Length