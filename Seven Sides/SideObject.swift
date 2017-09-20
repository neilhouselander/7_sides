//
//  SideObject.swift
//  Seven Sides
//
//  Created by Neil Houselander on 18/09/2017.
//  Copyright © 2017 Neil Houselander. All rights reserved.
//

import Foundation
import SpriteKit

class Side:SKSpriteNode {
    
    let type: colourType
    
    init(type: colourType){
        
        self.type = type
        
        let sideTexture = SKTexture(imageNamed: "side_\(self.type)")
        
        super.init(texture: sideTexture, color: SKColor.clear, size: sideTexture.size())
        
        //Physics
        self.physicsBody = SKPhysicsBody(rectangleOf: self.size)
        self.physicsBody!.affectedByGravity = false
        self.physicsBody?.categoryBitMask = PhysicsCategories.Side
        self.physicsBody?.collisionBitMask = PhysicsCategories.None
        self.physicsBody?.contactTestBitMask = PhysicsCategories.Ball
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
