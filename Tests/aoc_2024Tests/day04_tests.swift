//
//  day04_tests.swift
//  aoc_2024
//
//  Created by Matt Brading on 04/12/2024.
//

import Testing

@testable import aoc_2024

@Suite("Day 4 Tests")
struct Day04Tests {
  let exampleInput = """
    MMMSXXMASM
    MSAMXMSMSA
    AMXSXMAAMM
    MSAMASMSMX
    XMASAMXAMM
    XXAMMXXAMA
    SMSMSASXSS
    SAXAMASAAA
    MAMMMXMMMM
    MXMXAXMASX
    """

  @Test func exampleInputPart1() async throws {
    let result = Day04().part1(input: exampleInput)

    #expect(result == 18)
  }

  @Test func exampleInputPart2() async throws {
    let result = Day04().part2(input: exampleInput)

    #expect(result == 9)
  }
}
