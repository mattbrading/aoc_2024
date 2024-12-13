//
//  day13_tests.swift
//  aoc_2024
//
//  Created by Matt Brading on 13/12/2024.
//
import Testing

@testable import aoc_2024

@Suite("Day 13 Tests")
struct Day13Tests {
  @Test func part1ExampleRow() async throws {

    //    Button A: X+94, Y+34
    //    Button B: X+22, Y+67
    //    Prize: X=8400, Y=5400

    let result = Day13().findCheapestWin(
      aX: 94, aY: 34, bX: 22, bY: 67, X: 8400, Y: 5400, limit: 100)

    #expect(result! == (80, 40))
  }

  @Test func part1ExampleRow2() async throws {

    //    Button A: X+26, Y+66
    //    Button B: X+67, Y+21
    //    Prize: X=12748, Y=12176

    let result = Day13().findCheapestWin(
      aX: 26, aY: 66, bX: 67, bY: 21, X: 12748, Y: 12176, limit: 100)

    #expect(result == nil)
  }

  let exampleInput = """
    Button A: X+94, Y+34
    Button B: X+22, Y+67
    Prize: X=8400, Y=5400

    Button A: X+26, Y+66
    Button B: X+67, Y+21
    Prize: X=12748, Y=12176

    Button A: X+17, Y+86
    Button B: X+84, Y+37
    Prize: X=7870, Y=6450

    Button A: X+69, Y+23
    Button B: X+27, Y+71
    Prize: X=18641, Y=10279
    """

  @Test func exampleInputPart1() async throws {
    let result = Day13().part1(input: exampleInput)

    #expect(result == 480)
  }
}
