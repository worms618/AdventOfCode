#https://adventofcode.com/2015/day/3#part2

$InputFilePath = "..\..\inputs\2015\day3\input.txt"
$InputContent = Get-Content -Path:$InputFilePath

function MoveLocation($Direction, $CurrentLocation) {
    $currentX = $CurrentLocation.X
    $currentY = $CurrentLocation.Y

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

    $CurrentLocation.X = $currentX
    $CurrentLocation.y = $currentY
    return $CurrentLocation
}

$visitedHouses = [string[]]@("0,0")
$SantaLocation = [PSCustomObject]@{
    X = 0
    Y = 0
}

$RoboSantaLocation = [PSCustomObject]@{
    X = 0
    Y = 0
}

$SantaToMove = $true

for($i = 0; $i -lt $InputContent.length; $i++) {
    $Direction = $InputContent[$i]

    if ($SantaToMove) {
        $LocationToCheck = MoveLocation -Direction:$Direction -CurrentLocation:$SantaLocation
    } else {
        $LocationToCheck = MoveLocation -Direction:$Direction -CurrentLocation:$RoboSantaLocation
    }

    $SantaToMove = -not $SantaToMove

    # Write-Host $SantaToMove, $LocationToCheck

    $NewLocation = $LocationToCheck.X.ToString() + "," + $LocationToCheck.Y.ToString()
    if ($visitedHouses -cnotcontains $NewLocation) {
        $visitedHouses += $NewLocation
    }
}

Write-Host "Total visited houses:", $visitedHouses.Length
