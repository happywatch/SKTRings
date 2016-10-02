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

/**
 * Performs a linear interpolation between two SKColor values.
 */

public func lerp(start: SKColor, end: SKColor, t: CGFloat) -> SKColor {
  var r1 = CGFloat(), g1 = CGFloat(), b1 = CGFloat(), a1 = CGFloat() // start color components
  var r2 = CGFloat(), g2 = CGFloat(), b2 = CGFloat(), a2 = CGFloat() // end color components
  
  start.getRed(&r1, green: &g1, blue: &b1, alpha: &a1)
  end.getRed(&r2, green: &g2, blue: &b2, alpha: &a2)
  
  return SKColor(red: lerp(start: r1, end: r2, t: t),
                 green: lerp(start: g1, end: g2, t: t),
                 blue: lerp(start: b1, end: b2, t: t),
                 alpha: lerp(start: a1, end: a2, t: t))
}
