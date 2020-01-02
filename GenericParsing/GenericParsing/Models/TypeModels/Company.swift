//
//  Company.swift
//  GenericParsing
//
//  Created by Emre Çiftçi on 1.01.2020.
//  Copyright © 2020 Emre Çiftçi. All rights reserved.
//

import ObjectMapper

/// Used for mapping
public struct Company: ImmutableMappable {

  public let name: String
  public let employees: Int

  public init(map: Map) throws {
    self.name = try map.value("name")
    self.employees = try map.value("employees")
  }
}

// MARK: - DisplayProtocol

public struct CompanyDisplay: DisplayProtocol {
  
  public var name: String
  public var detailTitle: String
  public var detail: String?

  public init(component: Response<Company>) {
    name = component.data.name
    detailTitle = "Employees Count:" // Sorry for this ☠️
    detail = component.data.employees.description
  }
}
