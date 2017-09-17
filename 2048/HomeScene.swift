//
//  HomeScene.swift
//  2048
//
//  Created by per thoresson on 9/1/17.
//  Copyright © 2017 per thoresson. All rights reserved.
//

import SpriteKit
import GameplayKit
import SceneKit

class HomeScene: SKScene {
    
    var playBtn: SKSpriteNode! = nil
    var logo: SKSpriteNode! = nil
    var overlayView:SKView! = nil
    var overlayScene:SKScene! = nil
    
    var sceneView:SCNView! = nil
    var scnScene:SCNScene! = nil
    
    var cameraNode:SCNNode! = nil
    var floorNode:SCNNode! = nil
    var sceneFloor:SCNFloor! = nil
    var light:SCNLight! = nil
    
    struct TouchInfo {
        var location:CGPoint
        var time:TimeInterval
    }
    
    var cubeNode:SCNNode! = nil
    var logoNode:SCNNode! = nil
    var history:[TouchInfo]?
    
    var gameViewController : GameViewController!
    
    override func didMove(to view: SKView) {
        
        homeScene = self;
        self.view?.backgroundColor = UIColor.clear
        print("HomeScene - didMove")
        addStructure()
        setupBg()  //  background addition
        addNav() //  2D spritekit elements
        assignTextures() // prepare textures
        animateSceneIn()
        //printFonts()
        
    }
    
    func printFonts() {
        let fontFamilyNames = UIFont.familyNames
        for familyName in fontFamilyNames {
            print("------------------------------")
            print("Font Family Name = [\(familyName)]")
            let names = UIFont.fontNames(forFamilyName: familyName )
            print("Font Names = [\(names)]")
        }
    }
    
    func addNav() {
        playBtn = SKSpriteNode(texture: homePlayBtn)
        let playBtnRatio = (screenSize.width*0.65) / playBtn.size.width
        playBtn.size.width = (screenSize.width*0.65)
        playBtn.size.height = playBtn.size.height * playBtnRatio
        playBtn.name = "playBtn"
        playBtn.position = CGPoint(x:self.frame.midX, y:self.frame.maxY*0.15);
        playBtn.zPosition = 99;
        overlayScene.addChild(playBtn);
    }
    
    func setupBg() {
        let bg = SKSpriteNode(color: UIColor.black, size: CGSize(width: screenW, height: screenH))
        bg.position = CGPoint(x: screenW / 2, y: screenH / 2)
        self.addChild(bg)
    }
    
    func addStructure() {
        sceneView = SCNView(frame: (self.view?.frame)!)
        sceneView.backgroundColor = UIColor.clear
        self.view?.insertSubview(sceneView, at: 0)                  // add sceneView as SubView
        
        scnScene = SCNScene()
        sceneView.scene = scnScene
        
        overlayScene = SKScene(size: (self.view?.bounds.size)!)     // create overlay and add to sceneView
        sceneView.overlaySKScene = overlayScene
        
        sceneView.overlaySKScene!.isUserInteractionEnabled = false;

        addCubeElement()
        addLogo()
    }
    
    func animateSceneIn() {
        
        run(SKAction.sequence([
            SKAction.wait(forDuration: 1),
            SKAction.run() {
                SCNTransaction.begin()
                SCNTransaction.animationDuration = 3.0

                self.light.intensity = 1200
                SCNTransaction.commit()
            },
            SKAction.wait(forDuration: 0.5),
            SKAction.run() {
                SCNTransaction.begin()
                SCNTransaction.animationDuration = 1.0
                self.logoNode.position = homeLogoIn
                SCNTransaction.commit()
            }
            ]), withKey:"transitioning")
    }
    
    
    func removeSceneAnim(){
        // animate cube out
        SCNTransaction.begin()
        SCNTransaction.animationDuration = 1.0
        cameraNode.position = homeCameraOut
        logoNode.position = homeLogoOut
        light.intensity = 0
        SCNTransaction.commit()
        // animate logo out
    }
    
