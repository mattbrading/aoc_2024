//
//  day07_tests.swift
//  aoc_2024
//
//  Created by Matt Brading on 07/12/2024.
//

import Testing

@testable import aoc_2024

@Suite("Day 7 Tests")
struct Day07Tests {
  let exampleInput = """
    190: 10 19
    3267: 81 40 27
    83: 17 5
    156: 15 6
    7290: 6 8 6 15
    161011: 16 10 13
    192: 17 8 14
    21037: 9 7 18 13
    292: 11 6 16 20
    """

  @Test func exampleInputPart1() async throws {
    let result = Day07().part1(input: exampleInput)

    #expect(result == 3749)
  }

  @Test(arguments: [
    (190, [10, 19]),
    (20, [10, 10]),
    (3267, [81, 40, 27]),
    (292, [11, 6, 16, 20]),
  ]) func validEquations(result: Int, numbers: [Int]) {
    let result = Day07().isCalibrationPossible(result: result, numbers: numbers)

    #expect(result == true)
  }

  @Test(arguments: [
    (83, [17, 5]),
    (156, [15, 6]),
    (7290, [6, 8, 6, 15]),
    (161011, [16, 10, 13]),
    (192, [17, 8, 14]),
    (21037, [9, 7, 18, 13]),
  ]) func invalidEquations(result: Int, numbers: [Int]) {
    let result = Day07().isCalibrationPossible(result: result, numbers: numbers)

    #expect(result == false)
  }

  @Test func exampleInputPart2() async throws {
    let result = Day07().part2(input: exampleInput)

    #expect(result == 11387)
  }

  @Test(arguments: [
    (156, [15, 6]),
    (7290, [6, 8, 6, 15]),
    (192, [17, 8, 14]),
  ]) func validEquationsV2(result: Int, numbers: [Int]) {
    let result = Day07().isCalibrationPossibleV2(
      result: result, numbers: numbers)

    #expect(result == true)
  }

  @Test func concatNumbers() async throws {
    let result = Day07().concat(a: 123, b: 456)
    #expect(result == 123456)
  }
}
