//
//  GameScene.swift
//  SKTRingNodeDemo
//
//  Created by temporary on 9/27/16.
//  Copyright © 2016 benmorrow. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
  
  // Configuration for both iOS and watchOS
  let duration: TimeInterval = 4
  let red = UIColor(red: 237 / 255.0, green: 30 / 255.0, blue: 95 / 255.0, alpha: 1)
  let blue = UIColor(red: 36 / 255.0, green: 160 / 255.0, blue: 255 / 255.0, alpha: 1)
  
  // Configuration for only iOS
  let columns = 4
  let rows = 2
  lazy var diameter: CGFloat = {
    let minLength = min(self.size.width / CGFloat(self.columns), self.size.height / CGFloat(self.rows))
    let margin = minLength * 0.1
    return minLength - margin
  }()
  
  override func sceneDidLoad() {
    backgroundColor = .black
  }
  
  func showAll() {
    var i = 0
    while let ringType = RingType(rawValue: i) {
      show(ringType: ringType)
      i += 1
    }
    
  }
  
  func show(ringType: RingType) {
    switch ringType {
    case .standard:
      addStandardRing()
    default:
      break
    }
  }
}



// MARK - Ring creation methods

extension GameScene {
  func addStandardRing() {
    let ring = SKRingNode(diameter: diameter)
    ring.position = center(forColumn: 1, row: 1)
    addLabel(for: ring, text: "Standard")
    addChild(ring)
  }
  
  func addAdjustedValueRing() {
    let ring = SKRingNode(diameter: diameter)
    ring.position = center(forColumn: 2, row: 1)
    addLabel(for: ring, text: "Adjusted value")
    addChild(ring)
    ring.arcEnd = 0.8 // decimal percentage of circumference, usually 0...1
  }
  
  func addAdjustedThicknessRing() {
    let ring = SKRingNode(diameter: diameter, thickness: 0.4) // decimal percentage of radius, 0...1
    ring.position = center(forColumn: 3, row: 1)
    addLabel(for: ring, text: "Adjusted thickness")
    addChild(ring)
  }
  
  func addAdjustedColorRing() {
    let ring = SKRingNode(diameter: diameter)
    ring.position = center(forColumn: 4, row: 1)
    addLabel(for: ring, text: "Adjusted color")
    addChild(ring)
    ring.color = red
  }
  
  func addRingWithValueEasing() {
    let ring = SKRingNode(diameter: diameter)
    ring.position = center(forColumn: 1, row: 2)
    addLabel(for: ring, text: "Value w/ easing")
    addChild(ring)
    let valueUpEffect = SKTRingValueEffect(for: ring, to: 1, duration: duration)
    valueUpEffect.timingFunction = SKTTimingFunctionBounceEaseOut
    let valueUpAction = SKAction.actionWithEffect(valueUpEffect)
    let valueDownEffect = SKTRingValueEffect(for: ring, to: 0, duration: duration)
    valueDownEffect.timingFunction = SKTTimingFunctionBounceEaseOut
    let valueDownAction = SKAction.actionWithEffect(valueDownEffect)
    let sequence = SKAction.sequence([valueUpAction,
                                       SKAction.wait(forDuration: duration / 3),
                                       valueDownAction,
                                       SKAction.wait(forDuration: duration / 3)])
    ring.run(SKAction.repeatForever(sequence))
  }
  
  func addRingWithColorEasing() {
    let ring = SKRingNode(diameter: diameter)
    ring.position = center(forColumn: 2, row: 2)
    addLabel(for: ring, text: "Color w/ easing")
    addChild(ring)
    ring.color = red
    let colorUpEffect = SKTRingColorEffect(for: ring, to: blue, duration: duration)
    colorUpEffect.timingFunction = SKTTimingFunctionBounceEaseOut
    let colorUpAction = SKAction.actionWithEffect(colorUpEffect)
    let colorDownEffect = SKTRingColorEffect(for: ring, to: red, duration: duration)
    colorDownEffect.timingFunction = SKTTimingFunctionBounceEaseOut
    let colorDownAction = SKAction.actionWithEffect(colorDownEffect)
    let sequence6 = SKAction.sequence([colorUpAction,
                                       SKAction.wait(forDuration: duration / 3),
                                       colorDownAction,
                                       SKAction.wait(forDuration: duration / 3)])
    ring.run(SKAction.repeatForever(sequence6))
  }
  
