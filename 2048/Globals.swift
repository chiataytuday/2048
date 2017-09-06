//
//  Globals.swift
//  2048
//
//  Created by per thoresson on 9/1/17.
//  Copyright © 2017 per thoresson. All rights reserved.
//

import Foundation
import SpriteKit
import SceneKit
import UIKit

// Textures
let GameLogo = SKTexture(imageNamed: "2048Logo.png")
let homePlayBtn = SKTexture(imageNamed: "homePlayBtn.png")


// Material textures
let text2 = UIImage(named: "tex2")
let text4 = UIImage(named: "tex4")
let text8 = UIImage(named: "tex8")
let text16 = UIImage(named: "tex16")
let text32 = UIImage(named: "tex32")
let text64 = UIImage(named: "tex64")
let text128 = UIImage(named: "tex128")
let text256 = UIImage(named: "tex256")
let text512 = UIImage(named: "tex512")
let text1024 = UIImage(named: "tex1024")
let text2048 = UIImage(named: "tex2048")

// Color Textures
let col2 = UIColor(red:0.73, green:0.29, blue:0.29, alpha:1.0)
let col4 = UIColor(red:0.73, green:0.29, blue:0.29, alpha:1.0)
let col8 = UIColor(red:0.73, green:0.29, blue:0.29, alpha:1.0)
let col16 = UIColor(red:0.73, green:0.29, blue:0.29, alpha:1.0)
let col32 = UIColor(red:0.73, green:0.29, blue:0.29, alpha:1.0)
let col64 = UIColor(red:0.73, green:0.29, blue:0.29, alpha:1.0)
let col128 = UIColor(red:0.73, green:0.29, blue:0.29, alpha:1.0)
let col256 = UIColor(red:0.73, green:0.29, blue:0.29, alpha:1.0)
let col512 = UIColor(red:0.73, green:0.29, blue:0.29, alpha:1.0)
let col1024 = UIColor(red:0.73, green:0.29, blue:0.29, alpha:1.0)
let col2048 = UIColor(red:0.73, green:0.29, blue:0.29, alpha:1.0)

// Size params
//------------------------------

var screenSize: CGRect = UIScreen.main.bounds
var screenW = screenSize.width
var screenH = screenSize.height
//------------------------------

// Scenes
var gameScene: SKScene!
var homeScene: SKScene!
var settingsScene: SKScene!
var infoScene: SKScene!
var highscoreScene: SKScene!

// Animation and transition timings
let scaleUpAction = SKAction.scale(to: 1.5, duration: 0.3)
let scaleDownAction = SKAction.scale(to: 1, duration: 0.3)
let waitAction = SKAction.wait(forDuration: 2)
let scaleActionSequence = SKAction.sequence([scaleUpAction, scaleDownAction, waitAction])

// Layers
struct layers {
    
    static let background: CGFloat = 0
    static let characters: CGFloat = 2
    static let projectiles: CGFloat = 3
    static let navigation: CGFloat = 4
}

// Cube Materials
let mat2 = SCNMaterial()
let mat4 = SCNMaterial()
let mat8 = SCNMaterial()
let mat16 = SCNMaterial()
let mat32 = SCNMaterial()
let mat64 = SCNMaterial()
let mat128 = SCNMaterial()
let mat256 = SCNMaterial()
let mat512 = SCNMaterial()
let mat1024 = SCNMaterial()
let mat2048 = SCNMaterial()


// Cube Properties
let side: CGFloat = 1 // one side of the cube
let radius: CGFloat = side / 12 // the corner radius
// Camera Properties
let homeCamera = SCNVector3(x: 0.0, y: 0.5, z: 4.0)
let gameCamera = SCNVector3(x: 0.0, y: 0.0, z: 3.0)

