//
//  Day2.swift
//  aoc_2024
//
//  Created by Matt Brading on 02/12/2024.
//

import ArgumentParser
import Foundation

struct Day2: AdventDay {

  @Argument var inputFile: String

  func part1(input: String) -> Int {
    input.split(separator: "\n")
      .count(where: { line in
        let report =
          line
          .components(separatedBy: .whitespaces)
          .compactMap({ Int($0) })
        return isReportSafe(report: report)
      })
  }

  func part2(input: String) -> Int {
    input.split(separator: "\n")
      .count(where: { line in
        let report =
          line
          .components(separatedBy: .whitespaces)
          .compactMap({ Int($0) })
        return isReportSafeWithProblemDampener(report: report)
      })
  }

  func isReportSafeWithProblemDampener(report: [Int]) -> Bool {
    let initialResult = isReportSafe(report: report)

    if initialResult == true {
      return true
    }

    for index in report.indices {

      var newReport = report
      newReport.remove(at: index)

      if isReportSafe(report: newReport) {
        return true
      }

    }

    return false

  }

  func isReportSafe(report: [Int]) -> Bool {

    let safeRange =
      report[0] > report[1] ? -3..<0 : 1..<4

    for index in report.indices {

      if index == 0 { continue }

      let level = report[index]
      let lastLevel = report[index - 1]

      if !safeRange.contains(level - lastLevel) {
        return false
      }

    }

    return true
  }
}
