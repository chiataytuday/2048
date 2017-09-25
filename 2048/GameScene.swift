//
//  GameScene.swift
//  2048
//
//  Created by per thoresson on 9/1/17.
//  Copyright © 2017 per thoresson. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var gameView:SCNView! = nil
    var gameSCNScene:SCNScene! = nil
    // Camera and Light
    var cameraNode:SCNNode! = nil
    var light:SCNLight! = nil
    
    // Config params
    let gridSize = 4
    let tileSize = 20
    
    
    let gameBoard:Array = [
        [],
        [],
        [],
        []]
    
    let logo:SKSpriteNode! = nil
    
    override func didMove(to view: SKView) {
        
        gameScene = self;
        self.view?.backgroundColor = UIColor.red
        print("didMove - GameScene")
        
        runSetup()
        
    }
    
    func runSetup(){
        run(SKAction.sequence([
            SKAction.run() {
                self.setupBg()
                self.addStructure()
            },
            SKAction.wait(forDuration: 0.2),
            SKAction.run() {
                self.buildGrid()
            }
            ]), withKey:"transitioning")
    }
    
    
    func setupBg() {
        let bg = SKSpriteNode(color: UIColor.white, size: CGSize(width: screenW, height: screenH))
        bg.position = CGPoint(x: screenW / 2, y: screenH / 2)
        self.addChild(bg)
    }
    
    func buildGrid(){
        for x in 0..<gridSize {
            for y in 0..<gridSize {
                
            }
        }
        
        
        
//        for y in 0..gridSize
//        {
//            for x in 0..gridSize
//            {
//                print(board[x % numRows + y * numCols])
//            }
//        }
    }
    
    func newGame(){
        // spawn two random tiles between 2 or 4
    }
    
    func addStructure() {
        gameView = SCNView(frame: (self.view?.frame)!)
        gameView.backgroundColor = UIColor.clear
        self.view?.insertSubview(gameView, at: 0)                  // add sceneView as SubView
        
        gameSCNScene = SCNScene()
        gameView.scene = gameSCNScene
        
        // add camera
        let camera = SCNCamera()                        // Camera
        cameraNode = SCNNode()
        cameraNode.camera = camera
        cameraNode.position = gameCameraIn
        
        // add Light
        light = SCNLight()                          // Light
        light.type = SCNLight.LightType.spot
        light.intensity = 0
        light.spotInnerAngle = 50.0
        light.spotOuterAngle = 300.0
        light.castsShadow = true
        let lightNode = SCNNode()
        lightNode.light = light
        lightNode.position = gamelightPosition
        
        gameSCNScene.rootNode.addChildNode(lightNode)
        gameSCNScene.rootNode.addChildNode(cameraNode)
    }
    
    func createTextures(){
        // assign texture materials
    }
    
    func setTextureForId(item:CGFloat){
        
    }
    
    func evaluateGrid(direction:CGFloat){

    }
    
    
    func touchDown(atPoint pos : CGPoint) {

    }
    
    func touchMoved(toPoint pos : CGPoint) {

    }
    
    func touchUp(atPoint pos : CGPoint) {

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {


        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
