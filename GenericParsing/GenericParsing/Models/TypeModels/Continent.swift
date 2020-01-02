//
//  Continent.swift
//  GenericParsing
//
//  Created by Emre Çiftçi on 1.01.2020.
//  Copyright © 2020 Emre Çiftçi. All rights reserved.
//

import ObjectMapper

/// Used for mapping
public struct Continent: ImmutableMappable {

  public let name: String
  public let population: Int

  public init(map: Map) throws {
    self.name = try map.value("name")
    self.population = try map.value("population")
  }
}

// MARK: - DisplayProtocol

/// Used for display UI with final values
public struct ContinentDisplay: DisplayProtocol {
  
  public var name: String
  public var detailTitle: String
  public var detail: String?

  public init(component: Response<Continent>) {
    name = component.data.name
    detailTitle = "Population:" // Sorry for this ☠️
    detail = component.data.population.description
  }
}
