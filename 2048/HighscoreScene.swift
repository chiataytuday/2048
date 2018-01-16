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
    
    var backPanel:SCNNode! = nil
    
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
        addStructure()                      // Add prerequisites
        addBackPanel()
        populateScore()
        animateIn()
    }
    
    func setupBg(){
        let bg = SKSpriteNode(color: UIColor.black, size: CGSize(width: screenW, height: screenH))
        bg.position = CGPoint(x: screenW / 2, y: screenH / 2)
        self.addChild(bg)
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
        cameraNode.position = highscoreCameraOut
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
    

    
    func addBackPanel(){
        endpanelBgMat.diffuse.contents = col2048
        let panelGeometry = SCNBox(width: panelWidth, height: panelHeight, length: panelDepth, chamferRadius: panelRadius)  // Cube Anim
        backPanel = SCNNode(geometry: panelGeometry)
        backPanel.name = "endpanel"
        backPanel.geometry?.materials = [endpanelBgMat]
        backPanel.position = SCNVector3(x: 0, y: 0, z: 0)
        backPanel.pivot = SCNMatrix4MakeRotation(0.785398, 0, 0, 0);
        backPanel.scale = SCNVector3Make(2.5, 2.5, 2.5)
        scoreSCNScene.rootNode.addChildNode(backPanel)
        
        let headerTxt = SCNText(string: "HIGHSCORE", extrusionDepth: 8)
        headerTxt.font = UIFont(name: "Hangar-Flat", size: 20)
        let headerNode = SCNNode(geometry: headerTxt)
        headerNode.name = "gameoverHeader"
        headerNode.scale = SCNVector3Make(0.03, 0.03, 0.03)
        headerNode.position = SCNVector3Make(0.0, 1.35, 0.55)
        headerTxt.flatness = 0.1
        headerTxt.chamferRadius = 0.1
        var goMinVec = SCNVector3Zero
        var goMaxVec = SCNVector3Zero
        if headerNode.__getBoundingBoxMin(&goMinVec, max: &goMaxVec) {
            let distance = SCNVector3(
                x: goMaxVec.x - goMinVec.x,
                y: goMaxVec.y - goMinVec.y,
                z: goMaxVec.z - goMinVec.z)
            headerNode.pivot = SCNMatrix4MakeTranslation(distance.x / 2, distance.y / 3, distance.z / 2)
        }
        headerTxt.firstMaterial!.diffuse.contents = UIColor.white
        headerTxt.firstMaterial!.specular.contents = UIColor.white
        
        scoreSCNScene.rootNode.addChildNode(headerNode)
        
        // add home button
        let homeBtnTxt = SCNText(string: "\u{f38f}", extrusionDepth: 8)
        homeBtnTxt.font = UIFont(name: "Ionicons", size: 20)
        let homeBtnNode = SCNNode(geometry: homeBtnTxt)
        homeBtnNode.name = "homeBtn"
        homeBtnNode.scale = SCNVector3Make(0.035, 0.035, 0.035)
        homeBtnNode.position = SCNVector3Make(0.0, -1.65, 0.55)
        homeBtnTxt.flatness = 0.1
        homeBtnTxt.chamferRadius = 0.1
        var hbMinVec = SCNVector3Zero
        var hbMaxVec = SCNVector3Zero
        if homeBtnNode.__getBoundingBoxMin(&hbMinVec, max: &hbMaxVec) {
            let distance = SCNVector3(
                x: hbMaxVec.x - hbMinVec.x,
                y: hbMaxVec.y - hbMinVec.y,
                z: hbMaxVec.z - hbMinVec.z)
            homeBtnNode.pivot = SCNMatrix4MakeTranslation(distance.x / 2, distance.y / 3, distance.z / 2)
        }
        homeBtnTxt.firstMaterial!.diffuse.contents = UIColor.white
        homeBtnTxt.firstMaterial!.specular.contents = UIColor.white
        
        scoreSCNScene.rootNode.addChildNode(homeBtnNode)
    }
    
    func populateScore(){
        let scoreList = scoreManager.getScores()    // get score from scoremanager
        for index in 0...4 {    // loop through the scores and create decending scoreboard
            var score = 0
            if index<scoreList.count { score = scoreList[index] }
            createScoreItem(score:score, pos:index)
            print("SCORE IS : ", score)
        }
    }
    
    func createScoreItem(score:Int, pos:Int){
        let startPos = 0.7
        let stepPos:Float = Float(startPos-(0.45*Double(pos)))
        let txt = SCNText(string: String(pos+1)+". "+String(score), extrusionDepth: 8)
        txt.font = UIFont(name: "Ionicons", size: 20)
        let node = SCNNode(geometry: txt)
        node.name = "node"+String(pos)
        node.scale = SCNVector3Make(0.023, 0.023, 0.023)
        node.position = SCNVector3Make(-1.1, stepPos , 0.42)
        txt.flatness = 0.1
        txt.chamferRadius = 0.1
        txt.firstMaterial!.diffuse.contents = UIColor.white
        txt.firstMaterial!.specular.contents = UIColor.white
        scoreSCNScene.rootNode.addChildNode(node)
    }
    
    func animateIn(){
        SCNTransaction.begin()
        SCNTransaction.animationDuration = 1.0
        cameraNode.position = highscoreCameraIn
        light.intensity = 1200
        SCNTransaction.commit()
    }
    
    func animateOut(){
        SCNTransaction.begin()
        SCNTransaction.animationDuration = 1.0
        cameraNode.position = highscoreCameraOut
        light.intensity = 0
        SCNTransaction.commit()
    }
    
    // Touch handlers
    func touchDown(atPoint pos : CGPoint) {}
    func touchMoved(toPoint pos : CGPoint) {}
    func touchUp(atPoint pos : CGPoint) {}
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
        
        let touch = touches.first
        if let touchPoint = touch?.location(in: self.scoreView),
            let hitTestResult = self.scoreView.hitTest(touchPoint, options: nil).first {
            let hitNode = hitTestResult.node
            print("Name : ",hitNode.name as Any)
            var exit:CGFloat? = nil
            if hitNode.name == "homeBtn" { exit = scenes.home }
            if exit != nil {
                exitToScene(scene: exit!)
            }
        }
    }
    
    // Transition to scenes
    // ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
    func exitToScene(scene:CGFloat){
        run(SKAction.sequence([
            SKAction.run() {
                self.cameraNode.constraints = nil
                self.removeSceneAnim()
            },
            SKAction.wait(forDuration: 1.0),
            SKAction.run() {
                self.gameViewController.moveToScene(to: scene)
            }
            ]), withKey:"transitioning")
    }
    
    func removeSceneAnim(){
        // animate cube out
        SCNTransaction.begin()
        SCNTransaction.animationDuration = 1.0
        cameraNode.position = highscoreCameraOut
        light.intensity = 0
        SCNTransaction.commit()
        // animate logo out
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
