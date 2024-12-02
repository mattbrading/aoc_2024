//
//  Test.swift
//  aoc_2024
//
//  Created by Matt Brading on 02/12/2024.
//

import Testing

@testable import aoc_2024

@Suite("Day 2 Tests")
struct Day2Tests {

  let exampleInput = """
      7 6 4 2 1
      1 2 7 8 9
      9 7 6 2 1
      1 3 2 4 5
      8 6 4 4 1
      1 3 6 7 9
    """

  @Test(arguments: [
    [1, 2, 3],
    [1, 2, 4],
    [3, 2, 1],
  ]) func checkReportSafe(_ report: [Int]) throws {
    let isSafe = Day2().isReportSafe(report: report)

    #expect(isSafe == true)
  }

  @Test(arguments: [
    [1, 1, 1],
    [1, 2, 6],
    [6, 2, 1],
    [1, 2, 1],
  ]) func checkReportsNotSafe(_ report: [Int]) throws {
    let isSafe = Day2().isReportSafe(report: report)

    #expect(isSafe == false)
  }

  @Test func checkExampleInputPart1() throws {
    let result = Day2().part1(input: exampleInput)

    #expect(result == 2)
  }

  @Test(arguments: [
    [1, 2, 6, 3],
    [6, 2, 1, 0],
    [1, 2, 1, 3],
    [1, 5, 4, 3, 2, 1],
    [5, 4, 3, 2, 1, 6],
    [10, 11, 10, 9, 8],
  ]) func checkReportsSafeWithDampener(_ report: [Int]) throws {
    let isSafe = Day2().isReportSafeWithProblemDampener(report: report)

    #expect(isSafe == true)
  }

  @Test(arguments: [
    [1, 1, 1, 1],
    [1, 4, 0, 1],
  ]) func checkReportsNotSafeWithDampener(_ report: [Int]) throws {
    let isSafe = Day2().isReportSafeWithProblemDampener(report: report)

    #expect(isSafe == false)
  }

  @Test func checkExampleInputPart2() throws {
    let result = Day2().part2(input: exampleInput)

    #expect(result == 4)
  }

}
