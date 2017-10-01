//
//  GameScene.swift
//  Seven Sides
//
//  Created by Neil Houselander on 17/09/2017.
//  Copyright © 2017 Neil Houselander. All rights reserved.
//

import SpriteKit
import GameplayKit

//MARK: - Present position = video 7, 29.16


class GameScene: SKScene, SKPhysicsContactDelegate {
    
    //MARK:- Constants & Variables
    
    var colourWheelBase = SKShapeNode()
    
    let spinColourWheel = SKAction.rotate(byAngle: -convertDegreesToRadians(degrees: 360/7), duration: 0.2) //declare here to avoid re-declaring everytime we touch screen in touchesBegan
    
    var currentGameState = gameState.beforeGame   //so touches does different things at different times
    
    let tapToStartLabel = SKLabelNode(fontNamed: "Caviar Dreams")
    
    let scoreLabel = SKLabelNode(fontNamed: "Caviar Dreams")
    
    let playCorrectSound = SKAction.playSoundFileNamed("correctSound1.wav", waitForCompletion: false)
    let playIncorrectSound = SKAction.playSoundFileNamed("wrongSound.wav", waitForCompletion: false)
    
    var highScore = UserDefaults.standard.integer(forKey: "highScoreSaved")
    
    let highScoreLabel = SKLabelNode(fontNamed: "Caviar Dreams")
    
    //MARK: - Functions
    
    override func didMove(to view: SKView) {
        
        score = 0
        ballMovementSpeed = 2
        
        self.physicsWorld.contactDelegate = self
        
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
        
        scoreLabel.text = "0"
        scoreLabel.position = CGPoint(x: self.size.width*0.5, y: self.size.height*0.85)
        scoreLabel.fontColor = SKColor.darkGray
        scoreLabel.fontSize = 225
        self.addChild(scoreLabel)
        
        highScoreLabel.text = "Best: \(highScore)"
        highScoreLabel.position = CGPoint(x: self.size.width*0.5, y: self.size.height*0.80)
        highScoreLabel.fontColor = SKColor.darkGray
        highScoreLabel.fontSize = 100
        self.addChild(highScoreLabel)
        
        prepColourWheel()
        
        let spinAction = SKAction.rotate(byAngle: -convertDegreesToRadians(degrees: 360), duration: 10)
        let keepSpinning = SKAction.repeatForever(spinAction)
        colourWheelBase.run(keepSpinning)
        
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
        
        let setForStart = SKAction.rotate(toAngle: 0, duration: 0.1)
        
        colourWheelBase.removeAllActions()
        colourWheelBase.run(setForStart)
        
        spawnBall()
        
        currentGameState = .inGame
        
        let scaleDown = SKAction.scale(to: 0, duration: 0.2)
        let deleteLabel = SKAction.removeFromParent()
        let deleteSequence = SKAction.sequence([scaleDown, deleteLabel])
        tapToStartLabel.run(deleteSequence)
        
    }
    
    func checkMatch(ball:Ball, side:Side) {
        
        if ball.type == side.type {
            //correct
            print("Match")
            correctMatch(ball: ball)
            

        }
        else {
            //incorrect
            print("No match")
            wrongMatch(ball:ball)
        }
    }
    
    func correctMatch(ball:Ball) {
        
        self.run(playCorrectSound)
        
        ball.delete()
        
        score += 1
        scoreLabel.text = "\(score)"
        
        switch score {
        case 5:  ballMovementSpeed = 1.8
        case 15: ballMovementSpeed = 1.6
        case 25: ballMovementSpeed = 1.4
        case 40: ballMovementSpeed = 1.2
        case 60: ballMovementSpeed = 1.0
        default:
            print("error with ball movement speed")
        }
        
        if score > highScore {
            highScoreLabel.text = "Best: \(score)"
        }

        spawnBall()
    }
    
    func wrongMatch(ball:Ball) {
        
        if score > highScore {
            highScore = score
            UserDefaults.standard.set(highScore, forKey: "highScoreSaved")
        }
        
        ball.flash()
        ball.run(playIncorrectSound)
        currentGameState = .afterGame
        
        colourWheelBase.removeAllActions()
        
        let waitAction = SKAction.wait(forDuration: 3)
        let changeScene = SKAction.run {
            
            //do this way as its an sks scene we are moving to
            let sceneToMoveTo = SKScene(fileNamed: "GameOverScene")!
            sceneToMoveTo.scaleMode = self.scaleMode
            let sceneTransition = SKTransition.doorsCloseHorizontal(withDuration: 0.5)
            self.view!.presentScene(sceneToMoveTo, transition: sceneTransition)
        }
        
        let sceneChangeSequence = SKAction.sequence([waitAction, changeScene])
        self.run(sceneChangeSequence)
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
    
    //MARK:- Contact
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        //set up 2 constants to hold physics contacts
        let ball: Ball
        let side: Side
        
        //check which is contact bodyA & which is contact.bodyB---> and assign to the constant just made
        if contact.bodyA.categoryBitMask == PhysicsCategories.Ball {
            
            ball = contact.bodyA.node! as! Ball
            side = contact.bodyB.node! as! Side
            
        }
        else {
            
            ball = contact.bodyB.node! as! Ball
            side = contact.bodyA.node! as! Side
        }
        
        if ball.isActive {                      //property of every ball, to avoid duplicate contacts
            
            checkMatch(ball: ball, side: side)

            
        }
    }
}













