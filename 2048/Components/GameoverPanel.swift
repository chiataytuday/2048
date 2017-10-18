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
        
    }
    
    var score : Int = 0 {
        didSet {
            // update score text
            print("Score added ",score)
            
        }
    }
    
    
    
    
    
}
