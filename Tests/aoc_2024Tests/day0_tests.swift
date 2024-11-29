//
//  day0_tests.swift
//  aoc_2024
//
//  Created by Matt Brading on 29/11/2024.
//

import Testing

@testable import aoc_2024

@Suite("Day 1 Tests")
struct Day1Tests {
  @Test func part1() async throws {
    let result = Day0().part1(input: "Hello, World!")

    #expect(result == 13)
  }

  @Test func part2() async throws {
    let result = Day0().part2(input: "Hello, World!")

    #expect(result == 2)
  }
}
