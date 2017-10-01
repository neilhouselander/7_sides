//
//  MainMenuScene.swift
//  Seven Sides
//
//  Created by Neil Houselander on 01/10/2017.
//  Copyright © 2017 Neil Houselander. All rights reserved.
//

import Foundation
import SpriteKit

class MainMenu: SKScene {
    
    var playLabel = SKLabelNode()
    
    override func didMove(to view: SKView) {
        
        playLabel = self.childNode(withName: "playLabel") as! SKLabelNode
        
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touchPoint in touches {
            
            let pointOfTouch = touchPoint.location(in: self)
            
            if playLabel.contains(pointOfTouch) {
                
                let sceneToMoveTo = GameScene(size: self.size)
                sceneToMoveTo.scaleMode = self.scaleMode
                let trans = SKTransition.doorsCloseHorizontal(withDuration: 0.5)
                
                self.view!.presentScene(sceneToMoveTo, transition: trans)
            }
        }
    }
    
}
