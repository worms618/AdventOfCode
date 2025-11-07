# https://adventofcode.com/2015/day/2#part2

$InputFilePath = ".\input.txt"

$Total = 0

$InputContent = Get-Content -Path:$InputFilePath | ForEach-Object {
    $Dimensions = $_.ToString().Split('x')

    $length = [int]::Parse($Dimensions[0])
    $width = [int]::Parse($Dimensions[1])
    $height = [int]::Parse($Dimensions[2])

    $firstSmallestDimension = 0
    $SecondSmallestDimension = 0

    # Find two smallest dimensions
    if ($length -le $width) {
        $firstSmallestDimension = $length

        if ($width -le $height) {
            $SecondSmallestDimension = $width
        } else {
            $SecondSmallestDimension = $height
        }
    } else {
        $firstSmallestDimension = $width

        if ($length -le $height) {
            $SecondSmallestDimension = $length
        } else {
            $SecondSmallestDimension = $height
        }
    }
    
    $ribbon = (2 * $firstSmallestDimension) + (2 * $SecondSmallestDimension)
    $ribbonForBow = $length * $width * $height
    $totalRibbon = $ribbon + $ribbonForBow

    #Write-Host $ribbon, $ribbonForBow, $totalRibbon
    $Total += $totalRibbon
}

Write-Host "Total ribbon:"$Total