//
//  InterfaceController.swift
//  SKTRingNodeDemo WatchKit App Extension
//
//  Created by temporary on 9/27/16.
//  Copyright © 2016 benmorrow. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {
  @IBOutlet var skInterface: WKInterfaceSKScene!
  
  override func awake(withContext context: Any?) {
    super.awake(withContext: context)
    
    let scene = GameScene(size: contentFrame.size)
    skInterface.presentScene(scene)
  }
}
