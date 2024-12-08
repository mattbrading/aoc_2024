//
//  Day8.swift
//  aoc_2024
//
//  Created by Matt Brading on 08/12/2024.
//
import ArgumentParser

private struct Point: Hashable {
  let row: Int
  let col: Int
}

private struct AntennaeMap {
  let antennae: [Character: [Point]]
  let mapDimensions: (width: Int, height: Int)

  func isPointOnMap(point: Point) -> Bool {
    return (0..<mapDimensions.width).contains(point.col)
      && (0..<mapDimensions.height).contains(point.row)
  }

  func findAntiNodes() -> Set<Point> {
    var antiNodes: Set<Point> = []

    antennae.values.forEach({ group in

      group.forEach({ a1 in
        group.forEach({ a2 in

          if a1 == a2 { return }

          let xDiff = a2.col - a1.col
          let yDiff = a2.row - a1.row

          [
            Point(
              row: a1.row - yDiff,
              col: a1.col - xDiff
            ),
            Point(
              row: a2.row + yDiff,
              col: a2.col + xDiff
            ),
          ].forEach({ antiNode in

            if isPointOnMap(point: antiNode) {
              antiNodes.insert(antiNode)
            }

          })

        })
      })

    })

    return antiNodes
  }

  func findAntiNodesHarmonics() -> Set<Point> {
    var antiNodes: Set<Point> = []

    antennae.values.forEach({ group in

      group.forEach({ a1 in
        group.forEach({ a2 in

          if a1 == a2 { return }

          let xDiff = a2.col - a1.col
          let yDiff = a2.row - a1.row

          var antiNode = a1
          while isPointOnMap(point: antiNode) {
            antiNodes.insert(antiNode)

            antiNode = Point(
              row: antiNode.row - yDiff,
              col: antiNode.col - xDiff
            )

          }

          antiNode = a2

          while isPointOnMap(point: antiNode) {
            antiNodes.insert(antiNode)

            antiNode = Point(
              row: antiNode.row + yDiff,
              col: antiNode.col + xDiff
            )

          }
        })
      })

    })

    return antiNodes
  }

  static func fromString(input: String) -> AntennaeMap {
    var antennae: [Character: [Point]] = [:]

    let rows = input.split(separator: "\n")
    let height = rows.count
    let width = rows[0].count

    for (rowIdx, row) in rows.enumerated() {
      for (charIdx, char) in row.enumerated() {
        if char == "." { continue }

        if !antennae.keys.contains(char) {
          antennae[char] = []
        }

        antennae[char]?.append(Point(row: rowIdx, col: charIdx))
      }
    }

    return AntennaeMap(antennae: antennae, mapDimensions: (width, height))
  }

}

struct Day8: AdventDay {

  @Argument var inputFile: String

  func part1(input: String) -> Int {
    let map = AntennaeMap.fromString(input: input)

    return map.findAntiNodes().count
  }

  func part2(input: String) -> Int {
    let map = AntennaeMap.fromString(input: input)

    return map.findAntiNodesHarmonics().count
  }
}
