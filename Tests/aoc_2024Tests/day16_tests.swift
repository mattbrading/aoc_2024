//
//  day16_tests.swift
//  aoc_2024
//
//  Created by Matt Brading on 16/12/2024.
//

import Testing

@testable import aoc_2024

@Suite("Day 16 Tests")
struct Day16Tests {
  let example1 = """
    ###############
    #.......#....E#
    #.#.###.#.###.#
    #.....#.#...#.#
    #.###.#####.#.#
    #.#.#.......#.#
    #.#.#####.###.#
    #...........#.#
    ###.#.#####.#.#
    #...#.....#.#.#
    #.#.#.###.#.#.#
    #.....#...#.#.#
    #.###.#.#.#.#.#
    #S..#.....#...#
    ###############
    """

  let example2 = """
    #################
    #...#...#...#..E#
    #.#.#.#.#.#.#.#.#
    #.#.#.#...#...#.#
    #.#.#.#.###.#.#.#
    #...#.#.#.....#.#
    #.#.#.#.#.#####.#
    #.#...#.#.#.....#
    #.#.#####.#.###.#
    #.#.#.......#...#
    #.#.###.#####.###
    #.#.#...#.....#.#
    #.#.#.#####.###.#
    #.#.#.........#.#
    #.#.#.#########.#
    #S#.............#
    #################
    """

  @Test func exampleInputPart1() async throws {
    let result = Day16().part1(input: example1)

    #expect(result == 7036)
  }

  @Test func exampleInput2Part1() async throws {
    let result = Day16().part1(input: example2)

    #expect(result == 11048)
  }

  @Test func exampleInputPart2() async throws {
    let result = Day16().part2(input: example1)

    #expect(result == 45)
  }

  @Test func exampleInput2Part2() async throws {
    let result = Day16().part2(input: example2)

    #expect(result == 64)
  }
}
