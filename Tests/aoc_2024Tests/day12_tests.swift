//
//  day12_tests.swift
//  aoc_2024
//
//  Created by Matt Brading on 12/12/2024.
//

import Testing

@testable import aoc_2024

@Suite("Day 12 Tests")
struct Day12Tests {
  let exampleInput = """
    RRRRIICCFF
    RRRRIICCCF
    VVRRRCCFFF
    VVRCCCJFFF
    VVVVCJJCFE
    VVIVCCJJEE
    VVIIICJJEE
    MIIIIIJJEE
    MIIISIJEEE
    MMMISSJEEE
    """

  @Test func exampleInputPart1() async throws {
    let result = Day12().part1(input: exampleInput)

    #expect(result == 1930)
  }
}
