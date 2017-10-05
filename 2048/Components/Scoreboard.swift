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
    
    required init(coder: NSCoder) {
        fatalError("NSCoding not supported")
    }
    init(name:String,position:SCNVector3, pivot:SCNMatrix4, scale:SCNVector3, score:Int){
        print("Scoreboard Init")
        scoreBgMat.diffuse.contents = UIColor.white
        
        logoMat.diffuse.contents = logoBlue
        
        super.init()
        self.geometry = SCNBox(width: side/1.2, height: side/1.2, length: side/1.2, chamferRadius: radius/2)
        self.name = name
        self.geometry?.materials = [logoMat]
        self.position = position
        self.pivot = pivot
        self.scale = scale
        self.score = score
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
