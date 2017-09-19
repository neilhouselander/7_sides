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
    
    init() {
        
        let randomTypeIndex = Int(arc4random()%7)
        self.type = colourWheelOrder[randomTypeIndex]
        
        let ballTexture = SKTexture(imageNamed: "ball_\(self.type)")
        
        super.init(texture: ballTexture, color: SKColor.clear, size: ballTexture.size())
        
        //scale in
        self.setScale(0)
        
        let scaleInAction = SKAction.scale(to: 1, duration: 0.2)
        
        //move to random side
        let randomSideIndex = Int(arc4random()%7)
        
        let sideToMoveTo = sidePositions[randomSideIndex] //array created in gamescene when colour wheel created
        
        let moveToSideAction = SKAction.move(to: sideToMoveTo, duration: 2)
        
        let ballSpawnSequence = SKAction.sequence([scaleInAction, moveToSideAction])
        
        self.run(ballSpawnSequence)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    
    
    
}
