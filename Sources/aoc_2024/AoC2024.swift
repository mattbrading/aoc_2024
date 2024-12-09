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
    ]
  )
}
