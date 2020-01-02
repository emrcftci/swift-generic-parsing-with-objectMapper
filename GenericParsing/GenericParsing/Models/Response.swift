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
  public var data: T!

  public override init() {
    super.init()
  }

  public required init?(map: Map) {
    super.init()
    data = try? map.value("detail")
  }

  /// Called after `objectForMapping(map: ) -> BaseMappable?` returns a correct T object
  public override func mapping(map: Map) {
    super.mapping(map: map)
    data <- map["detail"]
  }
}

/// Firstly we should map "type" key for recognize what kind of object will come
public class AnyResponse: StaticMappable {

  public var type: ResponseType = .undefined

  /// "display" returns an object which has correct type and conforms DisplayProtocol
  public var display: DisplayProtocol? {
    return AnyResponse.displayForComponent(self)
  }

  public func mapping(map: Map) {
    type <- (map["type"], EnumTransform<ResponseType>())
  }

  public class func objectForMapping(map: Map) -> BaseMappable? {
    /// Map type first
    let type: ResponseType = try! map.value("type", using: EnumTransform<ResponseType>())

    /// Then we can check the type for return correct model
    ///
    /// Response<Space>(): return Response with <T> -T is Space for this case-
    /// Constructor `()` call the map function of Response<T> and T is set before calling
    switch type {
    case .space:
      return Response<Space>()

    case .company:
      return Response<Company>()

    case .continent:
      return Response<Continent>()

    case .person:
      return Response<Person>()

    case .undefined:
      return nil
    }
  }

  /// Helper function for return correct `DisplayProtocol` object to use UI configuration
  ///
  /// `SpaceDisplay` has an initializer like -> `init(component: Response<Space>)` so `component.unpacked()` function's <T> parameter is `Space`.
  private class func displayForComponent(_ component: AnyResponse) -> DisplayProtocol? {

    switch component.type {
    case .space:
      return SpaceDisplay(component: component.unpacked())

    case .company:
      return CompanyDisplay(component: component.unpacked())

    case .continent:
      return ContinentDisplay(component: component.unpacked())

    case .person:
      return PersonDisplay(component: component.unpacked())

    case .undefined:
      return nil
    }
  }

  /// Unpacked `AnyResponse` with correct object (`T`) and return Response with <T>
  private func unpacked<T>() -> Response<T> {
    return self as! Response<T>
  }
}
