import { readTextInput } from "../_utils/readinput.ts";

const part1Rawtext = readTextInput(3, 1).trim();
const part2Rawtext = readTextInput(3, 2).trim();

const getMultiplyInstructionsRegex = /(mul\((\d{0,3}),(\d{0,3})\))/gm;
const mulInstructionsMatches = part1Rawtext.matchAll(getMultiplyInstructionsRegex);
if (mulInstructionsMatches === null)
    throw new Error('No multiply only instructions found');

const getMultiplyAndConditionInstructions = /(mul\((\d{0,3}),(\d{0,3})\)|(don't\(\))|(do\(\)))/gm;
const multiplyAndConditionInstructionsMatches = part2Rawtext.matchAll(getMultiplyAndConditionInstructions);
if (multiplyAndConditionInstructionsMatches === null)
    throw new Error('No multiply en condition instructions found');

const sumOfMulInstructions = mulInstructionsMatches.reduce<number>(sumMultiplyInstructions, 0);

let doAddMultiplyInstructions = true;
const sumOfAllowedMultiplyInstructions = multiplyAndConditionInstructionsMatches.reduce<number>(sumAllowedMultiplyInstructions, 0);

console.log(`Part 1: Sum of multiply instructions: ${sumOfMulInstructions}`);
console.log(`Part 2: Sum of multiply instructions: ${sumOfAllowedMultiplyInstructions}`);

function sumMultiplyInstructions(previous: number, instruction: RegExpExecArray): number {
    const instructionValue = executeMultiplyInstruction(instruction);
    return previous + instructionValue;
}

function sumAllowedMultiplyInstructions(previous: number, instruction: RegExpExecArray): number {
    const instructionValue = instruction[0].toLowerCase();
    if (instructionValue.startsWith('mul') && doAddMultiplyInstructions) {
        const instructionValue = executeMultiplyInstruction(instruction);
        return previous + instructionValue;    
    } {
        doAddMultiplyInstructions = instructionValue === 'do()'

        return previous;
    }
}

function executeMultiplyInstruction(instruction: RegExpExecArray): number {
    if (instruction.length < 4)
        return 0;

    const leftExpressionText = instruction[2];
    const rightExpressionText = instruction[3];

    const leftExpression = parseInt(leftExpressionText);
    const rightExpression = parseInt(rightExpressionText);

    return leftExpression * rightExpression;
}