//
//  GameViewController.swift
//  SKTRingNodeDemo
//
//  Created by temporary on 9/27/16.
//  Copyright © 2016 benmorrow. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    guard let view = self.view as! SKView? else {
      return
    }
    
    let scene = iosGameScene(size: view.frame.size)
    view.presentScene(scene)
    view.ignoresSiblingOrder = true
    
    scene.showAll()
  }
  
  override var prefersStatusBarHidden: Bool {
    return true
  }
}
