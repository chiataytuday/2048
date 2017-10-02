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
                

                let tile = Tile(geometry: geo, name: tileName, materials: [logoMat], position: tilePos, pivot: SCNMatrix4MakeRotation(0.785398, 0, 0, 0), scale: SCNVector3Make(0.1, 0.1, 0.1), id:lc, row: y, col:x)
                tiles.append(tile)
                gameSCNScene.rootNode.addChildNode(tile)
            }
        }
    
    }
    
    func newGame(){
        // spawn two random tiles between 2 or 4
        var empty = self.getAvailableSlot()
        for _ in 0...8 {
            let randomIndex = Int(arc4random_uniform(UInt32(empty.count)))
            let t = empty[randomIndex]
            empty.remove(at: randomIndex)
            t.value = Int( (arc4random_uniform(2)+1)*2 )
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
    
    func calculateRow(direction:CGFloat){
        switch direction {
        case swipe.right:
            print("calculate row from right")
        case swipe.left:
            print("calculate row from left")
            for i in tiles {
                print("name : ",i.id,"  Row: ",i.row,"  Col: ",i.col, " Active: ",i.active)
                
                if i.active {
                    if i.col < 3 {
                        let neighbour = self.getTileFor(row:i.row, col:i.col+1)
                        if neighbour.active && neighbour.value == i.value {

                            joinTiles(target: i, neighbour: neighbour)
                        }
                    }
                }
            }
            
        case swipe.down:
            print("calculate row from top")
            for y in 0..<gridSize {
                let col = getColRow(type: "col",id:y )
                for (index, it) in col.enumerated() {
                    for (ix, next) in col.enumerated() {
                        if ix > index {
                            if next.active && next.value == it.value && it.active{
                                joinTiles(target: it, neighbour: next) // found  item --> BREAK
                                break;
                            }else if next.active && next.value != it.value && it.active {
                                break;
                            }
                        }
                    }
                }
            }
            
        case swipe.up:
            print("calculate row from bottom")
            for y in 0..<gridSize {
                let col = getColRow(type: "col",id:y )
                for (index, it) in col.reversed().enumerated() {                    // calculate a column
                    for (ix, next) in col.reversed().enumerated() {
                        if ix > index {
                            if next.active && next.value == it.value && it.active{
                                joinTiles(target: it, neighbour: next) // found  item --> BREAK
                                break;
                            }else if next.active && next.value != it.value && it.active {
                                break;
                            }
                        }
                    }
                }
            }
            
        default:
            break
        }
    }
    
    func getColRow(type:String,id:Int) -> Array<Tile> {
        var ret:Array = [Tile]()
        for i in tiles{
            if type == "row" && i.row == id {
                ret.append(i)
            }else if type == "col" && i.col == id {
                ret.append(i)
            }
        }
        return ret
    }
    
    func joinTiles(target:Tile, neighbour:Tile){
        target.value = target.value*2
        neighbour.active = false
    }
    
    
    func getTileFor(row:Int, col:Int)->Tile{
        var ret:Tile! = nil
        for t in tiles{
            if t.row == row && t.col == col {
                ret = t
            }
        }
        return ret
    }
    
    
    // Gesture handler
    func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.right:
                calculateRow(direction:swipe.right)
            case UISwipeGestureRecognizerDirection.down:
                calculateRow(direction:swipe.down)
            case UISwipeGestureRecognizerDirection.left:
                calculateRow(direction:swipe.left)
            case UISwipeGestureRecognizerDirection.up:
                calculateRow(direction:swipe.up)
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
