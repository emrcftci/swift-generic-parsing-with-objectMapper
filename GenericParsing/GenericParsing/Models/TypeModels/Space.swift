//
//  Space.swift
//  GenericParsing
//
//  Created by Emre Çiftçi on 1.01.2020.
//  Copyright © 2020 Emre Çiftçi. All rights reserved.
//

import ObjectMapper

/// Used for mapping
public struct Space: ImmutableMappable {

  public let name: String
  public let distance: Int

  public init(map: Map) throws {
    self.name = try map.value("name")
    self.distance = try map.value("distance")
  }
}

// MARK: - DisplayProtocol

public struct SpaceDisplay: DisplayProtocol {

  public var name: String
  public var detailTitle: String
  public var detail: String?

  public init(component: Response<Space>) {
    name = component.data.name
    detailTitle = "Distance:" // Sorry for this ☠️
    detail = component.data.distance.description
  }
}
