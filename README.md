# SKTRings
Animated ring charts in SpriteKit for watchOS 3. Supports bounce easing and color change effects.



The Activity app is one of the prominent features of the Apple Watch. Imagine if the Activity app’s rings could animate to their current value with a bounce effect or change color depending on how recently you moved. Those animations would be both magical and useful. However, you’d have a hard time implementing them with a sequence of images like you used in watchOS 2. Instead, now you can use SpriteKit to achieve those animations.

## API

`SKRingNode` performs the bulk of the calculations and drawing of the ring so that you can focus on the animations you’ll add to it. You control the `thickness` and the `color`. 

`SKNestedRingNode` simplifies creating multiple concentric rings. You control the `spacing` between rings. 

`SKTRingColorEffect` allows you to animate the color of the ring with optional easing. Similarly, `SKTRingValueEffect` allows you to animate the the filled-in value with optional easing.

> **Note**: SKTRings relies on [SKTUtils](http://bit.ly/2dcyDyz) for animation effects. SKUtils is an open source project published by the raywenderlich.com team.
>
>There’s only one file inside SKTUtils that’s not shared with the WatchKit Extension in the Demo app. SKTAudio.swift refers to `AVFoundation` which is not available in watchOS.

The included Demo project shows the different adjustments and animations that you can add to your ring charts for both iOS and watchOS.

## Usage

### Adding a ring

![Ring chart](http://i.imgur.com/WVf5rCa.png)

```swift
let ring = SKRingNode(diameter: diameter)
ring.position = position
addChild(ring)
```

### Adjusting value

![Value ring chart](http://i.imgur.com/JXPjt5b.png)

```swift
let ring = SKRingNode(diameter: diameter)
ring.position = position
addChild(ring)
ring.arcEnd = 0.67 // decimal percentage of circumference, usually 0...1
```

### Adjusting thickness

![Thick ring chart](http://i.imgur.com/Ebk7LF1.png)

```swift
let ring = SKRingNode(diameter: diameter, thickness: 0.4) // decimal percentage of radius, 0...1
ring.position = position
addChild(ring)
```

### Adjusting color

![Color ring chart](http://i.imgur.com/VMmthqJ.png)

```swift
let ring = SKRingNode(diameter: diameter)
ring.position = position
addChild(ring)
ring.color = UIColor.red
```

### Animating with value easing

![Ring chart value animation](https://cloud.githubusercontent.com/assets/5604/19023224/feb4e06c-889d-11e6-81b9-d9bffbb053d7.gif)

```swift
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
```

### Animating with color easing

```swift
case .:
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
```


### Animating with value easing and color easing

```swift
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
```

### Adding a nested ring

![nested ring chart](http://i.imgur.com/VWWjIBo.png)

```swift
case .nested:
let nested = SKNestedRingNode(diameter: diameter, count: 3)
nested.position = position
addChild(nested)
nested.rings[0].arcEnd = 0.33
nested.rings[1].arcEnd = 0.5
nested.rings[1].color = blue
nested.rings[2].arcEnd = 0.67
nested.rings[2].color = red
```

### Adjusting spacing in a nested ring

![Spacing nested ring](http://i.imgur.com/9nL0e9a.png)

```swift
let nested = SKNestedRingNode(diameter: diameter, count: 3, spacing: 0.5)
nested.position = position
addChild(nested)
```

`spacing` is the separation between rings. Use a decimal percentage of the thickness: 0...1. Default value is 0.05.

### Adjusting thickness in a nested ring

![Thickness nested ring](http://i.imgur.com/tXvb1rh.png)

```swift
let nested = SKNestedRingNode(diameter: diameter, count: 3, thickness: 0.3)
nested.position = position
addChild(nested)
```

`thickness` is the width of each ring. Use a decimal percentage of the radius: 0...1. Default value is 0.2.
