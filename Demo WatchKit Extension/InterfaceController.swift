//
//  InterfaceController.swift
//  Demo
//
//  Created by temporary on 10/2/16.
//  Copyright © 2016 benmorrow. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {
  
  override init() {
    super.init()
        
    var ringTypes = [RingType]()
    // Iterate through all values for RingType
    var i = 0
    while let ringType = RingType(rawValue: i) {
      ringTypes.append(ringType)
      i += 1
    }

    let names = [String](repeating: "PageInterfaceControllerType", count: ringTypes.count)
    WKInterfaceController.reloadRootControllers(withNames: names, contexts: ringTypes)
  }
}
