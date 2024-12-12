//
//  Day12.swift
//  aoc_2024
//
//  Created by Matt Brading on 12/12/2024.
//

import ArgumentParser

private struct Position: Hashable {
  let row: Int
  let col: Int

  var neighbours: [Position] {
    return [
      Position(row: row - 1, col: col),
      Position(row: row + 1, col: col),
      Position(row: row, col: col + 1),
      Position(row: row, col: col - 1),
    ]
  }
}

private struct Area {
  let char: Character
  let area: Int
  let perimeter: Int
  let sides: Int

  var cost: Int { area * perimeter }
  var bulkCost: Int { area * sides }
}

private struct Garden: CustomStringConvertible {
  let map: [[Character]]
  let width: Int
  let height: Int

  var visited = Set<Position>()

  var description: String {
    map.map({ String($0) }).joined(separator: "\n")
  }

  func getPlot(position: Position) -> Character? {
    let isValidPlot =
      ((0..<height).contains(position.row))
      && ((0..<width).contains(position.col))
    return isValidPlot ? map[position.row][position.col] : nil
  }

  mutating func findNeighbours(pos: Position, char: Character) -> [Position] {
    var neighbours = [pos]
    for neighbour in pos.neighbours {
      if !visited.contains(neighbour) && getPlot(position: neighbour) == char {
        visited.insert(neighbour)
        neighbours.append(
          contentsOf: findNeighbours(pos: neighbour, char: char))
      }
    }
    return neighbours
  }

  mutating func getArea(start: Position, char: Character) -> Area {
    let cells = findNeighbours(pos: start, char: char)

    let area = cells.count

    var horizontalSides: [Int: [Int]] = [:]
    var verticalSides: [Int: [Int]] = [:]

    var perimeter = 0

    cells.forEach { cell in
      var nonBoundrySides = 4

      for neighbour in cell.neighbours {
        if getPlot(position: neighbour) == char {
          nonBoundrySides -= 1
          continue
        }

        switch (neighbour.row, neighbour.col) {
        case (cell.row, _):
          let virtualCol =
            neighbour.col > cell.col ? (cell.col * 4) + 1 : (cell.col * 4) - 1

          if !verticalSides.keys.contains(virtualCol) {
            verticalSides[virtualCol] = []
          }
          verticalSides[virtualCol]?.append(neighbour.row)

        case (_, cell.col):
          let virtualRow =
            neighbour.row > cell.row ? (cell.row * 4) + 1 : (cell.row * 4) - 1
          if !horizontalSides.keys.contains(virtualRow) {
            horizontalSides[virtualRow] = []
          }
          horizontalSides[virtualRow]?.append(neighbour.col)

        default:
          continue
        }
      }

      perimeter += nonBoundrySides
    }

    var sides = 0

    for (_, vSides) in verticalSides {
      let sorted = vSides.sorted()
      let foundSides =
        sorted.enumerated().count(where: { idx, pos in
          (idx + 1 < sorted.count) && sorted[idx + 1] != pos + 1
        }) + 1
      sides += foundSides
    }

    for (_, hSides) in horizontalSides {
      let sorted = hSides.sorted()
      let foundSides =
        sorted.enumerated().count(where: { idx, pos in
          (idx + 1 < sorted.count) && sorted[idx + 1] != pos + 1
        }) + 1
      sides += foundSides
    }

    return Area(char: char, area: area, perimeter: perimeter, sides: sides)
  }

  mutating func findAreas() -> [Area] {
    var areas: [Area] = []
    map.enumerated().forEach({ rowIdx, row in
      row.enumerated().forEach({ colIdx, col in
        let position = Position(row: rowIdx, col: colIdx)
        if !visited.contains(position) {
          visited.insert(position)
          let area = getArea(start: position, char: col)
          areas.append(area)
        }
      })
    })

    return areas
  }

  static func fromString(from: String) -> Garden {
    let rows = from.split(separator: "\n")
    let height = rows.count
    let width = rows[0].count

    let map: [[Character]] =
      rows
      .map { Array($0) }

    return Garden(
      map: map,
      width: width,
      height: height
    )
  }
}

struct Day12: AdventDay {
  @Argument var inputFile: String

  func part1(input: String) -> Int {
    var garden = Garden.fromString(from: input)

    let areas = garden.findAreas()

    return areas.reduce(
      0,
      { total, area in
        return total + area.cost
      })
  }

  func part2(input: String) -> Int {
    var garden = Garden.fromString(from: input)

    let areas = garden.findAreas()

    return areas.reduce(
      0,
      { total, area in
        return total + area.bulkCost
      })
  }
}