    func assignTextures(){
        mat2.selfIllumination.contents = UIColor.clear
        mat4.selfIllumination.contents = UIColor.clear
        mat8.selfIllumination.contents = UIColor.clear
        mat16.selfIllumination.contents = UIColor.clear
        mat32.selfIllumination.contents = UIColor.clear
        mat64.selfIllumination.contents = UIColor.clear
        mat128.selfIllumination.contents = UIColor.clear
        mat256.selfIllumination.contents = UIColor.clear
        mat512.selfIllumination.contents = UIColor.clear
        mat1024.selfIllumination.contents = UIColor.clear
        mat2048.selfIllumination.contents = UIColor.clear
        mat2.diffuse.contents = text2
        mat4.diffuse.contents = text4
        mat8.diffuse.contents = text8
        mat16.diffuse.contents = text16
        mat32.diffuse.contents = text32
        mat64.diffuse.contents = text64
        mat128.diffuse.contents = text128
        mat256.diffuse.contents = text256
        mat512.diffuse.contents = text512
        mat1024.diffuse.contents = text1024
        mat2048.diffuse.contents = text2048
    }
    
    func addLogo() {
        logoMat.diffuse.contents = UIColor(red:0.40, green:0.74, blue:0.88, alpha:1.0)
        let logoGeometry = SCNBox(width: side/2, height: side/2, length: side/2, chamferRadius: radius/2)  // Cube Anim
        logoNode = SCNNode(geometry: logoGeometry)
        logoNode.name = "logo"
        logoNode.geometry?.materials = [logoMat]
        logoNode.position = homeLogoOut
        logoNode.pivot = SCNMatrix4MakeRotation(0.785398, 0, 1, 0);
        logoNode.scale = SCNVector3Make(1.2, 1.2, 1.2)
        
        
        let twentyText = SCNText(string: "20", extrusionDepth: 5)
        twentyText.font = UIFont(name: "Hangar-Flat", size: 30)
        let twentyTextNode = SCNNode(geometry: twentyText)
        twentyTextNode.scale = SCNVector3Make(0.017, 0.017, 0.017)
        twentyTextNode.position = SCNVector3Make(-0.02, -0.11, 0.31)
        twentyText.flatness = 0.01
        twentyText.chamferRadius = 0.1
        var twminVec = SCNVector3Zero
        var twmaxVec = SCNVector3Zero
        if twentyTextNode.__getBoundingBoxMin(&twminVec, max: &twmaxVec) {
            let distance = SCNVector3(
                x: twmaxVec.x - twminVec.x,
                y: twmaxVec.y - twminVec.y,
                z: twmaxVec.z - twminVec.z)
            twentyTextNode.pivot = SCNMatrix4MakeTranslation(distance.x / 2, distance.y / 2, distance.z / 2)
        }
        twentyText.firstMaterial!.diffuse.contents = UIColor.white
        twentyText.firstMaterial!.specular.contents = UIColor.white
        // -------------------------------------------------------------------------------------------------
        let fortyText = SCNText(string: "48", extrusionDepth: 5)
        fortyText.font = UIFont(name: "Hangar-Flat", size: 30)
        let fortyTextNode = SCNNode(geometry: fortyText)
        fortyTextNode.scale = SCNVector3Make(0.017, 0.017, 0.017)    // Scale it to 20% on all axes
        fortyTextNode.position = SCNVector3Make(0.25, -0.29, 0.2) // Axes: (left/right, low/high, close/far)
        fortyText.flatness = 0.01
        fortyText.chamferRadius = 0.1
        var fortyMinVec = SCNVector3Zero
        var fortyMaxVec = SCNVector3Zero
        if fortyTextNode.__getBoundingBoxMin(&fortyMinVec, max: &fortyMaxVec) {
            let distance = SCNVector3(
                x: fortyMaxVec.x - fortyMinVec.x,
                y: fortyMaxVec.y - fortyMinVec.y,
                z: fortyMaxVec.z - fortyMinVec.z)
            fortyTextNode.pivot = SCNMatrix4MakeTranslation(distance.x / 2, distance.y / 2, distance.z / 2)
        }
        fortyText.firstMaterial!.diffuse.contents = UIColor.white
        fortyText.firstMaterial!.specular.contents = UIColor.white
        fortyTextNode.pivot = SCNMatrix4MakeRotation(-1.5708, 0, 1, 0);
        
        scnScene.rootNode.addChildNode(logoNode)
        logoNode.addChildNode(twentyTextNode)
        logoNode.addChildNode(fortyTextNode)
        
        animateSceneIn() // transition in
    }
    
    
    
