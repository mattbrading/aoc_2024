//
//  Day10.swift
//  aoc_2024
//
//  Created by Matt Brading on 10/12/2024.
//

import ArgumentParser

private struct Position: Hashable {
  let row: Int
  let col: Int
}

struct Day10: AdventDay {

  @Argument var inputFile: String

  private func findTrailPeaks(input: String) -> [[Position]] {
    let grid: [[Int]] =
      input
      .split(separator: "\n")
      .map { line in
        line.compactMap { $0.wholeNumberValue }
      }

    let trailheads: [Position] = grid.enumerated().flatMap({
      rowIdx, row in

      row.enumerated().compactMap({ colIdx, col in
        col == 0 ? Position(row: rowIdx, col: colIdx) : nil
      })
    })

    func isValidPosition(at: Position) -> Bool {
      return grid.indices.contains(at.row)
        && grid[at.row].indices.contains(at.col)
    }

    func findTrail(position: Position) -> [Position] {
      let row = position.row
      let col = position.col
      let currentVal = grid[row][col]

      if currentVal == 9 {
        return [position]
      }

      let neighbours: [Position] = [
        Position(row: row - 1, col: col),  // N
        Position(row: row + 1, col: col),  // S
        Position(row: row, col: col + 1),  // E
        Position(row: row, col: col - 1),  // W
      ].filter({
        isValidPosition(at: $0) && grid[$0.row][$0.col] == currentVal + 1
      })

      return neighbours.flatMap({ findTrail(position: $0) })
    }

    return trailheads.map { trailhead in
      findTrail(position: trailhead)
    }
  }

  func part1(input: String) -> Int {
    return findTrailPeaks(input: input).reduce(
      0,
      { total, peaks in
        total + Set(peaks).count
      })
  }

  func part2(input: String) -> Int {
    return findTrailPeaks(input: input).reduce(
      0,
      { total, peaks in
        total + peaks.count
      })
  }
}
