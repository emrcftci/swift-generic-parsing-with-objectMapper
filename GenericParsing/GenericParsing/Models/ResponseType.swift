//
//  ResponseType.swift
//  GenericParsing
//
//  Created by Emre Çiftçi on 1.01.2020.
//  Copyright © 2020 Emre Çiftçi. All rights reserved.
//

import Foundation

/// Types of possible objects
public enum ResponseType: String {
  case undefined

  case space = "SPACE"
  case company = "COMPANY"
  case person = "PERSON"
  case continent = "CONTINENT"
}
