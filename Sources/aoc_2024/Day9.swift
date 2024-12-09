//
//  Day9.swift
//  aoc_2024
//
//  Created by Matt Brading on 09/12/2024.
//

import ArgumentParser

private struct Disk {
  var disk: [Int?]
  var emptySpaces: [(index: Int, size: Int)]
  var files: [(index: Int, fileId: Int, size: Int)]

  mutating func partitionV1() {
    var startIdx = 0
    var endIdx = disk.count - 1

    while startIdx != endIdx {
      if disk[startIdx] != nil {
        startIdx += 1
        continue
      }

      while disk[endIdx] == nil {
        endIdx -= 1
      }

      disk[startIdx] = disk[endIdx]
      disk[endIdx] = nil

      startIdx += 1
      endIdx -= 1
    }
  }

  mutating func partitionV2() {
    files.reversed().forEach { fileIndex, fileId, fileSize in

      var emptySpaceIdx: Int?
      var emptySpace: (index: Int, size: Int)?

      for (idx, space) in emptySpaces.enumerated() {
        if space.index >= fileIndex { break }
        if space.size >= fileSize {
          emptySpace = space
          emptySpaceIdx = idx
          break
        }
      }

      guard let (insertIdx, spaceSize) = emptySpace else {
        return
      }

      guard let emptySpaceIdx else { return }

      (0..<fileSize).forEach { idx in
        disk[insertIdx + idx] = disk[fileIndex + idx]
        disk[fileIndex + idx] = nil
      }

      let remainingSpace = spaceSize - fileSize

      if remainingSpace != 0 {
        emptySpaces[emptySpaceIdx] = (insertIdx + fileSize, remainingSpace)
      } else {
        emptySpaces.remove(at: emptySpaceIdx)
      }
    }
  }

  func checksum() -> Int {
    disk.enumerated().compactMap({ idx, value in
      value != nil ? value! * idx : value
    }).reduce(0, +)
  }

  static func fromString(input: String) -> Disk {

    var disk: [Int?] = []
    var emptySpaces: [(index: Int, size: Int)] = []
    var files: [(index: Int, fileId: Int, size: Int)] = []

    var fileId = 0
    var index = 0
    input.enumerated().forEach({ (inputIdx, size) in
      let size: Int = size.wholeNumberValue!

      let isFile = inputIdx == 0 || inputIdx.isMultiple(of: 2)

      (0..<size).forEach({ _ in disk.append(isFile ? fileId : nil) })

      if isFile {
        files.append((index, fileId, size))
        fileId += 1
      } else {
        emptySpaces.append((index, size))
      }

      index += size
    })
    return Disk(disk: disk, emptySpaces: emptySpaces, files: files)
  }

}

struct Day9: AdventDay {
  @Argument var inputFile: String

  func part1(input: String) -> Int {

    var disk = Disk.fromString(input: input)
    disk.partitionV1()

    return disk.checksum()
  }

  func part2(input: String) -> Int {

    var disk = Disk.fromString(input: input)
    disk.partitionV2()

    return disk.checksum()
  }
}