    func addCubeElement(){
        let camera = SCNCamera()                        // Camera
        cameraNode = SCNNode()
        cameraNode.camera = camera
        cameraNode.position = homeCameraIn
        
        sceneFloor = SCNFloor()                         // Floor
        floorNode = SCNNode(geometry: sceneFloor)
        floorNode.position = homefloorIn
        sceneFloor.reflectivity = 0.5
        sceneFloor.reflectionResolutionScaleFactor = 0.7
        sceneFloor.reflectionFalloffStart = 2.0
        sceneFloor.reflectionFalloffEnd = 10.0
        
        light = SCNLight()                          // Light
        light.type = SCNLight.LightType.spot
        light.intensity = 0
        light.spotInnerAngle = 50.0
        light.spotOuterAngle = 300.0
        light.castsShadow = true
        let lightNode = SCNNode()
        lightNode.light = light
        lightNode.position = SCNVector3(x: -1.0, y: 2.0, z: 3.5)
        
        let cubeGeometry = SCNBox(width: side, height: side, length: side, chamferRadius: radius)  // Cube Anim
        cubeNode = SCNNode(geometry: cubeGeometry)
        cubeNode.name = "cube"
        cubeNode.physicsBody=SCNPhysicsBody(type: .dynamic, shape: nil)
        cubeNode.physicsBody?.isAffectedByGravity = false
        cubeNode.physicsBody?.mass = 80
        cubeNode.geometry?.materials = [mat1024, mat512, mat8, mat64, mat2048, mat128]
        
        let constraint = SCNLookAtConstraint(target: cubeNode)                  // Constraints
        constraint.isGimbalLockEnabled = true
        cameraNode.constraints = [constraint]
        lightNode.constraints = [constraint]                                                   // Adding Elements
        
        scnScene.rootNode.addChildNode(lightNode)
        scnScene.rootNode.addChildNode(cameraNode)
        scnScene.rootNode.addChildNode(cubeNode)
        scnScene.rootNode.addChildNode(floorNode)
        
        
    }
    
    func animCubeIn(){
        
    }
    
    func animCubeOut(){
        
    }
    
    
    func touchDown(atPoint pos : CGPoint) {
        // detect object at point
        print("touchDown")
        var exit:CGFloat? = nil
        if playBtn.contains(pos) {
            print("playBtn Touched")
            exit = scenes.game
        }
        if exit != nil {
            exitToScene(scene: exit!)
        }
        
    }
    
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
    
    
    
    
    // TOUCHES
    // -----------------------------------------------------------------------------
    func touchMoved(toPoint pos : CGPoint) {print("touchMoved")}
    
    func touchUp(atPoint pos : CGPoint) {print("touchUp")}
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            self.touchDown(atPoint: t.location(in: self))
            history = [TouchInfo(location:t.location(in: self), time:t.timestamp)]
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            self.touchMoved(toPoint: t.location(in: self))
            history?.insert(TouchInfo(location:t.location(in: self), time:t.timestamp),at:0)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            self.touchUp(atPoint: t.location(in: self))
            var vx:CGFloat = 0.0
            var vy:CGFloat = 0.0
            var previousTouchInfo:TouchInfo?
            let maxIterations = 3
            let numElts:Int = min(history!.count, maxIterations)
            let count = CGFloat(numElts-1)
            if count > 1 {
                for index in 1...numElts {
                    let touchInfo = history![index]
                    let location = touchInfo.location
                    if let previousLocation = previousTouchInfo?.location {
                        let dx = location.x - previousLocation.x
                        let dy = location.y - previousLocation.y
                        let dt = CGFloat(touchInfo.time - previousTouchInfo!.time)
                        vx += dx / dt
                        vy += dy / dt
                    }
                    previousTouchInfo = touchInfo
                }
                let velocity = CGVector(dx: vx/count, dy: vy/count)
                let impulseFactor = velocity.dx / 10.0
                cubeNode?.physicsBody?.applyTorque(SCNVector4Make(0, 1, 0, Float(impulseFactor)), asImpulse: true)
                history = nil
            }
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    // -----------------------------------------------------------------------------
    
    
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
