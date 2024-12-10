//
//  Day03.swift
//  aoc_2024
//
//  Created by Matt Brading on 03/12/2024.
//

import ArgumentParser
import Foundation

struct Day03: AdventDay {
  static let configuration = CommandConfiguration(commandName: "day3")

  @Argument var inputFile: String

  func part1(input: String) -> Int {
    let mulRegex = /mul\(([0-9]{1,3}),([0-9]{1,3})\)/

    return input.matches(of: mulRegex)
      .map { match in
        Int(match.output.1)! * Int(match.output.2)!
      }
      .reduce(0, +)

  }

  func part2(input: String) -> Int {
    let mulRegex =
      /(mul|do|don't)\(((?<a>[0-9]{1,3}),(?<b>[0-9]{1,3}))?\)/

    var enabled = true

    return input.matches(of: mulRegex)
      .map { match in

        let command = match.output.1

        switch (command, enabled) {
        case ("do", _):
          enabled = true
          return 0
        case ("don't", _):
          enabled = false
          return 0
        case ("mul", true):
          let a: Int = Int(match.output.a!)!
          let b: Int = Int(match.output.b!)!
          return a * b
        default:
          return 0
        }
      }
      .reduce(0, +)
  }

}
