//
//  HighscoreScene.swift
//  2048
//
//  Created by per thoresson on 9/4/17.
//  Copyright © 2017 per thoresson. All rights reserved.
//


import SpriteKit
import GameplayKit

class HighscoreScene: SKScene {
    
    var gameViewController : GameViewController!
    
    override func didMove(to view: SKView) {
        
        highscoreScene = self;
        self.view?.backgroundColor = UIColor.clear
        print("InfoScene - didMove")
        setupBg()                           //  background addition
        assignTextures()                    // prepare textures
        addStructure()                      // Add prerequisites
        addNavigation()
        animateIn()
    }
    
    func setupBg(){
        
    }
    
    func assignTextures(){
        
    }
    
    func addStructure(){
        
    }
    
    func addNavigation(){
        
    }
    
    func animateIn(){
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
