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
import AVFoundation

class Scoreboard : SCNNode {
    
    var tone: Audio!
    var engine: AVAudioEngine!
    
    var bestNode:SCNNode! = nil
    var currentNode:SCNNode! = nil
    
    var bestTxt:SCNText! = nil
    var curTxt:SCNText! = nil
    
    required init(coder: NSCoder) {
        fatalError("NSCoding not supported")
    }
    init(name:String,position:SCNVector3, pivot:SCNMatrix4, scale:SCNVector3, score:Int){
        print("Scoreboard Init")
        scoreBgMat.diffuse.contents = UIColor.clear
        super.init()
        self.geometry = SCNBox(width: scoreBoardWidth, height: scoreBoardHeight, length: scoreBoardDepth, chamferRadius: scoreBoardRadius)
        self.name = name
        self.geometry?.materials = [scoreBgMat]
        self.position = position
        self.pivot = pivot
        self.scale = scale
        self.score = score
    }

    func setup(){
        tone = Audio.sharedInstance
        
        let format = AVAudioFormat(standardFormatWithSampleRate: tone.sampleRate, channels: 1)
        
        engine = AVAudioEngine()
        engine.attach(tone)
        let mixer = engine.mainMixerNode
        engine.connect(tone, to: mixer, format: format)
        do {
            try engine.start()
        } catch let error as NSError {
            print(error)
        }
        
        bestTxt = SCNText(string: "best: 0", extrusionDepth: 8)
        bestTxt.font = UIFont(name: "Hangar-Flat", size: 20)
        bestNode = SCNNode(geometry: bestTxt)
        bestNode.name = "bestscore"
        bestNode.scale = SCNVector3Make(0.008, 0.008, 0.008)
        bestNode.position = SCNVector3Make(0.0, 0.2, 0.0)
        bestTxt.flatness = 0.1
        bestTxt.chamferRadius = 0.1
        var bestMinVec = SCNVector3Zero
        var bestMaxVec = SCNVector3Zero
        if bestNode.__getBoundingBoxMin(&bestMinVec, max: &bestMaxVec) {
            let distance = SCNVector3(
                x: bestMaxVec.x - bestMinVec.x,
                y: bestMaxVec.y - bestMinVec.y,
                z: bestMaxVec.z - bestMinVec.z)
            bestNode.pivot = SCNMatrix4MakeTranslation(distance.x / 2, distance.y / 3, distance.z / 2)
        }
        bestTxt.firstMaterial!.diffuse.contents = UIColor.white
        bestTxt.firstMaterial!.specular.contents = UIColor.white
        self.addChildNode(bestNode)

        
        curTxt = SCNText(string: "score: 0", extrusionDepth: 8)
        curTxt.font = UIFont(name: "Hangar-Flat", size: 20)
        currentNode = SCNNode(geometry: curTxt)
        currentNode.name = "currentscore"
        currentNode.scale = SCNVector3Make(0.01, 0.01, 0.01)
        currentNode.position = SCNVector3Make(-0.02, -0.22, 0.5)
        curTxt.flatness = 0.1
        curTxt.chamferRadius = 0.1
        var curMinVec = SCNVector3Zero
        var curMaxVec = SCNVector3Zero
        if currentNode.__getBoundingBoxMin(&curMinVec, max: &curMaxVec) {
            let distance = SCNVector3(
                x: curMaxVec.x - curMinVec.x,
                y: curMaxVec.y - curMinVec.y,
                z: curMaxVec.z - curMinVec.z)
            currentNode.pivot = SCNMatrix4MakeTranslation(distance.x / 2, distance.y / 3, distance.z / 2)
        }
        curTxt.firstMaterial!.diffuse.contents = UIColor.white
        curTxt.firstMaterial!.specular.contents = UIColor.white
        self.addChildNode(currentNode)
        
        print("ScoreBoard setup!!")
    }
    
    
    var score : Int = 0 {
        didSet {
            print("Score added ",score)
            highscore = highscore + score // update score text
//            setAudioFreq(freq:getFrequencyForScore(score: score))
//            playAudio()
        }
    }
    
    var highscore : Int = 0 {
        didSet {
            print("highscore = ",highscore," -> Text node ",curTxt) // update score text
            curTxt.string = "SCORE: "+String(highscore)
        }
    }
    
    func getFrequencyForScore(score:Int) -> Double {
        var freq:Double = 0.0
        switch score {
        case 2: freq = 2.0
        case 4: freq = 4.0
        case 8: freq = 8.0
        case 16: freq = 16.0
        case 32: freq = 32.0
        case 64: freq = 64.0
        case 128: freq = 128.0
        case 256: freq = 256.0
        case 512: freq = 512.0
        case 1024: freq = 1024.0
        case 2048: freq = 2048.0
        default: break
            // no sound
        }
        return freq
    }
    
    func setAudioFreq(freq:Double){
        tone.frequency = freq
    }
    
    func playAudio(){
        if tone.isPlaying {
            engine.mainMixerNode.volume = 0.0
            tone.stop()
        }
        tone.preparePlaying()
        tone.play()
        engine.mainMixerNode.volume = 1.0
    }
    
}
