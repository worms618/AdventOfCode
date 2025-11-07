# https://adventofcode.com/2015/day/6#part2

$InputFilePath = "..\..\AOCInputs\2015\day6\input.txt"

$lightsGrid = @{
    '0,0' = 0
}

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
            $rowValues = $lightsGrid[$row]

            #Write-Host $rowValues

            for($column = $startColumn; $column -le $endColumn; $column++) {
                $cellHash = $row.ToString() + ',' + $column.ToString()

                $currentValue = 0
                if ($lightsGrid.Contains($cellHash)) {
                    $currentValue = $lightsGrid[$cellHash]
                }

                $newValue = $currentValue

                if ($isTurnOn) {
                    $newValue++
                }
                
                if ($isTurnOff -and ($newValue -gt 0)) {
                    $newValue--
                }

                if ($isToggle) {
                    $newValue += 2
                }

                $lightsGrid[$cellHash] = $newValue
                #Write-Host $row, $column, $instruction, $currentValue, $rowValues[$column]
            }

            $lightsGrid[$row] = -join $rowValues
        }

        $totalInstructions++
        
    } 
}

Write-Host "Counting lights on..."

$totalBrightness = 0

foreach ($h in $lightsGrid.GetEnumerator()) {
    $value = $h.Value
    $totalBrightness += $value
}

Write-Host "Total brightness:", $totalBrightness