//
//  GameViewController.swift
//  SKTRingNodeDemo
//
//  Created by temporary on 9/27/16.
//  Copyright © 2016 benmorrow. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    guard let view = self.view as! SKView? else {
      return
    }
    
    let scene = GameScene(size: view.frame.size)
    
    // Present the scene
    view.presentScene(scene)
    
    view.ignoresSiblingOrder = true
    
//    view.showsFPS = true
//    view.showsNodeCount = true
  }
  
  override var prefersStatusBarHidden: Bool {
    return true
  }
}
