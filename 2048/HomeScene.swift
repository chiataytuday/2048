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
    
    struct TouchInfo {
        var location:CGPoint
        var time:TimeInterval
    }
    
    var cubeNode:SCNNode! = nil
    var history:[TouchInfo]?
    
    override func didMove(to view: SKView) {
        
        homeScene = self;
        self.view?.backgroundColor = UIColor.clear
        
        addScenes()
        setupBg()
        addLogo()
        addNav()
        
    }

    
    func addLogo(){
        logo = SKSpriteNode(texture: GameLogo)
        let logoRatio = (screenSize.width*0.55) / logo.size.width
        logo.size.width = (screenSize.width*0.55)
        logo.size.height = logo.size.height * logoRatio
        logo.name = "logo"
        logo.position = CGPoint(x:self.frame.midX, y:self.frame.maxY*0.83);
        logo.zPosition = 30;
        overlayScene.addChild(logo);
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
    
    func addScenes() {
        sceneView = SCNView(frame: (self.view?.frame)!)
        sceneView.backgroundColor = UIColor.clear
        
        self.view?.insertSubview(sceneView, at: 0)
        
        scnScene = SCNScene()
        sceneView.scene = scnScene
        
        overlayScene = SKScene(size: (self.view?.bounds.size)!)
        
        sceneView.overlaySKScene = overlayScene
        
        sceneView.overlaySKScene!.isUserInteractionEnabled = false;
        
        addCubeAnim()
    }
    
    func addCubeAnim(){
        
        let camera = SCNCamera()
        let cameraNode = SCNNode()
        cameraNode.camera = camera
        cameraNode.position = homeCamera
        
        
        let sceneFloor = SCNFloor()
        let myFloorNode = SCNNode(geometry: sceneFloor)
        myFloorNode.position = SCNVector3(x: 0, y: -0.5, z: 0)

        sceneFloor.reflectivity = 0.5
        sceneFloor.reflectionResolutionScaleFactor = 0.7
        sceneFloor.reflectionFalloffStart = 2.0
        sceneFloor.reflectionFalloffEnd = 10.0
        
        
        let light = SCNLight()
        light.type = SCNLight.LightType.spot
        light.spotInnerAngle = 50.0
        light.spotOuterAngle = 300.0
        light.castsShadow = true
//        light.attenuationStartDistance = 1.0
//        light.attenuationEndDistance = 30.0
//        light.attenuationFalloffExponent = 1.5
        let lightNode = SCNNode()
        lightNode.light = light
        lightNode.position = SCNVector3(x: -1.0, y: 2.0, z: 3.5)
        
        let cubeGeometry = SCNBox(width: side, height: side, length: side, chamferRadius: radius)
        cubeNode = SCNNode(geometry: cubeGeometry)
        cubeNode.name = "cube"
        
        cubeNode.physicsBody=SCNPhysicsBody(type: .dynamic, shape: nil)
        cubeNode.physicsBody?.isAffectedByGravity = false
        cubeNode.physicsBody?.mass = 80
        
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
        
//        mat2.reflective.contents = UIColor.white
//        mat4.reflective.contents = UIColor.white
//        mat8.reflective.contents = UIColor.white
//        mat16.reflective.contents = UIColor.white
//        mat32.reflective.contents = UIColor.white
//        mat64.reflective.contents = UIColor.white
//        mat128.reflective.contents = UIColor.white
//        mat256.reflective.contents = UIColor.white
//        mat512.reflective.contents = UIColor.white
//        mat1024.reflective.contents = UIColor.white
//        mat2048.reflective.contents = UIColor.white
//        
//
//        mat4.selfIllumination.contents = UIColor.clear
//        mat512.selfIllumination.contents = UIColor.clear
//        mat16.selfIllumination.contents = UIColor.clear
//        mat64.selfIllumination.contents = UIColor.clear
//        mat2048.selfIllumination.contents = UIColor.clear
//        mat128.selfIllumination.contents = UIColor.clear
//        
        
//        mat64.locksAmbientWithDiffuse = true
//        mat2048.locksAmbientWithDiffuse = true
//        mat128.locksAmbientWithDiffuse = true
        
//        metalMapTexture
        
        cubeNode.geometry?.materials = [mat1024, mat512, mat8, mat64, mat2048, mat128]
        
        let constraint = SCNLookAtConstraint(target: cubeNode)
        constraint.isGimbalLockEnabled = true
        cameraNode.constraints = [constraint]
        lightNode.constraints = [constraint]
        
        scnScene.rootNode.addChildNode(lightNode)
        scnScene.rootNode.addChildNode(cameraNode)
        scnScene.rootNode.addChildNode(cubeNode)
        scnScene.rootNode.addChildNode(myFloorNode)
        
    }
    
    func touchDown(atPoint pos : CGPoint) {
        // detect object at point
        print("touchDown")
        
        if playBtn.contains(pos) {
            print("playBtn Touched")
        }
        
    }
    
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
    
    func moveToScene(to:String){
        
        let transition = SKTransition.reveal(with: .down, duration: 1.0)
        
        let nextScene = GameScene(size: scene!.size)
        nextScene.scaleMode = .aspectFill
        
        scene?.view?.presentScene(nextScene, transition: transition)
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
