import ArgumentParser

@main
struct AoC2024: ParsableCommand {

  static let configuration = CommandConfiguration(
    commandName: "aoc_2024",
    abstract: "Run AoC 2024",
    subcommands: [
      Day1.self,
      Day2.self,
      Day3.self,
    ]
  )
}
