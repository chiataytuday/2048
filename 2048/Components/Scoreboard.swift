//
//  Scoreboard.swift
//  2048
//
//  Created by per thoresson on 10/4/17.
//  Copyright © 2017 per thoresson. All rights reserved.
//

import SceneKit
import SpriteKit
import GameplayKit

class Scoreboard : SCNNode {
    
    var bestTitle:SCNText! = nil
    var bestScore:SCNText! = nil
    
    var currentTitle:SCNText! = nil
    var currentScore:SCNText! = nil
    
    required init(coder: NSCoder) {
        fatalError("NSCoding not supported")
    }
    init(name:String,position:SCNVector3, pivot:SCNMatrix4, scale:SCNVector3, score:Int){
        print("Scoreboard Init")
        scoreBgMat.diffuse.contents = UIColor.white
        super.init()
        self.geometry = SCNBox(width: scoreBoardWidth, height: scoreBoardHeight, length: scoreBoardDepth, chamferRadius: scoreBoardRadius)
        self.name = name
        self.geometry?.materials = [scoreBgMat]
        self.position = position
        self.pivot = pivot
        self.scale = scale
        self.score = score
        self.setup()
    }

    func setup(){
        
    }
    
    
    var score : Int = 0 {
        didSet {
            // update score text
            print("Score added ",score)
            highscore = highscore + score
        }
    }
    
    var highscore : Int = 0 {
        didSet {
            // update score text
            print("highscore = ",highscore)
        }
    }
    

}
