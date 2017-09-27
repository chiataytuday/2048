//
//  GameScene.swift
//  2048
//
//  Created by per thoresson on 9/1/17.
//  Copyright © 2017 per thoresson. All rights reserved.
//

import SpriteKit
import GameplayKit
import SceneKit

class GameScene: SKScene {
    
    var gameView:SCNView! = nil
    var gameSCNScene:SCNScene! = nil
    // Camera and Light
    var cameraNode:SCNNode! = nil
    var light:SCNLight! = nil
    var lockNode:SCNNode! = nil
    
    // Config params
    let gridSize = 4
    let tileSize:CGFloat = 20
    let tilePosSize:CGFloat = 0.2
    
    var tiles:Array = [Tile]()
    
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
                self.addGestureListeners()
            },
            SKAction.wait(forDuration: 0.2),
            SKAction.run(){
                self.newGame()
            }
            ]), withKey:"transitioning")
    }
    
    func addGestureListeners(){
        let swipeUP = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeUP.direction = UISwipeGestureRecognizerDirection.up
        self.view?.addGestureRecognizer(swipeUP)
        
        let swipeDOWN = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeDOWN.direction = UISwipeGestureRecognizerDirection.down
        self.view?.addGestureRecognizer(swipeDOWN)
        
        let swipeLEFT = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeLEFT.direction = UISwipeGestureRecognizerDirection.left
        self.view?.addGestureRecognizer(swipeLEFT)
        
        let swipeRIGHT = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeRIGHT.direction = UISwipeGestureRecognizerDirection.right
        self.view?.addGestureRecognizer(swipeRIGHT)
    }
    
    
    func setupBg() {
        print("setupBg")
        let bg = SKSpriteNode(color: UIColor.black, size: CGSize(width: screenW, height: screenH))
        bg.position = CGPoint(x: screenW / 2, y: screenH / 2)
        self.addChild(bg)
    }
    
    func buildGrid(){
        print("buildGrid")
        let startY =  -CGFloat((tilePosSize * 2)-tilePosSize/2)
        let startX =  -CGFloat((tilePosSize * 2)-tilePosSize/2)
        logoMat.diffuse.contents = logoBlue
        var lc = 0;
        for y in 0..<gridSize {
            for x in 0..<gridSize {
                lc = lc+1
                let yPos = Float(startY + (tilePosSize * CGFloat(y)) )
                let xPos = Float(startX + (tilePosSize * CGFloat(x)) )
                print("x : ",x," - ",xPos," - y : ",yPos)
                
                let geo = SCNBox(width: side/1.2, height: side/1.2, length: side/1.2, chamferRadius: radius/2)
                let tilePos = SCNVector3(x: xPos, y: yPos, z: 1.5 )
                let tileName:String = String("t"+String(y)+String(x))
                

                let tile = Tile(geometry: geo, name: tileName, materials: [logoMat], position: tilePos, pivot: SCNMatrix4MakeRotation(0.785398, 0, 0, 0), scale: SCNVector3Make(0.1, 0.1, 0.1), id:lc)
                tiles.append(tile)
                gameSCNScene.rootNode.addChildNode(tile)
            }
        }
    
    }
    
    func newGame(){
        // spawn two random tiles between 2 or 4
        var empty = self.getAvailableSlot()
        for i in 0...1 {
            print("i : ",i," --> ",CGFloat( arc4random_uniform(2) ))
            let randomIndex = Int(arc4random_uniform(UInt32(empty.count)))
            let t = empty[randomIndex]
            empty.remove(at: randomIndex)
            t.setMaterialForValue(value : CGFloat( Int(arc4random_uniform(2)) ))
            t.show()
        }
        
    }
    
    
    
    func addStructure() {
        print("addStructure")
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
        light.type = SCNLight.LightType.omni
        light.intensity = 1000
        light.spotInnerAngle = 50.0
        light.spotOuterAngle = 300.0
        light.castsShadow = true
        let lightNode = SCNNode()
        lightNode.light = light
        lightNode.position = gamelightPosition
        
        // create lock object
        logoMat.diffuse.contents = logoBlue
        let logoGeometry = SCNBox(width: side/4, height: side/4, length: side/4, chamferRadius: radius/4)  // Cube Anim
        lockNode = SCNNode(geometry: logoGeometry)
        lockNode.name = "logo"
        lockNode.geometry?.materials = [logoMat]
        lockNode.position = SCNVector3(x: 0.0, y: 0.0, z: 0.0)
        lockNode.scale = SCNVector3Make(0.01, 0.01, 0.01)
        
        let constraint = SCNLookAtConstraint(target: lockNode)                  // Constraints
        constraint.isGimbalLockEnabled = true
        cameraNode.constraints = [constraint]
        lightNode.constraints = [constraint]
        
        gameSCNScene.rootNode.addChildNode(lockNode)
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
    
    func testTileMaterials(){
        for itm in tiles {
            print("item :: ",itm)
            itm.setMaterialForValue(value: material.m1024)
        }
    }
    
    // Logic helpers
    func getAvailableSlot() -> [Tile] {
        var available : Array = [Tile]()
        for t in tiles {
            if !t.active {
                available.append(t)
            }
        }
        return available
    }
    
    
    
    // Gesture handler
    func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.right:
                print("Swiped right")
                self.bounce(item:tiles[0])
            case UISwipeGestureRecognizerDirection.down:
                print("Swiped down")
            case UISwipeGestureRecognizerDirection.left:
                print("Swiped left")
            case UISwipeGestureRecognizerDirection.up:
                print("Swiped up")
            default:
                break
            }
        }
    }
    
    
    
    
    // Touch handlers
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
    
    // Actions
    // ----------------------------------------------------------------------------------
    func bounce(item:Tile){
        run(SKAction.sequence([
            SKAction.run() {
                SCNTransaction.begin()
                SCNTransaction.animationDuration = 0.1
                item.scale = SCNVector3Make(0.12, 0.12, 0.12)
                SCNTransaction.commit()
            },
            SKAction.run() {
                SCNTransaction.begin()
                SCNTransaction.animationDuration = 0.1
                item.scale = SCNVector3Make(0.1, 0.1, 0.1)
                SCNTransaction.commit()
            }
            ]), withKey:"bouncing")
    }
    
}
