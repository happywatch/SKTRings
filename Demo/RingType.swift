//
//  RingType.swift
//  SKTRingNodeDemo
//
//  Created by temporary on 10/1/16.
//  Copyright © 2016 benmorrow. All rights reserved.
//

import Foundation

enum RingType: Int {
  case standard, adjustedValue, adjustedThickness, adjustedColor, withValueEasing, withColorEasing, withValueAndColorEasing, nested
  
  func simpleDescription() -> String {
    switch self {
    case .standard:
      return "Standard"
    case .adjustedValue:
      return "Adjusted value"
    case .adjustedThickness:
      return "Adjusted thickness"
    case .adjustedColor:
      return "Adjusted color"
    case .withValueEasing:
      return "w/ value easing"
    case .withColorEasing:
      return "w/ color easing"
    case .withValueAndColorEasing:
      return "w/ value & color easing"
    case .nested:
      return "Nested"
    }
  }
}
