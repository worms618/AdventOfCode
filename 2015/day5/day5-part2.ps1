# https://adventofcode.com/2015/day/5

$InputFilePath = "..\..\inputs\2015\day5\input.txt"

$NiceStrings = 0

function ContainsOneLetterRepeatingWithOneLetterInBetween {
    param([string]$value)

    for($i = 0; $i -lt $value.length - 2; $i++) {
        $currentChar = $value[$i]
        $nextNextChar = $value[$i + 2]

        #Write-Host $currentChar, $nextNextChar

        $charIsRepeated = $currentChar -eq $nextNextChar

        if ($charIsRepeated) {
            return $true
        }
    }

    return $false
}

function ContainsPairOfLettersRepeatedWithoutOverlap {
    param([string]$value)

    # Write-Host $value

    for($i = 0; $i -lt $value.length - 2; $i++) {
        $currentChar = $value[$i]
        $nextChar = $value[$i + 1]
        $nextPairIndex = $i + 2

        $pair = $currentChar + $nextChar
        #Write-Host $pair

        $PairOfLettersRepeated = ContainsPairOfLetters -value: $value -pairToFind: $pair -fromIndex: $nextPairIndex
        
        #Write-Host "PairOfLettersRepeated:", $PairOfLettersRepeated

        if ($PairOfLettersRepeated -eq $true) {
            return $true
        }
    }

    return $false
}

function ContainsPairOfLetters {
    param([string]$value, [string]$pairToFind, [int]$fromIndex)
    
    for($i = $fromIndex; $i -lt $value.length - 1; $i++) {
        $currentChar = $value[$i]
        $nextChar = $value[$i + 1]
        $pair = $currentChar + $nextChar

        #Write-Host $pairToFind, $pair

        if ($pairToFind -eq $pair) {
            return $true
        }
    }

    return $false
}

$InputContent = Get-Content -Path:$InputFilePath | ForEach-Object {
    $HasOneLetterRepeatingWithOneLetterInBetween = ContainsOneLetterRepeatingWithOneLetterInBetween -value: $_
    $HasPairOfLettersRepeatedWithoutOverlap = ContainsPairOfLettersRepeatedWithoutOverlap -value: $_

    #Write-Host $_
    #Write-Host "HasOneLetterRepeatingWithOneLetterInBetween:", $HasOneLetterRepeatingWithOneLetterInBetween, "|HasPairOfLettersRepeatedWithoutOverlap:", $HasPairOfLettersRepeatedWithoutOverlap

    if ($HasOneLetterRepeatingWithOneLetterInBetween -and $HasPairOfLettersRepeatedWithoutOverlap) {
        $NiceStrings = $NiceStrings + 1
    }
}

Write-Host "Nice strings:", $NiceStrings