//
//  BallObject.swift
//  Seven Sides
//
//  Created by Neil Houselander on 19/09/2017.
//  Copyright © 2017 Neil Houselander. All rights reserved.
//

import Foundation
import SpriteKit

class Ball: SKSpriteNode {
    
    let type: colourType
    var isActive:Bool = true
    
    init() {
        
        let randomTypeIndex = Int(arc4random()%7)
        self.type = colourWheelOrder[randomTypeIndex]
        
        let ballTexture = SKTexture(imageNamed: "ball_\(self.type)")
        
        super.init(texture: ballTexture, color: SKColor.clear, size: ballTexture.size())
        
        //physics
        self.physicsBody = SKPhysicsBody(circleOfRadius: 55)
        self.physicsBody!.affectedByGravity = false
        self.physicsBody?.categoryBitMask = PhysicsCategories.Ball
        self.physicsBody?.collisionBitMask = PhysicsCategories.None
        self.physicsBody?.contactTestBitMask = PhysicsCategories.Side
        
        
        //scale in
        self.setScale(0)
        
        let scaleInAction = SKAction.scale(to: 1, duration: 0.2)
        
        //move to random side
        let randomSideIndex = Int(arc4random()%7)
        
        let sideToMoveTo = sidePositions[randomSideIndex]                   //array created in gamescene when colour wheel created
        
        let moveToSideAction = SKAction.move(to: sideToMoveTo, duration: ballMovementSpeed)
        
        let ballSpawnSequence = SKAction.sequence([scaleInAction, moveToSideAction])
        
        self.run(ballSpawnSequence)

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //Ball Methods
    
    func delete() {
        
        self.isActive = false                                   //make sure only active balls can be deleted - avoid duplicate contacts on scale out
        
        self.removeAllActions()
        let scaleDown = SKAction.scale(to: 0, duration: 0.2)
        let deleteBall = SKAction.removeFromParent()
        let deleteSequence = SKAction.sequence([scaleDown, deleteBall])
        self.run(deleteSequence)
        
    }
    
    func flash() {
        
        self.removeAllActions()
        self.isActive = false
        
        let fadeOut = SKAction.fadeOut(withDuration: 0.4)
        let fadeIn = SKAction.fadeIn(withDuration: 0.4)
        let fadeSequence = SKAction.sequence([fadeOut, fadeIn])
        let repeatFlash = SKAction.repeat(fadeSequence, count: 3)
        
        self.run(repeatFlash)
        
    }
}
