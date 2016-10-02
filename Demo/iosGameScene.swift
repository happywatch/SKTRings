//
//  iosGameScene.swift
//  Demo
//
//  Created by temporary on 10/2/16.
//  Copyright © 2016 benmorrow. All rights reserved.
//

import SpriteKit

class iosGameScene: GameScene {
  // Configuration for only iOS
  let iosColumns = 4
  let iosRows = 2
  lazy var iosDiameter: CGFloat = {
    let minLength = min(self.size.width / CGFloat(self.iosColumns), self.size.height / CGFloat(self.iosRows))
    let margin = minLength * 0.1
    return minLength - margin
  }()
  
  func showAll() {
    // Iterate through all values for RingType
    var i = 0
    while let ringType = RingType(rawValue: i) {
      let placement = ringType.iosPlacement
      let position = center(forColumn: placement.column, row: placement.row)
      show(ringType, at: position, diameter: iosDiameter)
      addLabelForNode(at: position, text: ringType.simpleDescription)
      i += 1
    }
  }
}

// MARK - iOS demo helpers

extension RingType {
  var iosPlacement: (column: Int, row: Int) {
    switch self {
    case .standard:
      return (column: 1, row: 1)
    case .adjustedValue:
      return (column: 2, row: 1)
    case .adjustedThickness:
      return (column: 3, row: 1)
    case .adjustedColor:
      return (column: 4, row: 1)
    case .withValueEasing:
      return (column: 1, row: 2)
    case .withColorEasing:
      return (column: 2, row: 2)
    case .withValueAndColorEasing:
      return (column: 3, row: 2)
    case .nested:
      return (column: 4, row: 2)
    }
  }
}

extension iosGameScene {
  func center(forColumn column: Int, row: Int) -> CGPoint {
    // assumes row and column begin a 1
    let cellWidth = size.width / CGFloat(iosColumns)
    let cellHeight = size.height / CGFloat(iosRows)
    let x = CGFloat(column) * cellWidth - cellWidth / 2
    // since the scene origin is in the bottom left, need to adjust to start top left
    let y = CGFloat(iosRows + 1 - row) * cellHeight - cellHeight / 2
    return CGPoint(x: x, y: y)
  }
  
  func addLabelForNode(at position: CGPoint, text: String) {
    let label = SKLabelNode()
    label.verticalAlignmentMode = .center
    label.fontSize = iosDiameter / 11
    label.fontName = "SanFranciscoRounded-Medium"
    label.text = text
    label.position = CGPoint(x: position.x, y: position.y - iosDiameter / 2 - label.fontSize / 3 * 2)
    addChild(label)
  }
}
