//
//  FibonacciScene.swift
//  FibonacciApp
//
//  Created by AnishG on 11/17/19.
//  Copyright © 2019 playground. All rights reserved.
//

import Foundation
import SpriteKit

class FibonacciScene: SKScene {
    
    var seeds = 10
    
    override func didMove(to view: SKView) {
        //        oldDegrees = degrees
        //        for i in 1...seeds {
        //            Timer.scheduledTimer(withTimeInterval: 0.4, repeats: false) { (timer) in
        //                self.spawnCircle()
        //            }
        //        }
    }
    
    var positionX:Double = 0.0
    var addX: Double = 0
    var positionY:Double = 0.0
    var addY: Double = 0
    var ratio: Double = 0.48
    var radius = 30.0
    var circumference: Double = 0
    var oldDegrees: Double = 0.0
    var degrees = 0.0
    var totalDegrees = 0.0
    var distance: Double = 0
    var tracker: Int = 1
    var factor = 0.0
    
    func getPosition(degrees: Double) -> CGPoint {
        let y = radius * cos(Double(degrees))
        let x = radius * sin(Double(degrees))
        return CGPoint(x: x, y: y)
    }
    func start(seedNumber: Int, ratio: Double) {
        reset()
        self.ratio = ratio
        seeds = seedNumber
        oldDegrees = ratio * 360
        for i in 1...seeds {
            Timer.scheduledTimer(withTimeInterval: 0.01, repeats: false) { (timer) in
                self.spawnCircle()
            }
        }
    }
    func reset() {
        removeAllChildren()
        factor = 0.0
        positionX = 0.0
        addX = 0
        positionY = 0.0
        addY = 0
        ratio = 0.48
        radius = 30.0
        circumference = 0
        oldDegrees = 0.0
        degrees = 0.0
        totalDegrees = 0.0
        distance = 0
        tracker = 0
        seeds = 10
        
    }
    func spawnCircle() {
        degrees += oldDegrees
        let radians = (CGFloat(degrees) * CGFloat(2) * CGFloat.pi)/360
        //print(radians)
        let node = SKShapeNode(circleOfRadius: 5)
        //print("degrees:\(oldDegrees)")
        totalDegrees += oldDegrees
        //print("totalDegrees:\(totalDegrees)")
        node.alpha = 0
        node.fillColor = UIColor.red
        node.position = CGPoint(x: sin(radians) * CGFloat(radius),
                                y: cos(radians) * CGFloat(radius))
        if totalDegrees > 360.0 {
            totalDegrees = 0
            print("\(tracker): REMAINDER IS \(totalDegrees.truncatingRemainder(dividingBy: 360.0))")
            factor += 2
            print("factor: \(factor), radius: \(radius)")
            node.position = CGPoint(x: (sin(radians) * CGFloat(radius + factor)), y: (cos(radians) * CGFloat(radius + factor)))
        }
        let action = SKAction.fadeAlpha(to: 1, duration: 0.01)
        // print("\(tracker): \(radians) radians")
        print("\(tracker)-  x value: sin(\(radians)) = \(sin(radians))")
        tracker += 1
        addChild(node)
        node.run(action)
        print(node.position)
        //        degrees += oldDegrees
    }
}

