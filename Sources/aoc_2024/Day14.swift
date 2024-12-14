//
//  Day14.swift
//  aoc_2024
//
//  Created by Matt Brading on 14/12/2024.
//

import ArgumentParser
import Foundation

private func truncatedDivision(a: Int, b: Int) -> Int {
  return ((a % b) + b) % b
}

private struct Point: Hashable, CustomStringConvertible {
  let row: Int
  let col: Int

  var description: String {
    "(r: \(row), c: \(col))"
  }
}

private struct Map: CustomStringConvertible {
  var rows: [[Int]]

  init(width: Int, height: Int) {
    let rows = (0..<height).map { _ in
      (0..<width).map { _ in 0 }
    }

    self.rows = rows

  }

  var description: String {
    rows.map { col in
      col.map { $0 == 0 ? "." : String($0) }.joined()
    }.joined(separator: "\n")
  }
}

struct Day14: AdventDay {
  @Argument var inputFile: String
  var width = 101
  var height = 103
  
  
  
  func parseRobots(input: String) -> [(Int, Int, Int, Int)] {
    let digitRegex = /[-]?[0-9]+/
    return input.split(separator: "\n").map {
      line in
      let digits = line.matches(of: digitRegex)
        .map { Int($0.output)! }
      return (digits[0], digits[1], digits[2], digits[3])
    }
  }
  
  
  private func simulateSeconds(robots: [(Int, Int, Int, Int)], seconds: Int) -> Map {
    var map = Map(width: width, height: height)
    
    robots.forEach { x, y, vx, vy in
      let finalX = truncatedDivision(a: (x + seconds * vx), b: width)
      let finalY = truncatedDivision(
        a: (y + seconds * vy), b: height)
      
      map.rows[finalY][finalX] += 1
    }
    
    return map
  }

  func part1(input: String) -> Int {
    let robots = parseRobots(input: input)
    
    let map = simulateSeconds(robots: robots, seconds: 100)

    let lhs = 0..<(width / 2)
    let rhs = (width / 2 + 1)..<width

    let top = 0..<(height / 2)
    let bot = (height / 2 + 1)..<height

    let quadrants = [
      (top, lhs),
      (bot, lhs),
      (top, rhs),
      (bot, rhs),
    ]

    let count = quadrants.reduce(1) { partialResult, ranges in

      let cells = map.rows[ranges.0].flatMap({ $0[ranges.1] })

      let subTotal = cells.reduce(0, +)

      return partialResult * subTotal
    }

    return count
  }

  func part2(input: String) -> Int {

    let robots: [(Int, Int, Int, Int)] = parseRobots(input: input)

    func checkXmasTree(seconds: Int) -> Bool {
      let map = simulateSeconds(robots: robots, seconds: seconds)
      
      let match = map.description.contains(/[1]{8}/)

      if match {
        print(map)
      }

      return match
    }

    var seconds = 1

    while !checkXmasTree(seconds: seconds) {
      print(seconds)
      seconds += 1
    }

    return seconds
  }
}
