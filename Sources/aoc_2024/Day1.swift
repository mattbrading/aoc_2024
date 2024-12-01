//
//  Day1.swift
//  aoc_2024
//
//  Created by Matt Brading on 01/12/2024.
//

import ArgumentParser
import Foundation

struct Day1: AdventDay {

  @Argument() var inputFile: String

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
