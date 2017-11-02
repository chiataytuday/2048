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
import GoogleMobileAds

class GameScene: SKScene {
    
    var bannerView: GADBannerView!
    var bannerDisplayed:Bool = false
    
    var scoreboard:Scoreboard! = nil
    var scoreManager:GameScoreManager! = nil
    var gameoverPanel:GameoverPanel! = nil
    var gameView:SCNView! = nil
    var gameSCNScene:SCNScene! = nil
    var swipeActive:Bool = true
    // Camera and Light
    var cameraNode:SCNNode! = nil
    var light:SCNLight! = nil
    var lightNode:SCNNode! = nil
    var lockNode:SCNNode! = nil
    // Config params
    let gridSize = 4
    let tileSize:CGFloat = 20
    let tilePosSize:CGFloat = 0.2
    var tiles:Array = [Tile]()
    
    // ViewController reference
    var gameViewController : GameViewController!
    
    override func didMove(to view: SKView) {
        gameScene = self;
//        self.view?.backgroundColor = UIColor.red
        scoreManager = GameScoreManager.sharedInstance
        runSetup()
    }
    
    //  Start sequence
    // ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
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
                self.addEndScore()
                self.addGestureListeners()
            },
            SKAction.wait(forDuration: 0.2),
            SKAction.run(){
                self.newGame()
            }
            ]), withKey:"transitioning")
    }
    // ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
    
    
    
    
    // Build the environment for the scene
    // ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
    func addScoreboard(){
        scoreboard = Scoreboard(name: "scoreboard", position: gameScoreIn, pivot: SCNMatrix4MakeRotation(0.785398, 0, 0, 0), scale: SCNVector3Make(1.0, 1.0, 1.0), score: 0)
        gameSCNScene.rootNode.addChildNode(scoreboard)
        scoreboard.setup()
    }
    
    func addEndScore(){
        gameoverPanel = GameoverPanel(name: "endPanel", position: gameEndIn, pivot: SCNMatrix4MakeRotation(0.785398, 0, 0, 0), scale: SCNVector3Make(1.0, 1.0, 1.0))
        gameSCNScene.rootNode.addChildNode(gameoverPanel)
        gameoverPanel.setup()
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
        gameSCNScene.rootNode.addChildNode(lockNode)        // Add to scene
        gameSCNScene.rootNode.addChildNode(lightNode)
        gameSCNScene.rootNode.addChildNode(cameraNode)
    }
    
    func addEndPanel(){
        
    }
    
    // ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
    // ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
    
    
    
    // Game Actions
    // ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
    func newGame(){
        var empty = self.getAvailableSlot() // spawn two random tiles between 2 or 4
        for _ in 0...1 {
            let randomIndex = Int(arc4random_uniform(UInt32(empty.count)))
            let t = empty[randomIndex]
            empty.remove(at: randomIndex)
            t.value = Int( (arc4random_uniform(2)+1)*2 )
        }
    }
    
    func resetGame(){
        // clear the decks
    }
    
    func returnToHome(){
        
    }
    
    
    // Logic helpers
    // ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
    // ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
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
                if index < Int(col.count-1) {
                    let next = col[Int(index+1)]
                    if it.active && it.value == next.value && next.active{ ret = false }
                }
            }
        }
        var row:Array = [Tile]()
        for x in 0..<gridSize {
            row = getColRow(type: "row",id:x )
            for (index, itx) in row.enumerated() {
                if index < Int(row.count-1) {
                    let nextx = row[Int(index+1)]
                    if itx.active && itx.value == nextx.value && nextx.active{ ret = false }
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
    
    func addRandomTile(){
        var empty = self.getAvailableSlot()
        if empty.count == 0 { /* something went wrong */ }else{
            let index = Int(arc4random_uniform(UInt32(empty.count)))
            let t = empty[index]
            empty.remove(at: index)
            t.value = Int( (arc4random_uniform(2)+1)*2 )
            animateTileIn(tile: t)
            if empty.count == 0 {
                print("no spots left ----->>>>>>> Any options? : ", self.evaluateGrid() )
                if self.evaluateGrid() { self.gameOver() }      // if evaluateGrid returns true - game is over
            }else{ /* nothing - move on */ }
        }
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
    
    func getTileFor(row:Int, col:Int)->Tile{
        var ret:Tile! = nil
        for t in tiles{ if t.row == row && t.col == col { ret = t } }
        return ret
    }
    // ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
    // ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
    
    
    
    
    
    // Highscore section
    // ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
    // ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
    func gameOver(){
        // finalize game
        print("GAME OVER !")
        // store score
        scoreManager.saveScore(score: self.scoreboard.score)
        gameoverPanel.setScore(val:self.scoreboard.score)
        // transition to end screen
        moveToScore()
    }
    
    func moveToScore(){
        // disable swip actions
        self.swipeActive = false
        // possibly reset game
        resetGame()
        // move to score panel
        toScore()
    }
    
    func toScore(){
        self.createBanner()
        run(SKAction.sequence([
            SKAction.run() {
                SCNTransaction.begin()
                SCNTransaction.animationDuration = 1.0
                self.cameraNode.position = gameCameraScore
                self.lightNode.position = gamelightScorePosition
                SCNTransaction.commit()
            }
            ]), withKey:"transitioning")
    }
    
    func toGame(){
        self.removeBanner()
        run(SKAction.sequence([
            SKAction.run() {
                SCNTransaction.begin()
                SCNTransaction.animationDuration = 1.0
                self.cameraNode.position = gameCameraIn
                self.lightNode.position = gamelightPosition
                SCNTransaction.commit()
                self.swipeActive = true
            }
            ]), withKey:"transitioning")
    }
    
    func createBanner(){
        // create Ad Panel - Admob
        // Ad ID - ca-app-pub-1672643432387969/6981900150
        // Ad Name - Scoreboard AD
        bannerView = GADBannerView(adSize: kGADAdSizeSmartBannerPortrait) // kGADAdSizeBanner
        self.addBannerViewToView()
    }
    
    func addBannerViewToView() {
        self.view?.addSubview(bannerView)
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        // load banner
        bannerView.rootViewController = self.gameViewController
        bannerView.adUnitID = "ca-app-pub-1672643432387969/6981900150"
        // add constraints
        self.view?.addConstraint(NSLayoutConstraint(item: bannerView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0))
        self.view?.addConstraint(NSLayoutConstraint(item: bannerView, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0))
        // Request banner
        let request = GADRequest()
        request.testDevices = [ kGADSimulatorID, "4BC139DD-B4B1-41C0-A7F5-49C4A8531181" ] // iPhone 7 Plus (10.3.1)
        bannerView.load(request)
    }
    
    
    func removeBanner(){
        // get subview of banner and remove
        if bannerView != nil {
            bannerView.removeFromSuperview()
        }
    }
    
    // ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
    // ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
    
    
    
    
    // Gesture handler
    // ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.right:
                if swipeActive { calculateRowCol(direction:swipe.right) }
//                moveToScore()
            case UISwipeGestureRecognizerDirection.down:
                if swipeActive { calculateRowCol(direction:swipe.down) }
            case UISwipeGestureRecognizerDirection.left:
                if swipeActive { calculateRowCol(direction:swipe.left) }
            case UISwipeGestureRecognizerDirection.up:
                if swipeActive { calculateRowCol(direction:swipe.up) }
            default:
                break
            }
        }
    }
    
    // Touch handlers
    func touchDown(atPoint pos : CGPoint) {}
    func touchMoved(toPoint pos : CGPoint) {}
    func touchUp(atPoint pos : CGPoint) {}
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }

        let touch = touches.first
        if let touchPoint = touch?.location(in: self.gameView),
            let hitTestResult = self.gameView.hitTest(touchPoint, options: nil).first {
            let hitNode = hitTestResult.node
            print("Name : ",hitNode.name as Any)
            var exit:CGFloat? = nil
            if hitNode.name == "play" { exit = scenes.game }
            if hitNode.name == "info" { exit = scenes.info }
            if hitNode.name == "score" { exit = scenes.score }
            if hitNode.name == "settings" { exit = scenes.settings }
            if exit != nil {
                exitToScene(scene: exit!)
            }
        }
    }
    
    
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) { for t in touches { self.touchMoved(toPoint: t.location(in: self)) } }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) { for t in touches { self.touchUp(atPoint: t.location(in: self)) } }
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) { for t in touches { self.touchUp(atPoint: t.location(in: self)) } }
    // ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
    // ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
    
    
    
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
        cameraNode.position = homeCameraOut
        light.intensity = 0
        SCNTransaction.commit()
        // animate logo out
    }
    
    
    // Animation Actions
    // ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
    // ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
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
    // ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
    // ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
    
}
