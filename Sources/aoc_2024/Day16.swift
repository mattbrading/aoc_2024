//
//  Day16.swift
//  aoc_2024
//
//  Created by Matt Brading on 16/12/2024.
//
import ArgumentParser
import Collections

private enum Tile: Character {
  case wall = "#"
  case free = "."
}

private struct Position: Hashable, CustomStringConvertible {
  let row: Int
  let col: Int

  var description: String {
    "(\(row), \(col))"
  }
}

private struct PosDir: Hashable {
  let row: Int
  let col: Int
  let vRow: Int
  let vCol: Int
}

private struct Maze {
  let map: [[Tile]]

  let startPosition: Position
  let endPosition: Position

  func findPath() -> (Int, Set<Position>) {
    struct PathPoint: Comparable {
      static func < (lhs: PathPoint, rhs: PathPoint) -> Bool {
        lhs.cost < rhs.cost
      }

      static func == (lhs: PathPoint, rhs: PathPoint) -> Bool {
        lhs.cost == rhs.cost
      }

      let position: Position
      let direction: (Int, Int)
      let cost: Int
      let path: [Position]

    }

    var bestCost = Int.max

    var visitedPositions = Set<Position>()

    var foundCosts: [PosDir: Int] = [:]
    var possibilities: Heap<PathPoint> = [
      PathPoint(
        position: startPosition, direction: (0, 1), cost: 0,
        path: [startPosition])
    ]

    while !possibilities.isEmpty {
      let exploring = possibilities.popMin()!
      let cost = exploring.cost
      let pos = exploring.position
      let path = exploring.path

      let (vRow, vCol) = exploring.direction

      if cost > bestCost {
        break
      }

      let posDir = PosDir(row: pos.row, col: pos.col, vRow: vRow, vCol: vCol)

      if let lastCost = foundCosts[posDir] {
        if cost > lastCost {
          continue
        }
      }

      foundCosts[posDir] = cost

      if pos == endPosition {
        bestCost = cost
        path.forEach({ visitedPositions.insert($0) })
      }

      let directionRight = (-vCol, vRow)
      let directionLeft = (vCol, -vRow)

      let ahead = Position(row: pos.row + vRow, col: pos.col + vCol)

      if map[ahead.row][ahead.col] == .free {
        var newPath = path
        newPath.append(ahead)
        possibilities.insert(
          PathPoint(
            position: ahead, direction: exploring.direction, cost: cost + 1,
            path: newPath))
      }

      possibilities.insert(contentsOf: [
        PathPoint(
          position: pos, direction: directionLeft, cost: cost + 1000, path: path
        ),
        PathPoint(
          position: pos, direction: directionRight, cost: cost + 1000,
          path: path),
      ])
    }

    return (bestCost, visitedPositions)
  }

  static func fromString(input: String) -> Maze {
    var startPosition = Position(row: 0, col: 0)
    var endPosition = Position(row: 0, col: 0)

    let map = input.split(separator: "\n").enumerated().map { rowIdx, row in
      row.enumerated().map { colIdx, char in
        switch char {
        case "S":
          startPosition = Position(row: rowIdx, col: colIdx)
          return Tile.free

        case "E":
          endPosition = Position(row: rowIdx, col: colIdx)
          return Tile.free

        default:
          return Tile(rawValue: char)!
        }
      }
    }

    return Maze(
      map: map, startPosition: startPosition, endPosition: endPosition)
  }

}

struct Day16: AdventDay {
  @Argument var inputFile: String

  func part1(input: String) -> Int {
    let maze = Maze.fromString(input: input)

    let (cost, _) = maze.findPath()

    return cost
  }

  func part2(input: String) -> Int {
    let maze = Maze.fromString(input: input)
    let (_, visited) = maze.findPath()
    return visited.count
  }
}
