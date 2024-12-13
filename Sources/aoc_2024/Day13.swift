//
//  Day13.swift
//  aoc_2024
//
//  Created by Matt Brading on 13/12/2024.
//

import ArgumentParser
import Foundation

struct Day13: AdventDay {
  @Argument var inputFile: String

  func findCheapestWin(
    aX: Int, aY: Int, bX: Int, bY: Int, X: Int, Y: Int, limit: Int
  ) -> (
    Int, Int
  )? {

    let a = (X * bY - Y * bX) / (aX * bY - aY * bX)
    let b = (X - aX * a) / bX

    if !(a <= limit && b <= limit) {
      return nil
    }

    if !(a * aX + b * bX == X && a * aY + b * bY == Y) {
      return nil
    }

    return (a, b)
  }

  func findTotalCoins(input: String, limit: Int = 100, offset: Int = 0) -> Int {
    let machines = input.split(separator: "\n\n")

    return machines.map { machineString in
      let matches: [Int] = machineString.matches(of: /[0-9]+/)
        .map { Int($0.output)! }

      guard
        let result = findCheapestWin(
          aX: matches[0], aY: matches[1], bX: matches[2], bY: matches[3],
          X: matches[4] + offset, Y: matches[5] + offset, limit: limit)
      else {
        return 0
      }

      return 3 * result.0 + result.1

    }.reduce(0, +)
  }

  func part1(input: String) -> Int {
    return findTotalCoins(input: input)
  }

  func part2(input: String) -> Int {
    return findTotalCoins(input: input, limit: .max, offset: 10_000_000_000_000)
  }
}
