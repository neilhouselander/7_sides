//
//  ModelsAndData.swift
//  Seven Sides
//
//  Created by Neil Houselander on 18/09/2017.
//  Copyright © 2017 Neil Houselander. All rights reserved.
//

import Foundation
import SpriteKit

//////////////////////////Sides & Ball Info//////////////////////
enum colourType {
    
    case Red
    case Orange
    case Pink
    case Blue
    case Yellow
    case Purple
    case Green
    
}

let colourWheelOrder:[colourType] = [
    colourType.Red,
    colourType.Orange,
    .Yellow,
    .Green,
    .Blue,
    .Purple,
    .Pink
]

var sidePositions:[CGPoint] = []



//////////////////////////Game State///////////////////////////

enum gameState {
    
    case beforeGame
    case inGame
    case afterGame
}

//////////////////////Physics Categories//////////////////////
struct PhysicsCategories {
    
    static let None:UInt32 = 0
    static let Ball:UInt32 = 0b1
    static let Side:UInt32 = 0b10
    
}

///////////////////////////Score System/////////////////////////////

var score: Int = 0


//////////////////////Level System//////////////////////

var ballMovementSpeed:TimeInterval = 2
