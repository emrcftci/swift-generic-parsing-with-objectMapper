//
//  Response.swift
//  GenericParsing
//
//  Created by Emre Çiftçi on 1.01.2020.
//  Copyright © 2020 Emre Çiftçi. All rights reserved.
//

import ObjectMapper

/// Response contains our data field for map generic type objects
public final class Response<T: BaseMappable>: AnyResponse, Mappable {

  /// This will be our models (`Continent, Company, Person, Space`)
  public var detail: T!

  public override init() {
    super.init()
  }

  public required init?(map: Map) {
    super.init()
    detail = try? map.value("detail")
  }

  /// Called after `objectForMapping(map: ) -> BaseMappable?` returns a correct T object
  public override func mapping(map: Map) {
    super.mapping(map: map)
    detail <- map["detail"]
  }
}
