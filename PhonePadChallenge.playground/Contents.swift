extension Int {
    func decimalLeftShift(positions: Int) -> Int {
        return self * Int.pow(10, positions)
    }
    
    static func pow(_ base: Int, _ exp: Int) -> Int {
        var result = 1
        for _ in 0 ..< exp {
            result *= base
        }
        return result
    }
}

let phonePad = [
    [1, 2, 3],
    [4, 5, 6],
    [7, 8, 9],
    [nil, 0, nil]
]

func traversePhonePad(
    number: Int,
    depth: Int,
    depthCounter: Int = 0,
    previousLevelPrefix: Int = 0,
    results: [Int] = [Int]()
) -> [Int] {
    guard depth > 0 else {
        return []
    }
    
    let currentLevelPrefix = previousLevelPrefix
        + number.decimalLeftShift(positions: depth - (depthCounter + 1))

    var mutableResults = [Int]()
    mutableResults.append(contentsOf: results)
    if depthCounter == depth - 1 {
        mutableResults.append(currentLevelPrefix)
        return mutableResults
    }
    
    phonePadNumbersAdjacentTo(number).map {
        (number) -> Void in
        
        mutableResults = traversePhonePad(
            number: number,
            depth: depth,
            depthCounter: depthCounter + 1,
            previousLevelPrefix: currentLevelPrefix,
            results: mutableResults
        )
    }
    
    return mutableResults
}

func phonePadNumbersAdjacentTo(_ number: Int) -> [Int] {
    guard let row = phonePad.first(where: { (row) -> Bool in
        return row.contains(number)
    }) else {
        return []
    }
    
    let rowIndex = phonePad.firstIndex(of: row)!
    let columnIndex = row.firstIndex(of: number)!
    
    var adjacentNumbers = [Int]()
    
    if columnIndex > 0, let numberOnLeft = row[columnIndex - 1] {
        adjacentNumbers.append(numberOnLeft)
    }
    
    if rowIndex < phonePad.count - 1,
        let numberBelow = phonePad[rowIndex + 1][columnIndex] {
        adjacentNumbers.append(numberBelow)
    }
    
    if columnIndex < row.count - 1, let numberOnRight = row[columnIndex + 1] {
        adjacentNumbers.append(numberOnRight)
    }
    
    if rowIndex > 0, let numberAbove = phonePad[rowIndex - 1][columnIndex] {
        adjacentNumbers.append(numberAbove)
    }
    
    return adjacentNumbers
}

// Examples:

print("f(5, 1) = \(traversePhonePad(number: 5, depth: 1))")
print("f(1, 3) = \(traversePhonePad(number: 1, depth: 3))")
print("f(2, 4) = \(traversePhonePad(number: 2, depth: 4))")
