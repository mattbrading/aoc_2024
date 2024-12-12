//
//  day12_tests.swift
//  aoc_2024
//
//  Created by Matt Brading on 12/12/2024.
//

import Testing

@testable import aoc_2024

@Suite("Day 12 Tests")
struct Day12Tests {
  let exampleInput = """
    RRRRIICCFF
    RRRRIICCCF
    VVRRRCCFFF
    VVRCCCJFFF
    VVVVCJJCFE
    VVIVCCJJEE
    VVIIICJJEE
    MIIIIIJJEE
    MIIISIJEEE
    MMMISSJEEE
    """

  @Test func exampleInputPart1() async throws {
    let result = Day12().part1(input: exampleInput)

    #expect(result == 1930)
  }

  @Test func exampleInputPart2() async throws {
    let result = Day12().part2(input: exampleInput)

    #expect(result == 1206)
  }

  @Test func extraExamplesPart2() async throws {
    let input = """
      EEEEE
      EXXXX
      EEEEE
      EXXXX
      EEEEE
      """

    let result = Day12().part2(input: input)

    #expect(result == 236)
  }
  
  @Test func extraExamples2Part2() async throws {
    let input = """
      AAAAAA
      AAABBA
      AAABBA
      ABBAAA
      ABBAAA
      AAAAAA
      """
    
    let result = Day12().part2(input: input)
    
    #expect(result == 368)
  }
}
