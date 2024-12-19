//
//  day19_tests.swift
//  aoc_2024
//
//  Created by Matt Brading on 19/12/2024.
//

import Testing

@testable import aoc_2024

@Suite("Day 19 Tests")
struct Day19Tests {
  let exampleInput = """
    r, wr, b, g, bwu, rb, gb, br

    brwrr
    bggr
    gbbr
    rrbgbr
    ubwu
    bwurrg
    brgr
    bbrgwb
    """
  @Test func exampleInputPart1() throws {
    let result = Day19().part1(input: exampleInput)

    #expect(result == 6)
  }

  @Test func exampleInputPart2() throws {
    let result = Day19().part2(input: exampleInput)

    #expect(result == 16)
  }

}
