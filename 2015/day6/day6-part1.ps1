# https://adventofcode.com/2015/day/6

$InputFilePath = "..\..\AOCInputs\2015\day6\input.txt"

$lightsGrid = [string[]]@("")

function initializeLightsGrid() {
    $grid = [string[]]@()

    for($row = 0; $row -le 1000 - 1; $row++) {
        $rowValue = ""

        #Write-Host "Row:", $row

        for($column = 0; $column -le 1000 - 1; $column++) {
            #Write-Host "Column:", $column

            $rowValue += "0"
        }

        $grid += $rowValue
    }

    return $grid
}

$lightsGrid = initializeLightsGrid

#$totalRows = $lightsGrid.Length
#$totalColumns = $lightsGrid[0].Length

#Write-Host "totalRows:", $totalRows
#Write-Host "totalColumns:", $totalColumns

$totalInstructions = 0

$instructionRegex = "(turn on|toggle|turn off)\s*(\w{1,3}),(\w{1,3})\s*through\s*(\w{1,3}),(\w{1,3})"

$InputContent = Get-Content -Path:$InputFilePath | ForEach-Object {
    if ($_ -match $instructionRegex) {
        Write-Host $totalInstructions, " -> running instruction", $_

        $instruction = $matches[1]
        
        $startColumn = [int]::Parse($matches[2])
        $startRow = [int]::Parse($matches[3])

        $endColumn = [int]::Parse($matches[4])
        $endRow = [int]::Parse($matches[5])

        $isTurnOn = $instruction -eq "turn on"
        $isToggle = $instruction -eq "toggle"
        $isTurnOff =$instruction -eq "turn off"

        for($row = $startRow; $row -le $endRow; $row++) {
            $rowValues = $lightsGrid[$row].ToCharArray()

            #Write-Host $rowValues

            for($column = $startColumn; $column -le $endColumn; $column++) {
                $currentValue = $rowValues[$column]
                $inverseValue = $currentValue
                $newValue = $currentValue

                if ($currentValue -eq "1") {
                    $inverseValue = "0"
                } else {
                    $inverseValue = "1"
                }

                if ($isTurnOn) {
                    $newValue = "1"
                }
                
                if ($isTurnOff) {
                    $newValue = "0"
                }

                if ($isToggle) {
                    $newValue = $inverseValue
                }

                $rowValues[$column] = $newValue
                #Write-Host $row, $column, $instruction, $currentValue, $rowValues[$column]
            }

            $lightsGrid[$row] = -join $rowValues
        }

        $totalInstructions++
        
    } 
}

Write-Host "Counting lights on..."

$totalLightsOn = 0

for($row = 0; $row -le 1000 - 1; $row++) {
    $rowValues = $lightsGrid[$row].ToCharArray()

    for($column = 0; $column -le 1000 - 1; $column++) {
        $currentValue = $rowValues[$column]

        if ($currentValue -eq "1") {
            $totalLightsOn++
        }
    }
}

Write-Host "Total lights on:", $totalLightsOn