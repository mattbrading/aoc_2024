import ArgumentParser

@main
struct AoC2024: ParsableCommand {

  static let configuration = CommandConfiguration(
    commandName: "aoc_2024",
    abstract: "Run AoC 2024",
    subcommands: [
      Day01.self,
      Day02.self,
      Day03.self,
      Day04.self,
      Day05.self,
      Day06.self,
      Day07.self,
      Day08.self,
      Day09.self,
      Day10.self,
      Day11.self,
      Day12.self,
      Day13.self,
      Day14.self,
      Day15.self,
      Day16.self,
      Day17.self,
      Day18.self,
      Day19.self,
      Day20.self,
    ]
  )
}
