//
//  day6_tests.swift
//  aoc_2024
//
//  Created by Matt Brading on 06/12/2024.
//

import Testing

@testable import aoc_2024

struct Day6Tests {
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
    let result = Day6().part1(input: exampleInput)

    #expect(result == 41)
  }

  @Test func exampleInputPart2() async throws {
    let result = Day6().part2(input: exampleInput)

    #expect(result == 6)
  }
}