  func addRingWithValueAndColorEasing() {
    let ring = SKRingNode(diameter: diameter)
    ring.position = center(forColumn: 3, row: 2)
    addLabel(for: ring, text: "Color & value w/ easing")
    addChild(ring)
    ring.color = red
    let finalValue: CGFloat = 0.67
    let finalColor = lerp(start: red, end: blue, t: finalValue)
    let colorUpEffect = SKTRingColorEffect(for: ring, to: finalColor, duration: duration)
    colorUpEffect.timingFunction = SKTTimingFunctionBounceEaseOut
    let colorUpAction = SKAction.actionWithEffect(colorUpEffect)
    let valueUpEffect = SKTRingValueEffect(for: ring, to: finalValue, duration: duration)
    valueUpEffect.timingFunction = SKTTimingFunctionBounceEaseOut
    let valueUpAction = SKAction.actionWithEffect(valueUpEffect)
    let groupUp = SKAction.group([colorUpAction, valueUpAction])
    let colorDownEffect = SKTRingColorEffect(for: ring, to: red, duration: duration)
    colorDownEffect.timingFunction = SKTTimingFunctionBounceEaseOut
    let colorDownAction = SKAction.actionWithEffect(colorDownEffect)
    let valueDownEffect = SKTRingValueEffect(for: ring, to: 0, duration: duration)
    valueDownEffect.timingFunction = SKTTimingFunctionBounceEaseOut
    let valueDownAction = SKAction.actionWithEffect(valueDownEffect)
    let groupDown = SKAction.group([colorDownAction, valueDownAction])
    let sequence = SKAction.sequence([groupUp,
                                       SKAction.wait(forDuration: duration / 3),
                                       groupDown,
                                       SKAction.wait(forDuration: duration / 3)])
    ring.run(SKAction.repeatForever(sequence))
  }
  
  func addNestedRings() {
    let nested = SKNestedRingNode(diameter: diameter, count: 3)
    nested.position = center(forColumn: 4, row: 2)
    addLabel(for: nested, text: "Nested")
    addChild(nested)
    (nested.children[0] as! SKRingNode).arcEnd = 0.33
    (nested.children[1] as! SKRingNode).arcEnd = 0.5
    (nested.children[1] as! SKRingNode).color = blue
    (nested.children[2] as! SKRingNode).arcEnd = 0.67
    (nested.children[2] as! SKRingNode).color = red
  }
}

// MARK - iOS demo helper methods

extension GameScene {
  func center(forColumn column: Int, row: Int) -> CGPoint {
    // assumes row and column begin a 1
    let cellWidth = size.width / CGFloat(columns)
    let cellHeight = size.height / CGFloat(rows)
    let x = CGFloat(column) * cellWidth - cellWidth / 2
    // since the scene origin is in the bottom left, need to adjust to start top left
    let y = CGFloat(rows + 1 - row) * cellHeight - cellHeight / 2
    return CGPoint(x: x, y: y)
  }
  
  func addLabel(for node: SKNode, text: String) {
    let label = SKLabelNode()
    label.verticalAlignmentMode = .center
    label.fontSize = diameter / 11
    label.fontName = "SanFranciscoRounded-Medium"
    label.text = text
    label.position = CGPoint(x: node.position.x, y: node.position.y - diameter / 2 - label.fontSize / 3 * 2)
    addChild(label)
  }
}
