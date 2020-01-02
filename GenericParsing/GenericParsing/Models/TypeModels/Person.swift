//
//  Person.swift
//  GenericParsing
//
//  Created by Emre Çiftçi on 1.01.2020.
//  Copyright © 2020 Emre Çiftçi. All rights reserved.
//

import ObjectMapper

/// Used for mapping
public struct Person: ImmutableMappable {

  public let name: String
  public let cells: Int

  public init(map: Map) throws {
    self.name = try map.value("name")
    self.cells = try map.value("cells")
  }
}

// MARK: - DisplayProtocol

public struct PersonDisplay: DisplayProtocol {
  
  public var name: String
  public var detailTitle: String
  public var detail: String?

  public init(component: Response<Person>) {
    name = component.data.name
    detailTitle = "Cell Count:" // Sorry for this ☠️
    detail = component.data.cells.description
  }
}
