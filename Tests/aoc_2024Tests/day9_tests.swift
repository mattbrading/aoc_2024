//
//  day9_tests.swift
//  aoc_2024
//
//  Created by Matt Brading on 09/12/2024.
//

import Testing

@testable import aoc_2024

struct Day9Tests {

  let exampleInput = "2333133121414131402"

  @Test func exampleInputPart1() async throws {
    let result = Day9().part1(input: exampleInput)

    #expect(result == 1928)
  }

  @Test func exampleInputPart2() async throws {
    let result = Day9().part2(input: exampleInput)

    #expect(result == 2858)
  }
}
