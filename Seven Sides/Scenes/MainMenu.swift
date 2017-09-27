//
//  MainMenu.swift
//  Seven Sides
//
//  Created by Neil Houselander on 27/09/2017.
//  Copyright © 2017 Neil Houselander. All rights reserved.
//

import Foundation
import SpriteKit

class MainMenuScene: SKScene {
    
    var playLabel = SKLabelNode()
    
    override func didMove(to view: SKView) {
        
        playLabel = self.childNode(withName: "playLabel") as! SKLabelNode
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch: AnyObject in touches {
            
            let pointOfTouch = touch.location(in: self)
            if playLabel.contains(pointOfTouch) {
                
                let sceneToMoveTo = GameScene(size: self.size)
                sceneToMoveTo.scaleMode = self.scaleMode
                let sceneTransition = SKTransition.doorsCloseHorizontal(withDuration: 0.5)
                self.view!.presentScene(sceneToMoveTo, transition: sceneTransition)
                
            }
        }
    }
}
