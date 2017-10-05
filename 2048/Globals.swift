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
let GameLogo = SKTexture(imageNamed: "GameLogo.png")
let homePlayBtn = SKTexture(imageNamed: "NewGame.png")
let metalMapTexture = SKTexture(imageNamed: "kMetalMap.png")

let defaultGridValue:Int = 1000

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

let logoBlue = UIColor(red:0.40, green:0.74, blue:0.88, alpha:1.0)

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

let sceneTransitionFade = SKTransition.fade(with: UIColor.black, duration: 1.0)
let sceneTransitionCrossFade = SKTransition.crossFade(withDuration: 1.0)

// Scenes
struct scenes {
    static let game: CGFloat = 0
    static let home: CGFloat = 1
    static let settings: CGFloat = 2
    static let info: CGFloat = 3
    static let score: CGFloat = 4
}

// Layers
struct layers {
    static let background: CGFloat = 0
    static let characters: CGFloat = 2
    static let projectiles: CGFloat = 3
    static let navigation: CGFloat = 4
}

// Swipe Direction definitions
struct swipe {
    static let up: CGFloat = 0
    static let down: CGFloat = 1
    static let left: CGFloat = 2
    static let right: CGFloat = 3
}

struct column {
    static let zero: Int = 0
    static let one: Int = 1
    static let two: Int = 2
    static let three: Int = 3
}

struct row {
    static let zero: Int = 0
    static let one: Int = 1
    static let two: Int = 2
    static let three: Int = 3
}

struct material {
    static let m2: CGFloat = 0
    static let m4: CGFloat = 1
    static let m8: CGFloat = 2
    static let m16: CGFloat = 3
    static let m32: CGFloat = 4
    static let m64: CGFloat = 5
    static let m128: CGFloat = 6
    static let m256: CGFloat = 7
    static let m512: CGFloat = 8
    static let m1024: CGFloat = 9
    static let m2048: CGFloat = 10
}

struct tilevalue {
    static let v2: Int = 2
    static let v4: Int = 4
    static let v8: Int = 8
    static let v16: Int = 16
    static let v32: Int = 32
    static let v64: Int = 64
    static let v128: Int = 128
    static let v256: Int = 256
    static let v512: Int = 512
    static let v1024: Int = 1024
    static let v2048: Int = 2048
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

// Nav Materials
let navFaceMat = SCNMaterial()
let navExtrutionMat = SCNMaterial()

// Logo Materials
let logoMat = SCNMaterial()
let logoTextMat = SCNMaterial()

// Scoreboard Materials
let scoreBgMat = SCNMaterial()

// Cube Properties
let side: CGFloat = 2 // one side of the cube
let radius: CGFloat = side / 12 // the corner radius

// light Properties
let spotlightPosition = SCNVector3(x: -1.0, y: 2.2, z: 7.8)
let gamelightPosition = SCNVector3(x: -1.0, y: 2.2, z: 7.8)


// Camera Properties
let homeCameraIn = SCNVector3(x: 0.0, y: 0.7, z: 6.8)
let homeCameraOut = SCNVector3(x: 0.0, y: 60, z: -5.0)
let gameCameraIn = SCNVector3(x: 0.0, y: 0.0, z: 3.0)
let gameCameraOut = SCNVector3(x: 0.0, y: 0.0, z: 3.0)

// Scene floor Properties
let homefloorIn = SCNVector3(x: 0, y: -1.0, z: 0)
let homefloorOut = SCNVector3(x: 0, y: 0.0, z: 30.0)

// Home logo Properties
let homeLogoIn = SCNVector3(x: 0, y: 2.0, z: 1.4)
let homeLogoOut = SCNVector3(x: 0, y: 5, z: 0.6)

// scoreboard Position - Gamescene
let gameScoreIn = SCNVector3(x: 0, y: 1.0, z: 1.5 )
let gameScoreOut = SCNVector3(x: 0, y: 1.0, z: 1.5 )

// Navigation items Properties
let playBtnIn = SCNVector3(x: 0, y: -0.97, z: 3.3)
let playBtnOut = SCNVector3(x: 0, y: -0.97, z: 8)

let scoreBtnIn = SCNVector3(x: 0, y: -0.91, z: 4.3)
let scoreBtnOut = SCNVector3(x: 0, y: -0.91, z: 8)

let infoBtnIn = SCNVector3(x: 0.5, y: -0.92, z: 4.2)
let infoBtnOut = SCNVector3(x: 0.5, y: -0.92, z: 8)

let settingsBtnIn = SCNVector3(x: -0.5, y: -0.95, z: 4.2)
let settingsBtnOut = SCNVector3(x: -0.5, y: -0.95, z: 8)

