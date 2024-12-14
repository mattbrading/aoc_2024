//
//  day14_tests.swift
//  aoc_2024
//
//  Created by Matt Brading on 14/12/2024.
//

import Testing

@testable import aoc_2024

@Suite("Day 14 Tests")
struct Day14Tests {
  let exampleInput = """
    p=0,4 v=3,-3
    p=6,3 v=-1,-3
    p=10,3 v=-1,2
    p=2,0 v=2,-1
    p=0,0 v=1,3
    p=3,0 v=-2,-2
    p=7,6 v=-1,-3
    p=3,0 v=-1,-2
    p=9,3 v=2,3
    p=7,3 v=-1,2
    p=2,4 v=2,-3
    p=9,5 v=-3,-3
    """

  @Test func exampleInputPart1() async throws {
    let result = Day14(width: 11, height: 7).part1(input: exampleInput)

    #expect(result == 12)
  }
}
