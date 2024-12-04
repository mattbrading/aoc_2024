//
//  Day4.swift
//  aoc_2024
//
//  Created by Matt Brading on 04/12/2024.
//

import ArgumentParser

struct Point {
  var row: Int
  var col: Int

  static func + (lhs: Point, rhs: Point) -> Point {
    return Point(row: lhs.row + rhs.row, col: lhs.col + rhs.col)
  }
}

struct Grid {
  var grid: [[Character]]

  func findCharacterPoints(character: Character) -> [Point] {
    return grid.enumerated().flatMap { (row, line) in
      line.enumerated()
        .filter { (_, char) in
          char == character
        }
        .map { (col, _) in
          Point(row: row, col: col)
        }
    }
  }

  func getCharacter(point: Point) -> Character? {
    if !grid.indices.contains(point.row) {
      return nil
    }

    if !grid[point.row].indices.contains(point.col) {
      return nil
    }

    return grid[point.row][point.col]
  }

  static func fromString(string: String) -> Grid {
    return Grid(
      grid: string.split(separator: "\n")
        .map { Array($0) })
  }
}

struct Day4: AdventDay {

  @Argument var inputFile: String

  func part1(input: String) -> Int {

    let grid = Grid.fromString(string: input)

    let possibleStartPoints = grid.findCharacterPoints(character: "X")

    let directions: [Point] = [
      Point(row: -1, col: -1),
      Point(row: -1, col: 0),
      Point(row: -1, col: 1),
      Point(row: 0, col: -1),
      Point(row: 0, col: 1),
      Point(row: 1, col: -1),
      Point(row: 1, col: 0),
      Point(row: 1, col: 1),
    ]

    let matches = possibleStartPoints.flatMap { origin in
      directions.filter { direction in
        let potentialMatch = String(
          [
            origin + direction,
            origin + direction + direction,
            origin + direction + direction + direction,
          ].compactMap { grid.getCharacter(point: $0) })

        return potentialMatch == "MAS"
      }
    }

    return matches.count
  }

  func part2(input: String) -> Int {
    let grid = Grid.fromString(string: input)

    let possibleStartPoints = grid.findCharacterPoints(character: "A")

    let diagonals = [
      [
        Point(row: -1, col: -1),
        Point(row: 1, col: 1),
      ],
      [
        Point(row: -1, col: 1),
        Point(row: 1, col: -1),
      ],
    ]

    let matches = possibleStartPoints.filter { origin in
      diagonals.allSatisfy { corners in
        let potentialMatch = String(
          corners
            .compactMap({ grid.getCharacter(point: $0 + origin) }))

        return potentialMatch == "MS" || potentialMatch == "SM"
      }
    }

    return matches.count
  }
}
