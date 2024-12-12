//
//  Day12.swift
//  aoc_2024
//
//  Created by Matt Brading on 12/12/2024.
//

import ArgumentParser

private struct Position: Hashable, CustomStringConvertible {
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

  var description: String {
    "(\(row), \(col))"
  }
}

private struct Area: CustomStringConvertible {
  let char: Character
  let area: Int
  let perimeter: Int

  var cost: Int { area * perimeter }

  var description: String {
    "\(char): \(area) * \(perimeter) = \(cost) "
  }
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

    let perimeter = cells.reduce(
      0,
      { total, position in

        let nonBoundrySides = position.neighbours.count(where: {
          getPlot(position: $0) == char
        })

        return total
          + (4
            - nonBoundrySides)
      })

    return Area(char: char, area: area, perimeter: perimeter)
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
    return 0
  }
}
