//
//  SettingsScene.swift
//  2048
//
//  Created by per thoresson on 9/4/17.
//  Copyright © 2017 per thoresson. All rights reserved.
//


import SpriteKit
import GameplayKit

class SettingsScene: SKScene {
    
    var gameViewController : GameViewController!
    
    override func didMove(to view: SKView) {
        
        settingsScene = self;
        
    }
    
    

    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}

