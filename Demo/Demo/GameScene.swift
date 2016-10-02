/**
 * Copyright (c) 2016 Ben Morrow
 *
 * MIT License
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

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
      let sequence = SKAction.sequence([colorUpAction,
                                         SKAction.wait(forDuration: duration / 3),
                                         colorDownAction,
                                         SKAction.wait(forDuration: duration / 3)])
      ring.run(SKAction.repeatForever(sequence))
      
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
      // Adjusting color and value. Rings are 0 indexed from innermost to outermost.
      nested.rings[0].arcEnd = 0.33
      nested.rings[1].arcEnd = 0.5
      nested.rings[1].color = blue
      nested.rings[2].arcEnd = 0.67
      nested.rings[2].color = red
    }
  }
}
