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
    
    let sceneView:SCNView! = nil
    
    
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
        setupBg()
        
    }
    
    func setupBg() {
        let bg = SKSpriteNode(color: UIColor.white, size: CGSize(width: screenW, height: screenH))
        bg.position = CGPoint(x: screenW / 2, y: screenH / 2)
        self.addChild(bg)
    }
    
    func newGame(){
        // spawn two random tiles between 2 or 4
    }
    
    func addStructure() {
        sceneView = SCNView(frame: (self.view?.frame)!)
        sceneView.backgroundColor = UIColor.clear
        self.view?.insertSubview(sceneView, at: 0)                  // add sceneView as SubView
        
        scnScene = SCNScene()
        sceneView.scene = scnScene
        
        //        overlayScene = SKScene(size: (self.view?.bounds.size)!)     // create overlay and add to sceneView
        //        sceneView.overlaySKScene = overlayScene
        //        sceneView.overlaySKScene!.isUserInteractionEnabled = false;
        
        addCubeElement()
        addLogo()
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
