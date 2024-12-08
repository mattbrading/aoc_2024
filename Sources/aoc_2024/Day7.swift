//
//  Day7.swift
//  aoc_2024
//
//  Created by Matt Brading on 07/12/2024.
//
import ArgumentParser
import Foundation

struct Day7: AdventDay {

  @Argument var inputFile: String

  func isCalibrationPossible(
    result: Int, numbers: [Int], index: Int = 0, total: Int = 0
  ) -> Bool {
    if index == 0 {
      return isCalibrationPossible(
        result: result, numbers: numbers, index: 1, total: numbers[0])
    }

    let sumOperation = total + numbers[index]
    let productOperation = total * numbers[index]

    let nextIndex = index + 1

    if !numbers.indices.contains(nextIndex) {
      return result == sumOperation || result == productOperation
    }

    return isCalibrationPossible(
      result: result, numbers: numbers, index: nextIndex, total: sumOperation)
      || isCalibrationPossible(
        result: result, numbers: numbers, index: nextIndex,
        total: productOperation)
  }

  func concat(a: Int, b: Int) -> Int {
    return (a * Int(powf(10, floor(log10(Float(b))) + 1)) + b)
  }

  func isCalibrationPossibleV2(
    result: Int, numbers: [Int], index: Int = 0, total: Int = 0
  ) -> Bool {

    if index == 0 {
      return isCalibrationPossibleV2(
        result: result, numbers: numbers, index: 1, total: numbers[0])
    }

    let sumOperation = total + numbers[index]
    let productOperation = total * numbers[index]
    let concatOperation = concat(a: total, b: numbers[index])

    let nextIndex = index + 1

    if !numbers.indices.contains(nextIndex) {
      return result == sumOperation || result == productOperation
        || result == concatOperation
    }

    return isCalibrationPossibleV2(
      result: result, numbers: numbers, index: nextIndex, total: sumOperation)
      || isCalibrationPossibleV2(
        result: result, numbers: numbers, index: nextIndex,
        total: productOperation)
      || isCalibrationPossibleV2(
        result: result, numbers: numbers, index: nextIndex,
        total: concatOperation)
  }

  func parseInput(input: String) -> [(Int, [Int])] {
    return input.split(separator: "\n").map { line in
      let lineParts = line.split(separator: ": ")

      let result: Int = Int(lineParts[0])!

      let numbers: [Int] = lineParts[1].components(separatedBy: .whitespaces)
        .compactMap({ Int($0) })

      return (result, numbers)
    }
  }

  func part1(input: String) -> Int {
    return parseInput(input: input)
      .map { result, numbers in
        return isCalibrationPossible(result: result, numbers: numbers)
          ? result : 0
      }.reduce(0, +)
  }

  func part2(input: String) -> Int {
    return parseInput(input: input)
      .map { result, numbers in
        return isCalibrationPossibleV2(result: result, numbers: numbers)
          ? result : 0
      }.reduce(0, +)
  }

}
