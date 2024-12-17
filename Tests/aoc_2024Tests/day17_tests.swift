//
//  day17_tests.swift
//  aoc_2024
//
//  Created by Matt Brading on 17/12/2024.
//

import Testing

@testable import aoc_2024

@Suite("Day 17 Tests")
struct Day17Tests {

  @Test func exampleInputPart1() async throws {
    let exampleInput = """
      Register A: 729
      Register B: 0
      Register C: 0

      Program: 0,1,5,4,3,0
      """
    let result = Day17().part1(input: exampleInput)

    #expect(result == "4,6,3,5,6,3,5,2,1,0")
  }

  @Test func exampleInputPart2() async throws {
    let exampleInput = """
      Register A: 2024
      Register B: 0
      Register C: 0

      Program: 0,3,5,4,3,0
      """
    let result = Day17().part2(input: exampleInput)

    #expect(result == 117440)
  }
}
