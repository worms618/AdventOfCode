# https://adventofcode.com/2015/day/2

$InputFilePath = "..\..\inputs\2015\day2\input.txt"

$Total = 0

$InputContent = Get-Content -Path:$InputFilePath | ForEach-Object {
    $Dimensions = $_.ToString().Split('x')
    $length = [int]::Parse($Dimensions[0])
    $width = [int]::Parse($Dimensions[1])
    $height = [int]::Parse($Dimensions[2])

    $side1 = $length * $width
    $side2 = $width * $height
    $side3 = $height * $length

    $AllSide = $side1, $side2, $side3

    $smallestSide = ($AllSide | Measure-Object -Minimum).Minimum

    $squareFeetForBox = (2 * $side1) + (2 * $side2) + (2 * $side3) + $smallestSide

    #Write-Host $squareFeetForBox
    $Total += $squareFeetForBox
}

Write-Host "Total:"$Total