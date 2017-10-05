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
    var scoreboard:Scoreboard! = nil
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
    
    override func didMove(to view: SKView) {
        gameScene = self;
        self.view?.backgroundColor = UIColor.red
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
                self.addScoreboard()
                self.addGestureListeners()
            },
            SKAction.wait(forDuration: 0.2),
            SKAction.run(){
                self.newGame()
            }
            ]), withKey:"transitioning")
    }
    
    func addScoreboard(){
        scoreboard = Scoreboard(name: "scoreboard", position: gameScoreIn, pivot: SCNMatrix4MakeRotation(0.785398, 0, 0, 0), scale: SCNVector3Make(1.0, 1.0, 1.0), score: 0)
        gameSCNScene.rootNode.addChildNode(scoreboard)
        scoreboard.setup()
    }
    
    func addGestureListeners(){
        let swipeUP = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture)) // swipe UP
        swipeUP.direction = UISwipeGestureRecognizerDirection.up
        self.view?.addGestureRecognizer(swipeUP)
        let swipeDOWN = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture)) // swipe DOWN
        swipeDOWN.direction = UISwipeGestureRecognizerDirection.down
        self.view?.addGestureRecognizer(swipeDOWN)
        let swipeLEFT = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture)) // swipe LEFT
        swipeLEFT.direction = UISwipeGestureRecognizerDirection.left
        self.view?.addGestureRecognizer(swipeLEFT)
        let swipeRIGHT = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture)) // swipe RIGHT
        swipeRIGHT.direction = UISwipeGestureRecognizerDirection.right
        self.view?.addGestureRecognizer(swipeRIGHT)
    }
    
    
    func setupBg() {
        let bg = SKSpriteNode(color: UIColor.black, size: CGSize(width: screenW, height: screenH))
        bg.position = CGPoint(x: screenW / 2, y: screenH / 2)
        self.addChild(bg)
    }
    
    func buildGrid(){
        let startY =  -CGFloat((tilePosSize * 2)-tilePosSize/2)
        let startX =  -CGFloat((tilePosSize * 2)-tilePosSize/2)
        logoMat.diffuse.contents = logoBlue
        var lc = 0;
        for y in 0..<gridSize {
            for x in 0..<gridSize {
                lc = lc+1
                let yPos = Float(startY + (tilePosSize * CGFloat(y)) )
                let xPos = Float(startX + (tilePosSize * CGFloat(x)) )
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
        var empty = self.getAvailableSlot() // spawn two random tiles between 2 or 4
        for _ in 0...2 {
            let randomIndex = Int(arc4random_uniform(UInt32(empty.count)))
            let t = empty[randomIndex]
            empty.remove(at: randomIndex)
            t.value = Int( (arc4random_uniform(2)+1)*2 )
        }
    }
    
    func addRandomTile(){
        var empty = self.getAvailableSlot()
        if empty.count == 0 { // something went wrong
        }else{
            if empty.count == 1 {
                if self.evaluateGrid() { self.gameOver() }      // if evaluateGrid returns true - game is over
            }else{
                let index = Int(arc4random_uniform(UInt32(empty.count)))
                let t = empty[index]
                empty.remove(at: index)
                t.value = Int( (arc4random_uniform(2)+1)*2 )
                animateTileIn(tile: t)
            }
        }
        
    }
    
    func addStructure() {
        print("addStructure")
        gameView = SCNView(frame: (self.view?.frame)!)
        gameView.backgroundColor = UIColor.clear
        self.view?.insertSubview(gameView, at: 0)       // add sceneView as SubView
        gameSCNScene = SCNScene()
        gameView.scene = gameSCNScene
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
        let lightNode = SCNNode()
        lightNode.light = light
        lightNode.position = gamelightPosition
        // create lock object
        logoMat.diffuse.contents = logoBlue
        let lockGeometry = SCNBox(width: side/4, height: side/4, length: side/4, chamferRadius: radius/4)  // Cube Anim
        lockNode = SCNNode(geometry: lockGeometry)
        lockNode.name = "logo"
        lockNode.geometry?.materials = [logoMat]
        lockNode.position = SCNVector3(x: 0.0, y: 0.0, z: 0.0)
        lockNode.scale = SCNVector3Make(0.01, 0.01, 0.01)
        let constraint = SCNLookAtConstraint(target: lockNode)                  // Constraints
        constraint.isGimbalLockEnabled = true
        cameraNode.constraints = [constraint]
        lightNode.constraints = [constraint]
        gameSCNScene.rootNode.addChildNode(lockNode)        // Add to scene
        gameSCNScene.rootNode.addChildNode(lightNode)
        gameSCNScene.rootNode.addChildNode(cameraNode)
    }
    
    // Logic helpers
    func getAvailableSlot() -> [Tile] {
        var available : Array = [Tile]()
        for t in tiles { if !t.active { available.append(t) } }
        return available
    }
    
    
    func calculateRowCol(direction:CGFloat){
        switch direction {
        case swipe.right: // reversed
            var row:Array = [Tile]()
            for x in 0..<gridSize {
                row = getColRow(type: "row",id:x )
                for (index, it) in row.reversed().enumerated() {
                    for (ix, next) in row.reversed().enumerated() {
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
                compact(stack: row, rev:true)
            }
            self.addRandomTile()
        case swipe.left:
            var row:Array = [Tile]()
            for x in 0..<gridSize {
                row = getColRow(type: "row",id:x )
                for (index, it) in row.enumerated() {
                    for (ix, next) in row.enumerated() {
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
                compact(stack: row, rev:false)
            }
            self.addRandomTile()
        case swipe.down:
            var col:Array = [Tile]()
            for y in 0..<gridSize {
                col = getColRow(type: "col",id:y )
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
                compact(stack: col, rev:false)
            }
            self.addRandomTile()
        case swipe.up:
            var col:Array = [Tile]()
            for y in 0..<gridSize {
                col = getColRow(type: "col",id:y )
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
                compact(stack: col, rev:true)
            }
            self.addRandomTile()
        default:
            break
        }
    }
    
    func evaluateGrid() -> Bool{
        var ret:Bool = true
        var col:Array = [Tile]()
        for y in 0..<gridSize {
            col = getColRow(type: "col",id:y )
            for (index, it) in col.enumerated() {
                for (ix, next) in col.enumerated() {
                    if ix > index { if next.active && next.value == it.value && it.active{ ret = false } }
                }
            }
        }
        var row:Array = [Tile]()
        for x in 0..<gridSize {
            row = getColRow(type: "row",id:x )
            for (index, it) in row.enumerated() {
                for (ix, next) in row.enumerated() {
                    if ix > index { if next.active && next.value == it.value && it.active{ ret = false } }
                }
            }
        }
        return ret
    }
    
    func compact(stack:Array<Tile>, rev:Bool){
        if rev {
            for (index, item) in stack.reversed().enumerated() {
                var inactive:Array = [Tile]()
                if index>0{
                    if item.active{
                        for n in 0...index{
                            let nx = stack.reversed()[n]
                            if !nx.active { inactive.append(nx) }
                        }
                        let first = inactive.first
                        if (first != nil) {
                            first?.value = item.value
                            item.value = defaultGridValue
                        }
                    }
                }
            }
        }else{
            for (index, item) in stack.enumerated() {
                var inactive:Array = [Tile]()
                if index>0{
                    if item.active{
                        for n in 0...index{
                            let nx = stack[n]
                            if !nx.active { inactive.append(nx) }
                        }
                        let first = inactive.first
                        if (first != nil) {
                            first?.value = item.value
                            item.value = defaultGridValue
                        }
                    }
                }
            }
        }
        for tl in stack { if !tl.active { tl.value = defaultGridValue } }
    }
    
    func getColRow(type:String,id:Int) -> Array<Tile> {
        var ret:Array = [Tile]()
        for i in tiles{ if type == "row" && i.row == id { ret.append(i) }else if type == "col" && i.col == id { ret.append(i) } }
        return ret
    }
    
    func joinTiles(target:Tile, neighbour:Tile){
        target.value = target.value*2
        scoreboard.score = target.value     // send value of join to scoreboard
        neighbour.active = false
        
        
    }
    
    func gameOver(){
        // finalize game
        print("GAME OVER !")
        // store score
        
        // transition to end screen
    }
    
    func getTileFor(row:Int, col:Int)->Tile{
        var ret:Tile! = nil
        for t in tiles{ if t.row == row && t.col == col { ret = t } }
        return ret
    }
    
    
    // Gesture handler
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.right:
                calculateRowCol(direction:swipe.right)
            case UISwipeGestureRecognizerDirection.down:
                calculateRowCol(direction:swipe.down)
            case UISwipeGestureRecognizerDirection.left:
                calculateRowCol(direction:swipe.left)
            case UISwipeGestureRecognizerDirection.up:
                calculateRowCol(direction:swipe.up)
            default:
                break
            }
        }
    }
    
    // Touch handlers
    func touchDown(atPoint pos : CGPoint) {}
    func touchMoved(toPoint pos : CGPoint) {}
    func touchUp(atPoint pos : CGPoint) {}
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) { for t in touches { self.touchDown(atPoint: t.location(in: self)) } }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) { for t in touches { self.touchMoved(toPoint: t.location(in: self)) } }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) { for t in touches { self.touchUp(atPoint: t.location(in: self)) } }
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) { for t in touches { self.touchUp(atPoint: t.location(in: self)) } }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
    // Actions
    // ----------------------------------------------------------------------------------
    func bounce(item:Tile){
        run(SKAction.sequence([
            SKAction.run() {
                SCNTransaction.begin()
                SCNTransaction.animationDuration = 0.05
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
    
    func animateTileIn(tile:Tile){
        let tileInAction = SKAction.run() {
            SCNTransaction.begin()
            SCNTransaction.animationDuration = 0.2
            tile.position.z = 1.7
            SCNTransaction.commit()
        }
        let tileOutAction = SKAction.run() {
            SCNTransaction.begin()
            SCNTransaction.animationDuration = 0.3
            tile.position.z = 1.5
            SCNTransaction.commit()
        }
        tileInAction.timingMode = SKActionTimingMode.easeIn;
        tileOutAction.timingMode = SKActionTimingMode.easeOut;
        run(SKAction.sequence([ tileInAction, tileOutAction ]), withKey:"transitionIn")
    }
    
    
}
