//
//  Day7.swift
//  aoc_2024
//
//  Created by Matt Brading on 07/12/2024.
//
import ArgumentParser

struct Day7: AdventDay {

  @Argument var inputFile: String

  func isCalibrationPossible(result: Int, numbers: [Int]) -> Bool {
    if numbers.count == 1 {
      return result == numbers[0]
    }

    var leftSide = [numbers[0] + numbers[1]]
    leftSide.append(contentsOf: numbers[2...])

    var rightSide = [numbers[0] * numbers[1]]
    rightSide.append(contentsOf: numbers[2...])

    return isCalibrationPossible(result: result, numbers: leftSide)
      || isCalibrationPossible(result: result, numbers: rightSide)
  }
  func isCalibrationPossibleV2(result: Int, numbers: [Int]) -> Bool {
    if numbers.count == 1 {
      return result == numbers[0]
    }

    var sumOperation = [numbers[0] + numbers[1]]
    sumOperation.append(contentsOf: numbers[2...])

    var productOperation = [numbers[0] * numbers[1]]
    productOperation.append(contentsOf: numbers[2...])

    var concatOperation = [Int("\(numbers[0])\(numbers[1])")!]
    concatOperation.append(contentsOf: numbers[2...])

    return isCalibrationPossibleV2(result: result, numbers: sumOperation)
      || isCalibrationPossibleV2(result: result, numbers: productOperation)
      || isCalibrationPossibleV2(result: result, numbers: concatOperation)
  }

  func part1(input: String) -> Int {
    return input.split(separator: "\n").map { line in
      let lineParts = line.split(separator: ": ")

      let result: Int = Int(lineParts[0])!

      let numbers: [Int] = lineParts[1].components(separatedBy: .whitespaces)
        .compactMap({ Int($0) })

      return isCalibrationPossible(result: result, numbers: numbers)
        ? result : 0
    }.reduce(0, +)
  }

  func part2(input: String) -> Int {
    return input.split(separator: "\n").map { line in
      let lineParts = line.split(separator: ": ")

      let result: Int = Int(lineParts[0])!

      let numbers: [Int] = lineParts[1].components(separatedBy: .whitespaces)
        .compactMap({ Int($0) })

      return isCalibrationPossibleV2(result: result, numbers: numbers)
        ? result : 0
    }.reduce(0, +)
  }

}
