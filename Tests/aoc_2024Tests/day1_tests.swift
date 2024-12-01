//
//  day1_tests.swift
//  aoc_2024
//
//  Created by Matt Brading on 01/12/2024.
//

import Testing

@testable import aoc_2024

@Suite("Day 1 Tests")
struct Day1Tests {

  let exampleInput = """
      3   4
      4   3
      2   5
      1   3
      3   9
      3   3
    """

  @Test func part1() async throws {
    let result = Day1().part1(input: exampleInput)

    #expect(result == 11)
  }

  @Test func simple_example_part1() async throws {
    let input = """
        0   1
        2   1
        1   1
      """

    let result = Day1().part1(input: input)

    #expect(result == 2)
  }

  @Test func part2() async throws {
    let result = Day1().part2(input: exampleInput)

    #expect(result == 31)
  }
}
