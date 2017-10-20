//
//  GameoverPanel.swift
//  2048
//
//  Created by per thoresson on 10/18/17.
//  Copyright © 2017 per thoresson. All rights reserved.
//

import Foundation
import SceneKit
import SpriteKit
import GameplayKit

class GameoverPanel : SCNNode {

    var backPanel:SCNNode! = nil            // Primitive panel
    
    var gameoverHeaderNode:SCNNode! = nil   // Title text
    var gameoverHeaderTxt:SCNText! = nil
    
    var scoreNode:SCNNode! = nil            // Current gamescore text
    var scoreTxt:SCNText! = nil
    
    var replayNode:SCNNode! = nil           // Replay Button
    var replayTxt:SCNText! = nil
    
    var highscoreNode:SCNNode! = nil        // Highscore Button
    var highscoreTxt:SCNText! = nil
    
    var homeNode:SCNNode! = nil             // Home Button
    var homeTxt:SCNText! = nil
    
    required init(coder: NSCoder) {
        fatalError("NSCoding not supported")
    }
    
    init(name:String,position:SCNVector3, pivot:SCNMatrix4, scale:SCNVector3){
        print("Scoreboard Init")
        scoreBgMat.diffuse.contents = UIColor.clear
        super.init()
        self.geometry = SCNBox(width: scoreBoardWidth, height: scoreBoardHeight, length: scoreBoardDepth, chamferRadius: scoreBoardRadius)
        self.name = name
        self.geometry?.materials = [scoreBgMat]
        self.position = position
        self.pivot = pivot
        self.scale = scale
    }
    
    func setup(){
        endpanelBgMat.diffuse.contents = col2048
        let panelGeometry = SCNBox(width: panelWidth, height: panelHeight, length: panelDepth, chamferRadius: panelRadius)  // Cube Anim
        backPanel = SCNNode(geometry: panelGeometry)
        backPanel.name = "endpanel"
        backPanel.geometry?.materials = [endpanelBgMat]
        backPanel.position = SCNVector3(x: 0, y: 0, z: 0)
        backPanel.pivot = SCNMatrix4MakeRotation(0.785398, 0, 0, 0);
        backPanel.scale = SCNVector3Make(2.5, 2.5, 2.5)
        
        // Add gameover text
        gameoverHeaderTxt = SCNText(string: "GAME OVER", extrusionDepth: 8)
        gameoverHeaderTxt.font = UIFont(name: "Hangar-Flat", size: 20)
        gameoverHeaderNode = SCNNode(geometry: gameoverHeaderTxt)
        gameoverHeaderNode.name = "bestscore"
        gameoverHeaderNode.scale = SCNVector3Make(0.03, 0.03, 0.03)
        gameoverHeaderNode.position = SCNVector3Make(0.0, 1.45, 0.45)
        gameoverHeaderTxt.flatness = 0.1
        gameoverHeaderTxt.chamferRadius = 0.1
        var bestMinVec = SCNVector3Zero
        var bestMaxVec = SCNVector3Zero
        if gameoverHeaderNode.__getBoundingBoxMin(&bestMinVec, max: &bestMaxVec) {
            let distance = SCNVector3(
                x: bestMaxVec.x - bestMinVec.x,
                y: bestMaxVec.y - bestMinVec.y,
                z: bestMaxVec.z - bestMinVec.z)
            gameoverHeaderNode.pivot = SCNMatrix4MakeTranslation(distance.x / 2, distance.y / 3, distance.z / 2)
        }
        gameoverHeaderTxt.firstMaterial!.diffuse.contents = UIColor.white
        gameoverHeaderTxt.firstMaterial!.specular.contents = UIColor.white
        self.addChildNode(gameoverHeaderNode)
        
        // Add current score
        
        // Add Highest score
        
        // Add Replay button
        
        // Add highscore button
        
        // Add home button
        
        
        self.addChildNode(backPanel)
    }
    
    var score : Int = 0 {
        didSet {
            // update score text
            print("Score added ",score)
            
        }
    }
    
    
    
    
    
}
