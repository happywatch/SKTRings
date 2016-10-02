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

class SKRingNode: SKNode {
  private(set) var diameter: CGFloat
  private(set) var thickness: CGFloat // thickness is decimal percentage of radius, 0...1
  
  var color = SKColor.white {
    didSet {
      update()
    }
  }
  
  var arcEnd: CGFloat = 0 { // decimal percentage of circumference, usually 0...1
    didSet {
      update()
    }
  }
  
  private var foregroundShape = SKShapeNode()
  private var backgroundShape = SKShapeNode()
  
  init(diameter: CGFloat, thickness: CGFloat = 0.2) {
    self.diameter = diameter
    self.thickness = thickness
    
    super.init()
    
    foregroundShape.lineCap = .round
    foregroundShape.zPosition = 2
    backgroundShape.lineCap = .round
    backgroundShape.zPosition = 1
    
    update()
    
    self.addChild(backgroundShape)
    self.addChild(foregroundShape)
  }
  
  required init?(coder decoder: NSCoder) {
    diameter = 0
    thickness = 0
    super.init(coder: decoder)
  }
  
  private func update() {
    foregroundShape.strokeColor = color
    backgroundShape.strokeColor = foregroundShape.strokeColor.withAlphaComponent(0.14)
    
    foregroundShape.lineWidth = diameter / 2 * thickness
    backgroundShape.lineWidth = foregroundShape.lineWidth
    
    let radius = diameter / 2 - foregroundShape.lineWidth / 2
    let startAngle = CGFloat.pi / 2
    let endAngle = startAngle - 2 * .pi * (arcEnd + 0.001) // never exactly zero so that the background arc can always be drawn
    
    // The filled part of the ring
    let foregroundPath = UIBezierPath(arcCenter: CGPoint(), radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: false)
    foregroundShape.path = foregroundPath.cgPath
    
    // The empty part of the ring
    let backgroundPath = UIBezierPath(arcCenter: CGPoint(), radius: radius, startAngle: endAngle, endAngle: startAngle, clockwise: false)
    backgroundShape.path = backgroundPath.cgPath
  }
}

extension SKRingNode {
  var radius: CGFloat {
    return diameter / 2
  }
}

class SKNestedRingNode: SKNode {
  var rings: [SKRingNode] {
    return children.map {
      $0 as! SKRingNode
    }
  }
  
  // `thickness` is the width of each ring. Use a decimal percentage of the radius, 0...1
  // `spacing` is the separation between rings. Use a decimal percentage of the thickness, 0...1
  init(diameter: CGFloat, count: Int, thickness: CGFloat = 0.2, spacing: CGFloat = 0.05) {
    super.init()
    let outerRing = SKRingNode(diameter: diameter, thickness: thickness)
    addChild(outerRing)
    for _ in 0..<(count - 1) {
      guard let previousRing = children.first as? SKRingNode else {
        continue
      }
      let smallerRingDiameter = previousRing.diameter - thickness * outerRing.diameter - spacing * thickness * outerRing.diameter
      let smallerRingThickness = previousRing.diameter * previousRing.thickness / smallerRingDiameter
      let smallerRing = SKRingNode(diameter: smallerRingDiameter, thickness: smallerRingThickness)
      insertChild(smallerRing, at: 0)
    }
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
}

class SKTRingColorEffect: SKTEffect {
  var startColor: SKColor?
  let endColor: SKColor
  
  init(for node: SKRingNode, from startColor: SKColor? = nil, to endColor: SKColor, duration: TimeInterval) {
    self.startColor = startColor
    self.endColor = endColor
    super.init(node: node, duration: duration)
  }
  
  override func update(_ t: CGFloat) {
    if startColor == nil {
      // purposefully not set until now to get current value during action sequence
      startColor = (node as! SKRingNode).color
    }
    let newColor = lerp(start: startColor!, end: endColor, t: t)
    (node as! SKRingNode).color = newColor
  }
}

class SKTRingValueEffect: SKTEffect {
  var arcStart: CGFloat?
  var arcEnd: CGFloat
  
  init(for node: SKRingNode, from arcStart: CGFloat? = nil, to arcEnd: CGFloat, duration: TimeInterval) {
    self.arcStart = arcStart
    self.arcEnd = arcEnd
    super.init(node: node, duration: duration)
  }
  
  override func update(_ t: CGFloat) {
    if arcStart == nil {
      // purposefully not set until now to get current value during action sequence
      arcStart = (node as! SKRingNode).arcEnd
    }
    let newArcEnd = lerp(start: arcStart!, end: arcEnd, t: t)
    (node as! SKRingNode).arcEnd = newArcEnd
  }
}
