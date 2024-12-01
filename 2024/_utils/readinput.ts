import * as path from "jsr:@std/path";

export function readTextInput(day: number, part: number): string {
    const formatPath = path.format({
        root: "",
        dir: `..\\..\\inputs\\2024\\day${day}`,
        ext: ".txt",
        name: `part${part}`,
      });

    return Deno.readTextFileSync(formatPath);
}

export function readTextInputLines(day: number, part: number): string[] {
  const lineSeparator = '\r\n';
  const text = readTextInput(day, part);
  return text.split(lineSeparator);
}