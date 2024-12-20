//
//  day20_tests.swift
//  aoc_2024
//
//  Created by Matt Brading on 20/12/2024.
//

import Testing

@testable import aoc_2024

@Suite("Day 20 Tests")
struct Day20Tests {
  let exampleInput = """
    ###############
    #...#...#.....#
    #.#.#.#.#.###.#
    #S#...#.#.#...#
    #######.#.#.###
    #######.#.#...#
    #######.#.###.#
    ###..E#...#...#
    ###.#######.###
    #...###...#...#
    #.#####.#.###.#
    #.#...#.#.#...#
    #.#.#.#.#.#.###
    #...#...#...###
    ###############
    """

  @Test func exampleInputPart1() async throws {
    let result = Day20().findCheats(input: exampleInput, threshold: 20)

    #expect(result == 5)
  }

  @Test func exampleInputPart2() async throws {
    let result = Day20().findCheatsV2(input: exampleInput, threshold: 50)

    #expect(result == 285)
  }
}
