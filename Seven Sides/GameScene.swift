//
//  GameScene.swift
//  Seven Sides
//
//  Created by Neil Houselander on 17/09/2017.
//  Copyright © 2017 Neil Houselander. All rights reserved.
//

import SpriteKit
import GameplayKit

//MARK: - Present position = video 4: 0.00

class GameScene: SKScene {
    
    //MARK:- Constants & Variables
    
    var colourWheelBase = SKShapeNode()
    
    let spinColourWheel = SKAction.rotate(byAngle: -convertDegreesToRadians(degrees: 360/7), duration: 0.2) //declare here to avoid re-declaring everytime we touch screen in touchesBegan
    
    var currentGameState = gameState.beforeGame   //so touches does different things at different times
    
    let tapToStartLabel = SKLabelNode(fontNamed: "Caviar Dreams")
    
    
    
    //MARK: - Functions
    
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
        
        tapToStartLabel.text = "Tap To Start"
        tapToStartLabel.fontSize = 100
        tapToStartLabel.fontColor = SKColor.darkGray
        tapToStartLabel.position = CGPoint(x: self.size.width*0.5, y: self.size.height*0.1)
        self.addChild(tapToStartLabel)
        
        prepColourWheel()
        
        
    }
    
    //MARK:- Helper Functions
    
    func prepColourWheel() {
        
        for i in 0...6{
            
            let side = Side(type: colourWheelOrder[i])                                      //class i created, indexing through colour type array
            let basePosition = CGPoint(x: self.size.width*0.5, y: self.size.height*0.25)    //where do i want the side
            side.position = convert(basePosition, to: colourWheelBase)                      //convert this to the parent note co-ord system
            side.zRotation = -colourWheelBase.zRotation                                     //whatever base is rotated by, take this off the side
            colourWheelBase.addChild(side)
        
            colourWheelBase.zRotation += convertDegreesToRadians(degrees: 360/7)            //before next side is added rotate the base
            
        }
        
        //add side positions to the side position array by looping through chidren of colour wheel base
        for aSide in colourWheelBase.children {
            
            let sidePosition = aSide.position
            let positionInScene = convert(sidePosition, from: colourWheelBase)  //convert back to scene co-ordinate system
            sidePositions.append(positionInScene)
            
        }
    }
    
    func spawnBall() {
        
        let ball = Ball()
        ball.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        self.addChild(ball)
        
    }
    
    func startGame() {
        
        spawnBall()
        
        currentGameState = .inGame
        
        let scaleDown = SKAction.scale(to: 0, duration: 0.2)
        let deleteLabel = SKAction.removeFromParent()
        let deleteSequence = SKAction.sequence([scaleDown, deleteLabel])
        tapToStartLabel.run(deleteSequence)
        
        
    }

    //MARK: - Touches Functions
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if currentGameState == .beforeGame {
            
            startGame()
            
        }
        
        else if currentGameState == .inGame {
            
            colourWheelBase.run(spinColourWheel)
            
        }
    }
}













