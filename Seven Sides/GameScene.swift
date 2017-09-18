//
//  GameScene.swift
//  Seven Sides
//
//  Created by Neil Houselander on 17/09/2017.
//  Copyright © 2017 Neil Houselander. All rights reserved.
//

import SpriteKit
import GameplayKit

//MARK: - Present position = video 2: 26.07

class GameScene: SKScene {
    
    var colourWheelBase = SKShapeNode()
    
    let spinColourWheel = SKAction.rotate(byAngle: -convertDegreesToRadians(degrees: 360/7), duration: 0.2) //declare here to avoid re-declaring everytime we touch screen in touchesBegan
    
    override func didMove(to view: SKView) {
        
        let background = SKSpriteNode(imageNamed: "gameBackground")
        background.size = self.size
        background.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        background.zPosition = -1
        self.addChild(background)
        
        colourWheelBase = SKShapeNode(rectOf: CGSize(width: self.size.width*0.8, height: self.size.height*0.8))
        colourWheelBase.position = CGPoint(x: self.size.width*0.5, y: self.size.height*0.5)
        colourWheelBase.fillColor = SKColor.clear
        colourWheelBase.strokeColor = SKColor.clear
        self.addChild(colourWheelBase)
        
        prepColourWheel()
        
    }
    
    func prepColourWheel() {
        
        for i in 0...6{
            
            let side = Side(type: colourWheelOrder[i]) //class i created, indexing through colour type array
            let basePosition = CGPoint(x: self.size.width*0.5, y: self.size.height*0.25)//where do i want the side
            side.position = convert(basePosition, to: colourWheelBase)//convert this to the parent note co-ord system
            side.zRotation = -colourWheelBase.zRotation //whatever base is rotated by, take this off the side
            colourWheelBase.addChild(side)
        
            colourWheelBase.zRotation += convertDegreesToRadians(degrees: 360/7) //before next side is added rotate the base
            
        }
    }

    //MARK: - touches functions
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        colourWheelBase.run(spinColourWheel)
        
        
    }
    
    
}
