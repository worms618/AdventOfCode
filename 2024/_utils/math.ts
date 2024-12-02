export function abs(value: number): number {
    return value > 0 ? value : value * -1;
}

export function inBoundsIncluding(value: number, min: number, max: number): boolean {
    if (min > max)
        throw new Error(`Min(${min}) is greater than max(${max})`);

    return (min <= value) && (value <= max);
}