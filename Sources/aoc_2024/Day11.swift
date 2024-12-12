//
//  Day11.swift
//  aoc_2024
//
//  Created by Matt Brading on 11/12/2024.
//
import ArgumentParser
import Foundation

private struct Stone: Hashable {
  let value: Int
  let depth: Int
}

private struct Stones {
  let stones: [Int]

  var cache: [Stone: Int] = [:]
  
  mutating func stoneCount(stone: Stone, maxDepth: Int)
    -> Int
  {

    if let cacheHit = cache[stone] {
      return cacheHit
    }

    if maxDepth == stone.depth { return 1 }

    if stone.value == 0 {
      let result = stoneCount(
        stone: Stone(value: 1, depth: stone.depth + 1), maxDepth: maxDepth)
      cache[stone] = result
      return result
    }

    let digitCount = Int(floor(log10(Double(stone.value)))) + 1

    if digitCount.isMultiple(of: 2) {
      let (l, r) = stone.value.quotientAndRemainder(
        dividingBy: Int(pow(Double(10), Double(digitCount / 2))))

      let result =
        stoneCount(
          stone: Stone(value: l, depth: stone.depth + 1), maxDepth: maxDepth)
        + stoneCount(
          stone: Stone(value: r, depth: stone.depth + 1), maxDepth: maxDepth)

      cache[stone] = result
      return result
    }

    let result = stoneCount(
      stone: Stone(value: stone.value * 2024, depth: stone.depth + 1),
      maxDepth: maxDepth)

    cache[stone] = result
    return result
  }

  mutating func blink(count: Int) -> Int {
    stones.reduce(
      0, { $0 + stoneCount(stone: Stone(value: $1, depth: 0), maxDepth: count) }
    )
  }

  static func fromString(input: String) -> Stones {
    return Stones(
      stones: input.components(separatedBy: .whitespaces).compactMap({
        Int($0)
      }))
  }

}

struct Day11: AdventDay {
  @Argument var inputFile: String

  func part1(input: String) -> Int {
    var stones = Stones.fromString(input: input)

    return stones.blink(count: 25)
  }

  func part2(input: String) -> Int {
    var stones = Stones.fromString(input: input)

    return stones.blink(count: 75)
  }

}
