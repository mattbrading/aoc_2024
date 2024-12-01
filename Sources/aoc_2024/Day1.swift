import ArgumentParser
//
//  Day1.swift
//  aoc_2024
//
//  Created by Matt Brading on 29/11/2024.
//
import Foundation

struct Day1: ParsableCommand {

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
    var leftList: [Int] = []
    var rightList: [Int] = []

    for line in input.split(separator: "\n") {
      let chunks = line.split(separator: "   ")
        .map({ Int($0.trimmingCharacters(in: .whitespaces))! })

      leftList.append(chunks.first!)
      rightList.append(chunks.last!)

    }

    let sortedLeft = leftList.sorted()
    let sortedRight = rightList.sorted()

    var total = 0

    for i in 0..<sortedLeft.count {
      total += abs(sortedLeft[i] - sortedRight[i])
    }

    return total
  }

  func part2(input: String) -> Int {
    var leftList: [Int] = []
    var rightList: [Int: Int] = [:]

    for line in input.split(separator: "\n") {
      let chunks = line.split(separator: "   ")
        .map({ Int($0.trimmingCharacters(in: .whitespaces))! })

      leftList.append(chunks.first!)

      let rhs: Int = chunks.last!

      if rightList[rhs] == nil {
        rightList[rhs] = 0
      }

      rightList[rhs]! += 1
    }

    var total = 0

    for lhs in leftList {

      let count = rightList[lhs] ?? 0

      total += count * lhs

    }

    return total
  }

}
