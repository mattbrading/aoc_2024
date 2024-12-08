//
//  Day6.swift
//  aoc_2024
//
//  Created by Matt Brading on 06/12/2024.
//
import ArgumentParser

private struct Tile: Hashable {
  var row: Int
  var col: Int
  var obsticle: Bool
}

private enum Direction {
  case north
  case south
  case east
  case west
}

private struct Map {
  var rows: [[Tile]]
  var guardLocation: Tile
  var visited = Set<Tile>()

  func getTile(row: Int, col: Int) -> Tile? {
    if rows.indices.contains(row) {
      if rows[row].indices.contains(col) {
        return rows[row][col]
      }
    }

    return nil
  }

  func nextTile(start: Tile, direction: Direction) -> Tile? {
    return switch direction {
    case .north:
      getTile(row: start.row - 1, col: start.col)
    case .south:
      getTile(row: start.row + 1, col: start.col)
    case .east:
      getTile(row: start.row, col: start.col + 1)
    case .west:
      getTile(row: start.row, col: start.col - 1)
    }
  }

  func nextDirection(direction: Direction) -> Direction {
    switch direction {
    case .north:
      .east
    case .south:
      .west
    case .east:
      .south
    case .west:
      .north
    }
  }

  func travel()
    -> Set<Tile>
  {
    var tile = guardLocation
    var direction = Direction.north
    var visited = visited

    while true {
      visited.insert(tile)

      let nextTile: Tile? = nextTile(start: tile, direction: direction)

      guard let nextTile else {
        return visited
      }

      if nextTile.obsticle {
        direction = nextDirection(direction: direction)
        continue
      }
      tile = nextTile
    }

  }

  func isLoop()
    -> Bool
  {
    var tile = guardLocation
    var visited: [Tile: Set<Direction>] = [:]
    var direction = Direction.north

    while true {

      let nextTile: Tile? = nextTile(start: tile, direction: direction)

      guard let nextTile else {
        return false
      }

      if nextTile.obsticle == false {
        tile = nextTile
        continue
      }

      direction = nextDirection(direction: direction)

      visited[tile] = visited[tile] ?? []

      if visited[tile]!.contains(direction) {
        return true
      }

      visited[tile]!.insert(direction)
    }
  }

  func findPossibleLoops()
    -> Int
  {
    let tiles = travel()

    return tiles.enumerated().count { idx, tile in
      if tile == guardLocation {
        return false
      }

      var newMap = self

      newMap.rows[tile.row][tile.col].obsticle = true

      return newMap.isLoop()
    }
  }

  static func fromString(input: String) -> Map {
    var guardLocation: Tile?
    let rows: [[Tile]] = input.split(separator: "\n")
      .enumerated()
      .map { (rowIndex, row) in
        Array(row).enumerated().map { (colIndex, char) in

          let tile = Tile(row: rowIndex, col: colIndex, obsticle: char == "#")

          if char == "^" {
            guardLocation = tile
          }

          return tile
        }
      }

    return Map(rows: rows, guardLocation: guardLocation!)
  }

}

struct Day6: AdventDay {
  @Argument var inputFile: String

  func part1(input: String) -> Int {

    let map = Map.fromString(input: input)

    return map.travel().count
  }

  func part2(input: String) -> Int {
    let map = Map.fromString(input: input)

    let loopPoints = map.findPossibleLoops()

    return loopPoints
  }
}
