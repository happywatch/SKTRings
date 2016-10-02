//
//  InterfaceController.swift
//  SKTRingNodeDemo WatchKit App Extension
//
//  Created by temporary on 9/27/16.
//  Copyright © 2016 benmorrow. All rights reserved.
//

import WatchKit
import Foundation


class PageInterfaceController: WKInterfaceController {
  @IBOutlet var skInterface: WKInterfaceSKScene!
  
  override func awake(withContext context: Any?) {
    super.awake(withContext: context)
    
    guard let ringType = context as? RingType else {
      return
    }
    
    let scene = GameScene(size: contentFrame.size)
    skInterface.presentScene(scene)
    scene.show(ringType, at: CGPoint(x: contentFrame.midX, y: contentFrame.midY - 20), diameter: contentFrame.width)
    setTitle(ringType.simpleDescription)
  }
}
