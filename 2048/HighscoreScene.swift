//
//  HighscoreScene.swift
//  2048
//
//  Created by per thoresson on 9/4/17.
//  Copyright © 2017 per thoresson. All rights reserved.
//


import SpriteKit
import GameplayKit
import GoogleMobileAds

class HighscoreScene: SKScene {
    
    var bannerView: GADBannerView!
    var bannerDisplayed:Bool = false
    var scoreManager:GameScoreManager! = nil
    var scoreView:SCNView! = nil
    var scoreSCNScene:SCNScene! = nil
    
    // Camera and Light
    var cameraNode:SCNNode! = nil
    var light:SCNLight! = nil
    var lightNode:SCNNode! = nil
    var lockNode:SCNNode! = nil
    
    
    var gameViewController : GameViewController!
    
    override func didMove(to view: SKView) {
        
        highscoreScene = self;
        self.view?.backgroundColor = UIColor.clear
        print("HighscoreScene - didMove")
        
        scoreManager = GameScoreManager.sharedInstance
        
        setupBg()                           //  background addition
        assignTextures()                    // prepare textures
        addStructure()                      // Add prerequisites
        addNavigation()
        populateScore()
        animateIn()
    }
    
    func setupBg(){
        let bg = SKSpriteNode(color: UIColor.black, size: CGSize(width: screenW, height: screenH))
        bg.position = CGPoint(x: screenW / 2, y: screenH / 2)
        self.addChild(bg)
    }
    
    func assignTextures(){
        
    }
    
    func addStructure(){
        print("addStructure")
        scoreView = SCNView(frame: (self.view?.frame)!)
        scoreView.backgroundColor = UIColor.clear
        self.view?.insertSubview(scoreView, at: 0)       // add sceneView as SubView
        scoreSCNScene = SCNScene()
        scoreView.scene = scoreSCNScene
        let camera = SCNCamera()                        // Camera
        cameraNode = SCNNode()
        cameraNode.camera = camera
        cameraNode.position = gameCameraIn
        light = SCNLight()                              // Light
        light.type = SCNLight.LightType.spot
        light.intensity = 1000
        light.spotInnerAngle = 50.0
        light.spotOuterAngle = 300.0
        light.castsShadow = true
        lightNode = SCNNode()
        lightNode.light = light
        lightNode.position = gamelightPosition
        // create lock object
        logoMat.diffuse.contents = logoBlue
        let lockGeometry = SCNBox(width: side/4, height: side/4, length: side/4, chamferRadius: radius/4)  // Cube Anim
        lockNode = SCNNode(geometry: lockGeometry)
        lockNode.name = "lock"
        lockNode.geometry?.materials = [logoMat]
        lockNode.position = SCNVector3(x: 0.0, y: 0.0, z: 0.0)
        lockNode.scale = SCNVector3Make(0.01, 0.01, 0.01)
        let constraint = SCNLookAtConstraint(target: lockNode)                  // Constraints
        constraint.isGimbalLockEnabled = true
        cameraNode.constraints = [constraint]
        lightNode.constraints = [constraint]
        scoreSCNScene.rootNode.addChildNode(lockNode)        // Add to scene
        scoreSCNScene.rootNode.addChildNode(lightNode)
        scoreSCNScene.rootNode.addChildNode(cameraNode)
    }
    
    func addNavigation(){
        
    }
    
    func populateScore(){
        // get score from scoremanager
        let scoreList = scoreManager.getScores()
        print("scoreList is : ", type(of: scoreList))
        // loop through the scores and create decending scoreboard
        for score in scoreList {
            // do something with score.
            print("SCORE IS : ", score)
            createScoreItem(score:score)
        }
    }
    
    func createScoreItem(score:Int){
        
    }
    
    func animateIn(){
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
