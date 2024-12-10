//
//  day09_tests.swift
//  aoc_2024
//
//  Created by Matt Brading on 09/12/2024.
//

import Testing

@testable import aoc_2024

@Suite("Day 9 Tests")
struct Day09Tests {

  let exampleInput = "2333133121414131402"

  @Test func exampleInputPart1() async throws {
    let result = Day09().part1(input: exampleInput)

    #expect(result == 1928)
  }

  @Test func exampleInputPart2() async throws {
    let result = Day09().part2(input: exampleInput)

    #expect(result == 2858)
  }
}
