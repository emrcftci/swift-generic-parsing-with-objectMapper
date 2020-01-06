//
//  AnyResponse.swift
//  GenericParsing
//
//  Created by Emre Çiftçi on 3.01.2020.
//  Copyright © 2020 Emre Çiftçi. All rights reserved.
//

import ObjectMapper

/// Firstly we should map "type" key for recognize what kind of object will come
public class AnyResponse: StaticMappable {

  public var type: ResponseType = .undefined

  /// "display" returns an object which has correct type and conforms DisplayProtocol
  public var data: ViewModelProtocol? {
    return AnyResponse.dataFor(self)
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

  /// Helper function for return correct `ViewModelProtocol` object to use UI configuration
  ///
  /// *Example:* `SpaceViewModel` has an initializer like -> `init(component: Response<Space>)` so `component.unpacked()` function's <T> parameter is `Space` for this example.
  private class func dataFor(_ component: AnyResponse) -> ViewModelProtocol? {

    switch component.type {
    case .space:
      return SpaceViewModel(component: component.unpacked())

    case .company:
      return CompanyViewModel(component: component.unpacked())

    case .continent:
      return ContinentViewModel(component: component.unpacked())

    case .person:
      return PersonViewModel(component: component.unpacked())

    case .undefined:
      return nil
    }
  }

  /// Unpacked `AnyResponse` with correct object (`T`) and return Response with <T>
  private func unpacked<T>() -> Response<T> {
    return self as! Response<T>
  }
}
