import ArgumentParser
//
//  Day5.swift
//  aoc_2024
//
//  Created by Matt Brading on 05/12/2024.
//
import Foundation

private struct PageUpdates {
  var rules: [Int: [Int]]
  var updates: [[Int]]

  func isUpdateValid(update: [Int]) -> Bool {
    update == sortUpdate(update: update)
  }

  func sortUpdate(update: [Int]) -> [Int] {
    update.sorted(by: { (left, right) in
      !(rules[right]?.contains(left) ?? false)
    })
  }

  func middlePage(update: [Int]) -> Int {
    let middle: Int = update.count / 2
    return update[middle]
  }

  static func fromString(input: String) -> PageUpdates {
    let stringParts = input.split(separator: "\n\n")

    let rulesStr = stringParts.first!
    let updatesStr = stringParts.last!

    let rules: [Int: [Int]] = rulesStr.split(separator: "\n")
      .reduce([:]) { partialResult, line in
        var result = partialResult
        let components =
          line
          .split(separator: "|")
          .compactMap { Int($0) }

        let lhs = components.first!
        let rhs = components.last!

        if result[lhs] == nil {
          result[lhs] = []
        }

        result[lhs]?.append(rhs)

        return result
      }

    let updates = updatesStr.split(separator: "\n")
      .map { line in
        line.split(separator: ",").compactMap { Int($0)! }
      }

    return PageUpdates(rules: rules, updates: updates)
  }

}

struct Day5: AdventDay {

  @Argument var inputFile: String

  func part1(input: String) -> Int {
    let pageUpdates = PageUpdates.fromString(input: input)

    return pageUpdates.updates.compactMap { update in
      let sorted = pageUpdates.sortUpdate(update: update)
      let middlePage = pageUpdates.middlePage(update: update)
      return sorted == update ? middlePage : nil
    }.reduce(0, { $0 + $1 })
  }

  func part2(input: String) -> Int {
    let pageUpdates = PageUpdates.fromString(input: input)

    return pageUpdates.updates.compactMap { update in
      let sorted = pageUpdates.sortUpdate(update: update)
      let middlePage = pageUpdates.middlePage(update: sorted)
      return sorted == update ? nil : middlePage
    }.reduce(0, { $0 + $1 })

  }
}
