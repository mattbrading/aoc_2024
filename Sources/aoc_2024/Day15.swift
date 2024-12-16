//
//  Day15.swift
//  aoc_2024
//
//  Created by Matt Brading on 15/12/2024.
//

import ArgumentParser

private enum Tile: Character {
  case robot = "@"
  case wall = "#"
  case box = "O"
  case free = "."
  case boxL = "["
  case boxR = "]"
}

private enum Direction: Character, CustomStringConvertible {
  case up = "^"
  case down = "v"
  case left = "<"
  case right = ">"

  var description: String {
    return String(rawValue)
  }
}

private struct Warehouse: CustomStringConvertible {
  var map: [[Tile]]
  var robotPosition: (Int, Int)

  var description: String {
    map.map({ col in String(col.map({ tile in tile.rawValue })) }).joined(
      separator: "\n")
  }

  mutating func tryMove(direction: Direction, start: (Int, Int), commit: Bool)
    -> (Int, Int)?
  {
    let nextPosition: (Int, Int) =
      switch direction {
      case .up:
        (start.0 - 1, start.1)
      case .down:
        (start.0 + 1, start.1)
      case .left:
        (start.0, start.1 - 1)
      case .right:
        (start.0, start.1 + 1)
      }

    let nextTile = map[nextPosition.0][nextPosition.1]

    let canMove =
      switch (nextTile, direction) {
      case (.box, _), (.boxL, .left), (.boxL, .right), (.boxR, .left),
        (.boxR, .right):
        tryMove(direction: direction, start: nextPosition, commit: commit)
          != nil
      case (.boxL, .up), (.boxL, .down):
        tryMove(direction: direction, start: nextPosition, commit: commit)
          != nil
          && tryMove(
            direction: direction, start: (nextPosition.0, nextPosition.1 + 1),
            commit: commit) != nil
      case (.boxR, .up), (.boxR, .down):
        tryMove(direction: direction, start: nextPosition, commit: commit)
          != nil
          && tryMove(
            direction: direction, start: (nextPosition.0, nextPosition.1 - 1),
            commit: commit) != nil
      case (.free, _):
        true
      default:
        false
      }

    if canMove && commit {
      map[nextPosition.0][nextPosition.1] = map[start.0][start.1]
      map[start.0][start.1] = .free
    }

    return canMove ? nextPosition : nil
  }

  mutating func moveRobot(direction: Direction) {
    let newPosition = tryMove(
      direction: direction, start: robotPosition, commit: false)

    if let newPosition {
      _ = tryMove(direction: direction, start: robotPosition, commit: true)
      robotPosition = newPosition
    }

  }

  func getGpsScore() -> Int {
    return map.enumerated().reduce(
      0,
      { (total, row) in
        let (rowIdx, row) = row
        return total
          + row.enumerated().reduce(
            0,
            { subTotal, col in
              let (colIdx, tile) = col
              return subTotal
                + (tile == .box || tile == .boxL ? 100 * rowIdx + colIdx : 0)
            })
      })
  }

  static func fromString(from: String) -> Warehouse {
    var robotPosition: (Int, Int) = (0, 0)
    let map = from.split(separator: "\n")
      .enumerated().map({ rowIdx, row in
        row.enumerated().map({ colIdx, col in
          let tile = Tile(rawValue: col)!

          if tile == .robot {
            robotPosition = (rowIdx, colIdx)
          }

          return tile
        })
      })

    return Warehouse(map: map, robotPosition: robotPosition)
  }

  static func wideFromString(from: String) -> Warehouse {
    var robotPosition: (Int, Int) = (0, 0)
    let map = from.split(separator: "\n")
      .enumerated().map({ rowIdx, row in
        row.enumerated().flatMap({ colIdx, col -> [Tile] in
          let colIdx = colIdx * 2

          let tile = Tile(rawValue: col)!

          if tile == .robot {
            robotPosition = (rowIdx, colIdx)
          }

          return switch tile {
          case .wall:
            [Tile.wall, Tile.wall]
          case .free:
            [Tile.free, Tile.free]
          case .box:
            [Tile.boxL, Tile.boxR]
          case .robot:
            [Tile.robot, Tile.free]
          default:
            []
          }
        })
      })

    return Warehouse(map: map, robotPosition: robotPosition)
  }
}

struct Day15: AdventDay {
  @Argument var inputFile: String

  func part1(input: String) -> Int {

    let splitInput = input.split(separator: "\n\n")

    let warehouseString: String = String(splitInput[0])

    var warehouse = Warehouse.fromString(from: warehouseString)

    let directions: [Direction] = splitInput[1].compactMap({
      Direction(rawValue: $0)
    })

    directions.forEach { direction in
      warehouse.moveRobot(direction: direction)
    }

    return warehouse.getGpsScore()
  }

  func part2(input: String) -> Int {
    let splitInput = input.split(separator: "\n\n")

    let warehouseString: String = String(splitInput[0])

    var warehouse = Warehouse.wideFromString(from: warehouseString)

    let directions: [Direction] = splitInput[1].compactMap({
      Direction(rawValue: $0)
    })

    directions.forEach { direction in
      warehouse.moveRobot(direction: direction)
    }

    return warehouse.getGpsScore()
  }

}
