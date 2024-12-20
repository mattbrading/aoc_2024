//
//  DayWrapper.swift
//  aoc_2024
//
//  Created by Matt Brading on 01/12/2024.
//

import ArgumentParser
import Foundation

protocol AdventDay: ParsableCommand {
  var inputFile: String { get set }

  associatedtype Part1Result: CustomStringConvertible
  func part1(input: String) -> Part1Result

  associatedtype Part2Result: CustomStringConvertible
  func part2(input: String) -> Part2Result

}

extension AdventDay {

  mutating func run() throws {
    let inputFileURL = URL(fileURLWithPath: inputFile)
    let input = try String(contentsOf: inputFileURL)

    let clock = ContinuousClock()

    var part1result: Any?
    var part2result: Any?

    let part1time = clock.measure {
      part1result = part1(input: input)
    }

    let part2time = clock.measure {
      part2result = part2(input: input)
    }

    print("Part 1: \(part1result!), Time: \(part1time)")
    print("Part 2: \(part2result!), Time: \(part2time)")
  }

}
