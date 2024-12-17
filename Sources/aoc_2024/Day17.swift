//
//  Day17.swift
//  aoc_2024
//
//  Created by Matt Brading on 17/12/2024.
//
import ArgumentParser
import Foundation

private struct StrangeDevice {
  var A: Int
  var B: Int
  var C: Int

  var pointer: Int = 0
  var output: [Int] = []

  let instructions: [Int]
  let haltPoint: Int

  mutating func adv(_ operand: Int) {
    let num = Double(A)
    let den = Double(pow(2, Double(combo(value: operand))))
    let result = num / den
    A = Int(result)
  }

  mutating func bxl(_ operand: Int) {
    B = B ^ operand
  }

  mutating func bst(_ operand: Int) {
    B = combo(value: operand) % 8
  }

  mutating func jnz(_ operand: Int) {
    switch A {
    case 0:
      pointer += 2
    default:
      pointer = operand
    }
  }

  mutating func bxc(_ operand: Int) {
    B = B ^ C
  }

  mutating func out(_ operand: Int) {
    output.append(combo(value: operand) % 8)
  }

  mutating func bdv(_ operand: Int) {
    let num = Double(A)
    let den = Double(pow(2, Double(combo(value: operand))))
    let result = num / den
    B = Int(result)
  }

  mutating func cdv(_ operand: Int) {
    let num = Double(A)
    let den = Double(pow(2, Double(combo(value: operand))))
    let result = num / den
    C = Int(result)
  }

  func combo(value: Int) -> Int {
    switch value {
    case 0..<4:
      return value
    case 4:
      return A
    case 5:
      return B
    case 6:
      return C
    default:
      print("Invalid combo op")
      return 0
    }
  }

  mutating func execute() {
    while pointer < haltPoint {
      let operand = instructions[pointer + 1]
      switch instructions[pointer] {
      case 0:
        adv(operand)
      case 1:
        bxl(operand)
      case 2:
        bst(operand)
      case 3:
        jnz(operand)
        continue
      case 4:
        bxc(operand)
      case 5:
        out(operand)
      case 6:
        bdv(operand)
      case 7:
        cdv(operand)
      default:
        print("Invalid Op Code")
        return
      }
      pointer += 2
    }
  }

  static func fromString(from: String) -> StrangeDevice {

    let registers = from.matches(of: /: ([0-9]+)\n/)
    let A = Int(registers[0].output.1)!
    let B = Int(registers[1].output.1)!
    let C = Int(registers[2].output.1)!

    let instructionString = from.firstMatch(of: /Program: ([0-9,]+)/)!.output.1

    let instructions = instructionString.split(separator: ",").map { Int($0)! }

    return StrangeDevice(
      A: A, B: B, C: C, instructions: instructions,
      haltPoint: instructions.count)
  }

}

struct Day17: AdventDay {
  @Argument var inputFile: String

  func part1(input: String) -> String {

    var device = StrangeDevice.fromString(from: input)

    device.execute()

    return device.output.map { String($0) }.joined(separator: ",")

  }

  func checkDeviceWithA(A: Int, instructions: [Int], haltPoint: Int) -> [Int] {
    var device = StrangeDevice(
      A: A, B: 0, C: 0, instructions: instructions, haltPoint: haltPoint)

    device.execute()

    return device.output
  }

  func part2(input: String) -> Int {
    let exampleDevice = StrangeDevice.fromString(from: input)
    let instructions = exampleDevice.instructions
    let haltPoint = exampleDevice.haltPoint

    var possibilities: [(Int, Int)] = [(0, haltPoint - 1)]

    while !possibilities.isEmpty {
      let (poss, offset) = possibilities.removeFirst()
      for i in 0..<8 {
        let A = (poss << 3) + i
        var device = StrangeDevice(
          A: A, B: 0, C: 0, instructions: instructions, haltPoint: haltPoint)
        device.execute()

        if device.output == instructions {
          return A
        }

        if device.output[0...] == instructions[offset...] {
          possibilities.append((A, offset - 1))
        }
      }
    }

    return 0
  }

}
