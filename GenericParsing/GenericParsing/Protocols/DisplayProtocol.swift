//
//  DisplayProtocol.swift
//  GenericParsing
//
//  Created by Emre Çiftçi on 1.01.2020.
//  Copyright © 2020 Emre Çiftçi. All rights reserved.
//

import Foundation

/// Objects has to conform this protocol for diplay
public protocol DisplayProtocol {

  var name: String { get }
  var detailTitle: String { get }
  var detail: String? { get }
}
