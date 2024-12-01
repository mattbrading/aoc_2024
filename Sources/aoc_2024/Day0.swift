import ArgumentParser
//
//  Day0.swift
//  aoc_2024
//
//  Created by Matt Brading on 29/11/2024.
//
import Foundation

struct Day0: ParsableCommand {

  @Argument() var inputFile: String

  mutating func run() throws {
    let inputFileURL = URL(fileURLWithPath: inputFile)
    let input = try String(contentsOf: inputFileURL)

    let clock = ContinuousClock()

    var part1result: Int?
    var part2result: Int?

    let part1time = clock.measure {
      part1result = part1(input: input)
    }

    let part2time = clock.measure {
      part2result = part2(input: input)
    }

    print("Part 1: \(part1result!), Time: \(part1time)")
    print("Part 2: \(part2result!), Time: \(part2time)")
  }

  func part1(input: String) -> Int {
    input.count
  }

  func part2(input: String) -> Int {
    input.count(where: { $0 == "o" })
  }

}
