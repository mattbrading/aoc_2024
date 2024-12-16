//
//  day15_tests.swift
//  aoc_2024
//
//  Created by Matt Brading on 15/12/2024.
//

import Testing

@testable import aoc_2024

@Suite("Day 15 Tests")
struct Day15Tests {

  let complexExample = """
    ##########
    #..O..O.O#
    #......O.#
    #.OO..O.O#
    #..O@..O.#
    #O#..O...#
    #O..O..O.#
    #.OO.O.OO#
    #....O...#
    ##########

    <vv>^<v^>v>^vv^v>v<>v^v<v<^vv<<<^><<><>>v<vvv<>^v^>^<<<><<v<<<v^vv^v>^
    vvv<<^>^v^^><<>>><>^<<><^vv^^<>vvv<>><^^v>^>vv<>v<<<<v<^v>^<^^>>>^<v<v
    ><>vv>v^v^<>><>>>><^^>vv>v<^^^>>v^v^<^^>v^^>v^<^v>v<>>v^v^<v>v^^<^^vv<
    <<v<^>>^^^^>>>v^<>vvv^><v<<<>^^^vv^<vvv>^>v<^^^^v<>^>vvvv><>>v^<<^^^^^
    ^><^><>>><>^^<<^^v>>><^<v>^<vv>>v>>>^v><>^v><<<<v>>v<v<v>vvv>^<><<>^><
    ^>><>^v<><^vvv<^^<><v<<<<<><^v<<<><<<^^<v<^^^><^>>^<v^><<<^>>^v<v^v<v^
    >^>>^v>vv>^<<^v<>><<><<v<<v><>v<^vv<<<>^^v^>^^>>><<^v>>v^v><^^>>^<>vv^
    <><^^>^^^<><vvvvv^v<v<<>^v<v>v<<^><<><<><<<^^<<<^<<>><<><^^^>^^<>^>v<>
    ^^>vv<^v^v<vv>^<><v<^v>^^^>>>^^vvv^>vvv<>>>^<^>>>>>^<<^v>^vvv<>^<><<v>
    v^^>>><<^^<>>^v^<v^vv<>v^<<>^<^v^v><^<<<><<^<v><v<>vv>>v><v^<vv<>v^<<^
    """

  @Test func simpleExamplePart1() async throws {
    let simpleExample = """
      ########
      #..O.O.#
      ##@.O..#
      #...O..#
      #.#.O..#
      #...O..#
      #......#
      ########

      <^^>>>vv<v>>v<<
      """

    let result = Day15().part1(input: simpleExample)

    #expect(result == 2028)
  }

  @Test func complexExamplePart1() async throws {
    let result = Day15().part1(input: complexExample)

    #expect(result == 10092)
  }

  @Test func simpleExamplePart2() async throws {
    let simpleExample = """
      #######
      #...#.#
      #.....#
      #..OO@#
      #..O..#
      #.....#
      #######

      <vv<<^^<<^^
      """
    let result = Day15().part2(input: simpleExample)

    #expect(result == 618)
  }

  @Test func complexExamplePart2() async throws {
    let result = Day15().part2(input: complexExample)

    #expect(result == 9021)
  }
}
