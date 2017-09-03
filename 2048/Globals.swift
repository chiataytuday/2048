//
//  Globals.swift
//  2048
//
//  Created by per thoresson on 9/1/17.
//  Copyright © 2017 per thoresson. All rights reserved.
//

import Foundation
import SpriteKit

// Textures
let GameLogo = SKTexture(imageNamed: "2048Logo.png")


// Size params
//------------------------------
var screenSize: CGRect = UIScreen.main.bounds
var gameScreenW = gameScene.frame.size.width
var gameScreenH = gameScene.frame.size.height
//------------------------------

// Scenes
var gameScene: SKScene!
var homeScene: SKScene!
var settingsScene: SKScene!
var infoScene: SKScene!
var highscoreScene: SKScene!
