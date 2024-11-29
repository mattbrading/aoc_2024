//
//  Day0.swift
//  aoc_2024
//
//  Created by Matt Brading on 29/11/2024.
//
import Foundation
import ArgumentParser


struct Day0: ParsableCommand {
    
    @Argument() var inputFile: String
    
    mutating func run() throws {
        let inputFileURL = URL(fileURLWithPath: inputFile)
        let input = try String(contentsOf: inputFileURL)
        let part1 = part1(input: input)
        let part2 = part2(input: input)
    
        print("Part 1: \(part1)")
        print("Part 2: \(part2)")
    }
    
    func part1(input: String) -> Int {
        input.count
    }
    
    func part2(input: String) -> Int {
        input.count(where: { $0 == "o" })
    }
    
}
