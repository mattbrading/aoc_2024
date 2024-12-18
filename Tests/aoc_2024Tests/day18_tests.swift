//
//  day18_tests.swift
//  aoc_2024
//
//  Created by Matt Brading on 18/12/2024.
//

import Testing

@testable import aoc_2024

@Suite("Day 18 Tests")
struct Day18Tests {
  let exampleInput = """
    5,4
    4,2
    4,5
    3,0
    2,1
    6,3
    2,4
    1,5
    0,6
    3,3
    2,6
    5,1
    1,2
    5,5
    2,5
    6,5
    1,4
    0,4
    6,4
    1,1
    6,1
    1,0
    0,5
    1,6
    2,0
    """
  @Test func exampleInputPart1() throws {
    let result = Day18().findPath(input: exampleInput, bytes: 12, width: 6)

    #expect(result == 22)
  }

  @Test func exampleInputPart2() throws {
    let result = Day18().firstBlockingByte(input: exampleInput, width: 6)

    #expect(result == "6,1")
  }

}
