//
//  Day18.swift
//  aoc_2024
//
//  Created by Matt Brading on 18/12/2024.
//

import ArgumentParser

private struct Point: Hashable {
  let row: Int
  let col: Int
}

struct Day18: AdventDay {
  @Argument var inputFile: String

  func findPath(input: String, bytes: Int, width: Int) -> Int {
    var map: [[Bool]] = Array(
      repeating: Array(repeating: false, count: width + 1), count: width + 1)

    input.split(separator: "\n")[0..<bytes].forEach({ bytePos in
      let xY = bytePos.split(separator: ",")
      let x = Int(xY[0])!
      let y = Int(xY[1])!

      map[y][x] = true
    })

    var possibilities: [(Point, Int, Int)] = [
      (Point(row: 0, col: 0), 0, 2 * width)
    ]
    var visited = Set<Point>()
    let endPosition = Point(row: width, col: width)
    let validRange = 0..<(width + 1)

    while !possibilities.isEmpty {
      let (currentSpace, stepCount, _) = possibilities.removeFirst()

      if visited.contains(currentSpace) { continue }

      if currentSpace == endPosition {
        return stepCount
      }

      [
        Point(row: currentSpace.row - 1, col: currentSpace.col),
        Point(row: currentSpace.row + 1, col: currentSpace.col),
        Point(row: currentSpace.row, col: currentSpace.col + 1),
        Point(row: currentSpace.row, col: currentSpace.col - 1),
      ].forEach({ next in
        if validRange.contains(next.row) && validRange.contains(next.col) {
          if !map[next.row][next.col] && !visited.contains(next) {
            let h =
              stepCount + 1 + endPosition.row - next.row + endPosition.col
              - next.col
            possibilities.append((next, stepCount + 1, h))
          }
        }
      })

      visited.insert(currentSpace)
      possibilities.sort(by: { $0.2 < $1.2 })
    }

    return 0
  }

  func firstBlockingByte(input: String, width: Int) -> String {
    let bytes = input.split(separator: "\n").count

    var searchRange = 0..<bytes

    while !searchRange.isEmpty {
      let midPoint = searchRange.lowerBound + searchRange.count / 2

      let pathFound = findPath(input: input, bytes: midPoint, width: width) != 0

      switch pathFound {

      case true:
        if midPoint + 1 == searchRange.upperBound {
          let lastByte = input.split(separator: "\n")[midPoint]
          return String(lastByte)
        }

        searchRange = (midPoint + 1)..<searchRange.upperBound

      case false:
        if midPoint == searchRange.lowerBound {
          let lastByte = input.split(separator: "\n")[midPoint - 1]
          return String(lastByte)
        }
        searchRange = searchRange.lowerBound..<midPoint
      }
    }

    return ""
  }

  func part1(input: String) -> Int {
    return findPath(input: input, bytes: 1024, width: 70)
  }

  func part2(input: String) -> String {
    return firstBlockingByte(input: input, width: 70)
  }

}
