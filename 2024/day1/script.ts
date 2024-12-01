import { readTextInputLines } from "../_utils/readinput.ts";

const part1Lines = readTextInputLines(1, 1);
const part1 = parseInputLines(part1Lines);
part1.leftLocationIds.sort();
part1.rightLocationIds.sort();

let totalDistance = 0;

for(let i = 0; i < part1.leftLocationIds.length; i++) {
    let locationDistance = part1.leftLocationIds[i] - part1.rightLocationIds[i];
    locationDistance = locationDistance >= 0 ? locationDistance : locationDistance * -1;

    totalDistance += locationDistance;
}

console.log(`Part1 => Total distance: ${totalDistance}`);

const part2Lines = readTextInputLines(1, 2);
const part2 = parseInputLines(part2Lines);

const leftLocationIdsInRightList: Map<number, number> = new Map<number, number>();
part2.leftLocationIds.forEach(value => {
    leftLocationIdsInRightList.set(value, 0);
});
part2.rightLocationIds.forEach(value => {
    const currentTotalFound = leftLocationIdsInRightList.get(value);
    let newTotalFound = 0;

    if (currentTotalFound !== undefined)
        newTotalFound = currentTotalFound + 1;

    leftLocationIdsInRightList.set(value, newTotalFound);
});

let similarityScore = 0;
for(const leftLocationId of part2.leftLocationIds) {
    const totalFound = leftLocationIdsInRightList.get(leftLocationId)!;
    const similarity = leftLocationId * totalFound;
    similarityScore += similarity;
}

console.log(`Part2 => Similarity score: ${similarityScore}`);

function parseInputLines(lines: string[]): {
    leftLocationIds: number[],
    rightLocationIds: number[]
} {
   const result: {
    leftLocationIds: number[],
    rightLocationIds: number[]    
   } = {
    leftLocationIds: [],
    rightLocationIds: []
   };
    
    for (const line of lines) {
        const locationIds = line.split(' ').filter(value => value.trim().length > 0);
        const leftLocationIdAsString = locationIds[0];
        const rightLocationIdsAsString = locationIds[1];
    
        const leftLocationId = parseInt(leftLocationIdAsString);
        const rightLocationId = parseInt(rightLocationIdsAsString);
    
        result.leftLocationIds.push(leftLocationId);
        result.rightLocationIds.push(rightLocationId);
    }

    return result;
}