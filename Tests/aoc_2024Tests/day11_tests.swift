//
//  day11_tests.swift
//  aoc_2024
//
//  Created by Matt Brading on 11/12/2024.
//

import Testing
@testable import aoc_2024

@Suite("Day 11 Tests")
struct Day11Tests {
  let exampleInput = "125 17"
  @Test func exampleInputPart1() async throws {
    let result = Day11().part1(input: exampleInput)
    
    #expect(result == 55312)
  }
  
  @Test func exampleInputPart2() async throws {
    let result = Day11().part2(input: exampleInput)
    
    #expect(result == 65601038650482)
  }
}
