//
//  day10_tests.swift
//  aoc_2024
//
//  Created by Matt Brading on 10/12/2024.
//

import Testing

@testable import aoc_2024

@Suite("Day 10 Tests")
struct Day10Tests {

  let exampleInput = """
    89010123
    78121874
    87430965
    96549874
    45678903
    32019012
    01329801
    10456732
    """

  @Test func exampleInputPart1() async throws {
    let result = Day10().part1(input: exampleInput)

    #expect(result == 36)
  }

  @Test func exampleInputPart2() async throws {
    let result = Day10().part2(input: exampleInput)

    #expect(result == 81)
  }
}
