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
  
  override func sceneDidLoad() {
    backgroundColor = .black
  }
  
  func show(_ ringType: RingType, at position: CGPoint, diameter: CGFloat) {
    switch ringType {
      
    case .standard:
      let ring = SKRingNode(diameter: diameter)
      ring.position = position
      addChild(ring)
      
    case .adjustedValue:
      let ring = SKRingNode(diameter: diameter)
      ring.position = position
      addChild(ring)
      ring.arcEnd = 0.67 // decimal percentage of circumference, usually 0...1
      
    case .adjustedThickness:
      let ring = SKRingNode(diameter: diameter, thickness: 0.4) // decimal percentage of radius, 0...1
      ring.position = position
      addChild(ring)
    
    case .adjustedColor:
      let ring = SKRingNode(diameter: diameter)
      ring.position = position
      addChild(ring)
      ring.color = red
      
    case .withValueEasing:
      let ring = SKRingNode(diameter: diameter)
      ring.position = position
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
      
    case .withColorEasing:
      let ring = SKRingNode(diameter: diameter)
      ring.position = position
      addChild(ring)
      ring.arcEnd = 0.67 // helpfully show more of the filled part
      ring.color = red // starting color
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
      
    case .withValueAndColorEasing:
      let ring = SKRingNode(diameter: diameter)
      ring.position = position
      addChild(ring)
      ring.color = red
      // calculate color in between start and end
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
      
    case .nested:
      let nested = SKNestedRingNode(diameter: diameter, count: 3)
      nested.position = position
      addChild(nested)
      nested.rings[0].arcEnd = 0.33
      nested.rings[1].arcEnd = 0.5
      nested.rings[1].color = blue
      nested.rings[2].arcEnd = 0.67
      nested.rings[2].color = red
    }
  }
}
