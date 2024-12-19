//
//  Day19.swift
//  aoc_2024
//
//  Created by Matt Brading on 19/12/2024.
//
import ArgumentParser

private struct Onsen {
  let towels: Set<String>
  let patterns: [String]

  private var towelCache: [String: Int] = [:]

  func findTowels(pattern: String) -> Bool {
    if towels.contains(pattern) { return true }

    for idx in pattern.indices.reversed() {
      if idx == pattern.startIndex {
        return false
      }
      let subPattern = String(pattern[pattern.startIndex..<idx])

      if towels.contains(subPattern) {
        return findTowels(pattern: String(pattern[idx...]))
      }
    }

    return false
  }

  mutating func findTowelsAll(pattern: String) -> Int {
    if let cachedValue = towelCache[pattern] {
      return cachedValue
    }

    var count = 0

    if towels.contains(pattern) { count += 1 }

    for idx in pattern.indices.reversed() {
      if idx == pattern.startIndex {
        continue
      }
      let subPattern = String(pattern[pattern.startIndex..<idx])

      if towels.contains(subPattern) {
        let foundCount = findTowelsAll(pattern: String(pattern[idx...]))
        count += foundCount
      }
    }

    towelCache[pattern] = count

    return count
  }

  static func fromString(from: String) -> Onsen {
    let towels: Set<String> = Set(
      from.split(separator: "\n\n")[0].split(separator: ", ").map({
        String($0)
      }))

    let patterns: [String] = from.split(separator: "\n\n")[1].split(
      separator: "\n"
    ).map({ String($0) })

    return Onsen(towels: towels, patterns: patterns)
  }

}

struct Day19: AdventDay {
  @Argument var inputFile: String

  func part1(input: String) -> Int {
    let onsen = Onsen.fromString(from: input)

    return onsen.patterns.count(where: { pattern in
      onsen.findTowels(pattern: pattern)
    })
  }

  func part2(input: String) -> Int {
    var onsen = Onsen.fromString(from: input)

    return onsen.patterns.reduce(
      0,
      { total, pattern in
        total + onsen.findTowelsAll(pattern: pattern)
      })
  }

}
