#!/usr/bin/env xcrun --sdk macosx swift

import Foundation

// MARK: - Extension for get url string from ViewController.swift

extension String {

  func slice(from: String, to: String) -> String? {

    return (range(of: from)?.upperBound).flatMap { substringFrom in
      (range(of: to, range: substringFrom..<endIndex)?.lowerBound).map { substringTo in
        String(self[substringFrom..<substringTo])
      }
    }
  }
}

/// Returns random element of given `URLs`
/// Function calls itself until `randomlySelected` has a different value
/// - Parameters:
///   - URLs: Array of URLs for pick up random element
///   - current: URL for pick up different element from URLs
func randomElement(for URLs: [String], with currentURL: String) -> String? {
  let randomlySelected = URLs.randomElement()!

  if currentURL.contains(randomlySelected) {
    return randomElement(for: URLs, with: currentURL)
  }

  return randomlySelected
}

/// Base URL contains different JSON files
let BASE_URL = "https://emrcftci.github.io/demo.github.io/generic-parsing-example/"

let URLs = [
  "continent.json",
  "space.json",
  "person.json",
  "company.json"
]

/// Project directory without "/Scripts/change-url"
let PROJECT_DIR = URL(fileURLWithPath: #file).pathComponents.map { "\($0)/" }.dropFirst().dropLast().dropLast().joined()

/// ViewController.swift file's directory
let FILE_DIR = "/\(PROJECT_DIR)GenericParsing/ViewController.swift"

do {
  /// All texts in ViewController.swift
  let CONTENTS = try String(contentsOfFile: FILE_DIR)

  /// URL line between `<changed></changed>` tags
  let URL_LINE = CONTENTS.slice(from: "<change>", to: "//</change>")!

  let RANDOMLY_SELECTED_ENDPOINT = randomElement(for: URLs, with: URL_LINE)!

  /// Modified line for updated ViewController.swift
  let CHANGED_URL = "\n    let url = " + "\"\(BASE_URL)" + "\(RANDOMLY_SELECTED_ENDPOINT)\"" + "\n"

  /// New file contents with `CHANGED_URL`
  let NEW_FILE_CONTENTS = CONTENTS.replacingOccurrences(of: URL_LINE, with: CHANGED_URL)

  // Write new contents to `ViewController.swift`
  let FILE_URL = URL(fileURLWithPath: FILE_DIR)
  try! NEW_FILE_CONTENTS.write(to: FILE_URL, atomically: true, encoding: .utf8)

}
catch {
  print("error occured:", error)
}
