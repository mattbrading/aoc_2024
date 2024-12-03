//
//  day3_tests.swift
//  aoc_2024
//
//  Created by Matt Brading on 03/12/2024.
//

import Testing

@testable import aoc_2024

struct Day3Tests {

  @Test func example_input_part1() async throws {
    let exampleInput =
      "xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))"

    let result = Day3().part1(input: exampleInput)

    #expect(result == 161)
  }

  @Test func example_input_part2() async throws {
    let exampleInput =
      "xmul(2,4)&mul[3,7]!^don't()_mul(5,5)+mul(32,64](mul(11,8)undo()?mul(8,5))"

    let result = Day3().part2(input: exampleInput)

    #expect(result == 48)
  }

}
