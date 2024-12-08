//
//  day8_tests.swift
//  aoc_2024
//
//  Created by Matt Brading on 08/12/2024.
//

import Testing

@testable import aoc_2024

@Suite("Day 8 Tests")
struct Day8Tests {
  let exampleInput = """
    ............
    ........0...
    .....0......
    .......0....
    ....0.......
    ......A.....
    ............
    ............
    ........A...
    .........A..
    ............
    ............
    """

  @Test func exampleInputPart1() throws {
    let result = Day8().part1(input: exampleInput)
    #expect(result == 14)
  }

  @Test func simplerExampleInputPart1() throws {

    let simpleExample = """
      ..........
      ..........
      ..........
      ....a.....
      ........a.
      .....a....
      ..........
      ..........
      ..........
      ..........

      """

    let result = Day8().part1(input: simpleExample)
    #expect(result == 4)
  }

  @Test func exampleInputPart2() throws {
    let result = Day8().part2(input: exampleInput)
    #expect(result == 34)
  }
}