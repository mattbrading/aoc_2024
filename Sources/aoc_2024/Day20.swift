//
//  Day20.swift
//  aoc_2024
//
//  Created by Matt Brading on 20/12/2024.
//
import ArgumentParser

private struct Position: Hashable, CustomStringConvertible {
  let row: Int
  let col: Int

  var description: String {
    "(\(row), \(col))"
  }
}

private struct RaceTrack {
  let map: [[Bool]]
  let startPosition: Position
  let endPosition: Position
  let width: Int
  let height: Int

  func getNeighbours(pos: Position) -> [Position] {
    return [
      Position(row: pos.row - 1, col: pos.col),
      Position(row: pos.row + 1, col: pos.col),
      Position(row: pos.row, col: pos.col + 1),
      Position(row: pos.row, col: pos.col - 1),
    ].filter({ neighbour in
      (0..<height).contains(neighbour.row)
        && (0..<width).contains(neighbour.col)
    })
  }

  func findPath() -> [Position: Int] {

    var visited: [Position: Int] = [:]
    var position = startPosition
    var time = 0

    while position != endPosition {
      visited[position] = time

      position =
        getNeighbours(pos: position).filter({ newPosition in
          !visited.keys.contains(newPosition)
            && map[newPosition.row][newPosition.col]
        })[0]

      time += 1
    }

    visited[endPosition] = time

    return visited
  }

  static func fromString(from: String) -> RaceTrack {
    var startPosition: Position = Position(row: 0, col: 0)
    var endPosition: Position = Position(row: 0, col: 0)

    let map: [[Bool]] = from.split(separator: "\n").enumerated().map({
      rowIdx, row in
      row.enumerated().map({ colIdx, tile in
        if tile == "S" {
          startPosition = Position(row: rowIdx, col: colIdx)
        }

        if tile == "E" {
          endPosition = Position(row: rowIdx, col: colIdx)
        }

        return tile != "#"
      })
    })

    let width = map[0].count
    let height = map.count

    return RaceTrack(
      map: map, startPosition: startPosition, endPosition: endPosition,
      width: width, height: height)

  }

}

struct Day20: AdventDay {
  @Argument var inputFile: String

  func findCheats(input: String, threshold: Int) -> Int {
    let map = RaceTrack.fromString(from: input)

    let path = map.findPath()

    var cheatCount = 0

    for (position, time) in path {
      map.getNeighbours(pos: position).forEach({ neighbour in
        if !map.map[neighbour.row][neighbour.col] {
          map.getNeighbours(pos: neighbour).forEach({ nextNeighbour in
            if let previousTime = path[nextNeighbour] {
              if time - previousTime - 2 >= threshold {
                cheatCount += 1
              }
            }
          })
        }
      })
    }

    return cheatCount
  }

  func findCheatsV2(input: String, threshold: Int) -> Int {
    let map = RaceTrack.fromString(from: input)

    let path = map.findPath()

    var cheatCount = 0

    for (pos, time) in path {
      var neighbours: Set<Position> = Set()

      (0..<21).forEach({ row in
        (0..<(21 - row)).forEach({ col in
          [
            Position(row: pos.row + row, col: pos.col + col),
            Position(row: pos.row + row, col: pos.col - col),
            Position(row: pos.row - row, col: pos.col + col),
            Position(row: pos.row - row, col: pos.col - col),
          ].forEach({ neighbour in
            if (0..<map.height).contains(neighbour.row)
              && (0..<map.width).contains(neighbour.col)
            {
              neighbours.insert(neighbour)
            }
          })
        })
      })

      neighbours.forEach({ neighbour in
        let distance =
          abs(neighbour.row - pos.row) + abs(neighbour.col - pos.col)
        if let previousTime = path[neighbour] {
          if time - previousTime - distance >= threshold {
            cheatCount += 1
          }
        }
      })
    }

    return cheatCount
  }

  func part1(input: String) -> Int {
    return findCheats(input: input, threshold: 100)
  }

  func part2(input: String) -> Int {
    return findCheatsV2(input: input, threshold: 100)
  }
}
