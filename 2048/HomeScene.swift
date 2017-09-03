//
//  HomeScene.swift
//  2048
//
//  Created by per thoresson on 9/1/17.
//  Copyright © 2017 per thoresson. All rights reserved.
//

import SpriteKit
import GameplayKit

class HomeScene: SKScene {
    
    var playBtn: SKSpriteNode! = nil
    
    override func didMove(to view: SKView) {
        
        homeScene = self;
        addNav()
    }
    
    func addNav() {
        playBtn = SKSpriteNode(texture: homePlayBtn)
        let playBtnRatio = (screenSize.width*0.55) / playBtn.size.width
        playBtn.size.width = (screenSize.width*0.55)
        playBtn.size.height = playBtn.size.height * playBtnRatio
        playBtn.name = "playBtn"
        playBtn.position = CGPoint(x:self.frame.midX, y:self.frame.midY);
        playBtn.zPosition = layers.navigation;
        self.addChild(playBtn);
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
