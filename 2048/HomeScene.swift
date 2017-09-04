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
    
    struct TouchInfo {
        var location:CGPoint
        var time:TimeInterval
    }
    
    var cubeNode:SCNNode! = nil
    var history:[TouchInfo]?
    
    override func didMove(to view: SKView) {
        
        homeScene = self;
        addNav()
        setupBg()
        addSceneView()
    }
    
    func addNav() {
        playBtn = SKSpriteNode(texture: homePlayBtn)
        let playBtnRatio = (screenSize.width*0.55) / playBtn.size.width
        playBtn.size.width = (screenSize.width*0.55)
        playBtn.size.height = playBtn.size.height * playBtnRatio
        playBtn.name = "playBtn"
        playBtn.position = CGPoint(x:self.frame.midX, y:self.frame.midY*0.1);
//        playBtn.zPosition = layers.navigation;
        self.addChild(playBtn);
    }
    
    func setupBg() {
        let bg = SKSpriteNode(color: UIColor.white, size: CGSize(width: screenW, height: screenH))
        bg.position = CGPoint(x: screenW / 2, y: screenH / 2)
        self.addChild(bg)
    }
    
    func addSceneView() {
        let sceneView = SCNView(frame: (homeScene.view?.frame)!)
        sceneView.backgroundColor = UIColor.clear
        self.view?.addSubview(sceneView)
        
        let scene = SCNScene()
        sceneView.scene = scene
        
        let camera = SCNCamera()
        let cameraNode = SCNNode()
        cameraNode.camera = camera
        cameraNode.position = homeCamera
        
        let light = SCNLight()
        light.type = SCNLight.LightType.omni
        let lightNode = SCNNode()
        lightNode.light = light
        lightNode.position = SCNVector3(x: 1.5, y: 1.5, z: 1.5)
        
        let cubeGeometry = SCNBox(width: side, height: side, length: side, chamferRadius: radius)
        cubeNode = SCNNode(geometry: cubeGeometry)
        cubeNode.name = "cube"
        
        cubeNode.physicsBody=SCNPhysicsBody(type: .dynamic, shape: nil)
        cubeNode.physicsBody?.isAffectedByGravity = false
        cubeNode.physicsBody?.mass = 200
        
        cubeNode.geometry?.materials = [mat4, mat512, mat16, mat64, mat2048, mat128]
        
        scene.rootNode.addChildNode(lightNode)
        scene.rootNode.addChildNode(cameraNode)
        scene.rootNode.addChildNode(cubeNode)
        
    }
    
    func touchDown(atPoint pos : CGPoint) {
        print("touchDown", pos.x," <> ",pos.y)
    }
    
    func touchMoved(toPoint pos : CGPoint) {
//        print("touchMoved", pos.x," <> ",pos.y)
        
    }
    
    func touchUp(atPoint pos : CGPoint) {
        
    }
    
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
            // Adjust this value as needed
            let maxIterations = 3
            let numElts:Int = min(history!.count, maxIterations)
            // Loop over touch history
            let count = CGFloat(numElts-1)
            if count > 1 {
                for index in 1...numElts {
                    let touchInfo = history![index]
                    let location = touchInfo.location
                    if let previousLocation = previousTouchInfo?.location {
                        // Step 1
                        let dx = location.x - previousLocation.x
                        let dy = location.y - previousLocation.y
                        // Step 2
                        let dt = CGFloat(touchInfo.time - previousTouchInfo!.time)
                        // Step 3
                        vx += dx / dt
                        vy += dy / dt
                    }
                    previousTouchInfo = touchInfo
                }
                
                // Step 4
                print("count: ",count)
                let velocity = CGVector(dx: vx/count, dy: vy/count)
                let impulseFactor = velocity.dx / 10.0
                print("impulseFactor : ",impulseFactor)
                cubeNode?.physicsBody?.applyTorque(SCNVector4Make(0, 1, 0, Float(impulseFactor)), asImpulse: true)
                // Step 5
                history = nil
            }
            
        
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
