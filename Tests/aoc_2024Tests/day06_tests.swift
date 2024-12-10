//
//  day06_tests.swift
//  aoc_2024
//
//  Created by Matt Brading on 06/12/2024.
//

import Testing

@testable import aoc_2024

@Suite("Day 6 Tests")
struct Day06Tests {
  let exampleInput = """
    ....#.....
    .........#
    ..........
    ..#.......
    .......#..
    ..........
    .#..^.....
    ........#.
    #.........
    ......#...
    """

  @Test func exampleInputPart1() async throws {
    let result = Day06().part1(input: exampleInput)

    #expect(result == 41)
  }

  @Test func exampleInputPart2() async throws {
    let result = Day06().part2(input: exampleInput)

    #expect(result == 6)
  }
}
