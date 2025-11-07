# https://adventofcode.com/2015/day/5

$InputFilePath = "..\..\inputs\2015\day5\input.txt"

$NiceStrings = 0


$ForbiddenParts = @("ab", "cd", "pq", "xy")
$Vowels = @("a", "e", "i", "o", "u")

function ContainsForbiddenPart{
    param([string]$value)

    foreach($Part in $ForbiddenParts) {
        if ($Value -match $Part) {
            return $true
        }
    }

    return $false
}

function CountVowels{
    param([string]$value)

    $total = 0

    for($i = 0; $i -lt $value.length; $i++) {
        $character = $value[$i]

        if ($Vowels -contains $character) {
            $total++
        }
    }

    return $total    
}

function ContainsLetterTwiceInRow{
    param([string]$value)
    
    for($i = 0; $i -lt $value.length - 1; $i++) {
        $currentChar = $value[$i]
        $nextChar = $value[$i + 1]

        #Write-Host $currentChar, $nextChar

        if ($currentChar -eq $nextChar) {
            return $true
        }
    }

    return $false
}

$InputContent = Get-Content -Path:$InputFilePath | ForEach-Object {
    $Input = $_

    #Write-Host $Input

    $HasForbiddenPart = ContainsForbiddenPart -value: $Input
    #Write-Host "HasForbiddenPart:", $HasForbiddenPart

    if ($HasForbiddenPart -eq $false) {
        $TotalVowels = CountVowels -value: $Input
        #Write-Host "TotalVowels:", $TotalVowels

        $HasLetterTwiceInRow = ContainsLetterTwiceInRow -value: $Input
        #Write-Host "HasLetterTwiceInRow:", $HasLetterTwiceInRow

        $HasEnoughTotalVowels = $TotalVowels -ge 3
        #Write-Host "HasEnoughTotalVowels:", $HasEnoughTotalVowels

        if ($HasEnoughTotalVowels -and $HasLetterTwiceInRow) {
            $NiceStrings = $NiceStrings + 1
        }
    } else {
        $Forbid = $Forbid + 1;
    }
}

Write-Host "Nice strings:", $NiceStrings