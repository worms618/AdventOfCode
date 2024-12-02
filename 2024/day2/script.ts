import { readTextInputLines } from "../_utils/readinput.ts";
import { abs, inBoundsIncluding } from "../_utils/math.ts";

const part1RawReportLines = readTextInputLines(2, 1);
const part2RawReportLines = readTextInputLines(2, 2);

const part1ReportLines = getReportLines(part1RawReportLines);
const part2ReportLines = getReportLines(part2RawReportLines);

const safeReports = part1ReportLines.filter((reportLevels) => isSafeReport(reportLevels, 0)).length;
const safeReportsWithProblemDampener = part2ReportLines.filter((reportLevels) => isSafeReport(reportLevels, 1)).length;

console.log(`Part 1; Total safe reports: ${safeReports}`);
console.log(`Part 2; Total safe reports with problem dampener: ${safeReportsWithProblemDampener}`);

function getReportLines(rawLines: string[]): number[][] {
    return rawLines
        .map((rawReportLine) => rawReportLine.split(" "))
        .map((rawReportLevels) =>
            rawReportLevels.map((rawLevel) => parseInt(rawLevel))
        );
}

function isSafeReport(reportLevels: number[], badLevelTolerate: number): boolean {
    for (let i = 0; i < reportLevels.length; i++) {
        const firstPart = reportLevels.slice(0, i);
        const secondPart = reportLevels.slice(i + badLevelTolerate);

        const subset = firstPart.concat(secondPart);
        const isSafeReport = isSafesubSetOfReport(subset);

        if (isSafeReport) {
            return true;
        }
    }

    return false;
}

function isSafesubSetOfReport(reportLevels: number[]): boolean {
    let currentLevelIndex = 0;
    let nextLevelIndex = 1;

    const firstLevel = reportLevels[currentLevelIndex];
    const secondLevel = reportLevels[nextLevelIndex];
    let previousDifference = firstLevel - secondLevel;

    while (nextLevelIndex < reportLevels.length) {
        const currentLevel = reportLevels[currentLevelIndex];
        const nextLevel = reportLevels[nextLevelIndex];

        const levelDifference = currentLevel - nextLevel;
        const absoluteLevelDifference = abs(levelDifference);
        const levelsAreIncreasing = levelDifference < 0;
        const levelsWereIncreasing = previousDifference < 0;

        const levelDifferenceIsZero = (levelDifference === 0);
        const levelDifferenceNotInBounds = !inBoundsIncluding(absoluteLevelDifference, 1, 3);
        const levelsAreMovingWrongWay = levelsAreIncreasing !== levelsWereIncreasing;
        
        if (levelDifferenceIsZero || levelDifferenceNotInBounds || levelsAreMovingWrongWay)
            return false;
        
        currentLevelIndex = nextLevelIndex;
        nextLevelIndex++;
        previousDifference = levelDifference;
    }

    return true;
}
