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

    var backPanel:SCNNode! = nil                // Primitive panel
    
    var gameoverHeaderNode:SCNNode! = nil       // Title text
    var gameoverHeaderTxt:SCNText! = nil
    
    var scoreTitleNode:SCNNode! = nil           // Current gamescore text
    var scoreTitleTxt:SCNText! = nil
    var scoreNode:SCNNode! = nil                // Current gamescore text
    var scoreTxt:SCNText! = nil
    
    var highScoreTitleNode:SCNNode! = nil       // Current gamescore text
    var highScoreTitleTxt:SCNText! = nil
    var highScoreNode:SCNNode! = nil            // Current gamescore text
    var highScoreTxt:SCNText! = nil
    
    
    // buttons
    var replayBtnNode:SCNNode! = nil            // Replay Button
    var replayBtnTxt:SCNText! = nil
    
    var highscoreBtnNode:SCNNode! = nil         // Highscore Button
    var highscoreBtnTxt:SCNText! = nil
    
    var homeBtnNode:SCNNode! = nil              // Home Button
    var homeBtnTxt:SCNText! = nil
    
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
        gameoverHeaderNode.name = "gameoverHeader"
        gameoverHeaderNode.scale = SCNVector3Make(0.03, 0.03, 0.03)
        gameoverHeaderNode.position = SCNVector3Make(0.0, 1.7, 0.55)
        gameoverHeaderTxt.flatness = 0.1
        gameoverHeaderTxt.chamferRadius = 0.1
        var goMinVec = SCNVector3Zero
        var goMaxVec = SCNVector3Zero
        if gameoverHeaderNode.__getBoundingBoxMin(&goMinVec, max: &goMaxVec) {
            let distance = SCNVector3(
                x: goMaxVec.x - goMinVec.x,
                y: goMaxVec.y - goMinVec.y,
                z: goMaxVec.z - goMinVec.z)
            gameoverHeaderNode.pivot = SCNMatrix4MakeTranslation(distance.x / 2, distance.y / 3, distance.z / 2)
        }
        gameoverHeaderTxt.firstMaterial!.diffuse.contents = UIColor.white
        gameoverHeaderTxt.firstMaterial!.specular.contents = UIColor.white
        
        
        // Add current score
        scoreTitleTxt = SCNText(string: "Current Score", extrusionDepth: 8)
        scoreTitleTxt.font = UIFont(name: "Hangar-Flat", size: 20)
        scoreTitleNode = SCNNode(geometry: scoreTitleTxt)
        scoreTitleNode.name = "scoreTitle"
        scoreTitleNode.scale = SCNVector3Make(0.014, 0.014, 0.014)
        scoreTitleNode.position = SCNVector3Make(0.0, 1.27, 0.45)
        scoreTitleTxt.flatness = 0.1
        scoreTitleTxt.chamferRadius = 0.1
        var stMinVec = SCNVector3Zero
        var stMaxVec = SCNVector3Zero
        if scoreTitleNode.__getBoundingBoxMin(&stMinVec, max: &stMaxVec) {
            let distance = SCNVector3(
                x: stMaxVec.x - stMinVec.x,
                y: stMaxVec.y - stMinVec.y,
                z: stMaxVec.z - stMinVec.z)
            scoreTitleNode.pivot = SCNMatrix4MakeTranslation(distance.x / 2, distance.y / 3, distance.z / 2)
        }
        scoreTitleTxt.firstMaterial!.diffuse.contents = UIColor.white
        scoreTitleTxt.firstMaterial!.specular.contents = UIColor.white



        scoreTxt = SCNText(string: "1240", extrusionDepth: 8)
        scoreTxt.font = UIFont(name: "Hangar-Flat", size: 20)
        scoreNode = SCNNode(geometry: scoreTxt)
        scoreNode.name = "scoreTxt"
        scoreNode.scale = SCNVector3Make(0.028, 0.028, 0.028)
        scoreNode.position = SCNVector3Make(0.0, 0.76, 0.48)
        scoreTxt.flatness = 0.1
        scoreTxt.chamferRadius = 0.1
        var snMinVec = SCNVector3Zero
        var snMaxVec = SCNVector3Zero
        if scoreNode.__getBoundingBoxMin(&snMinVec, max: &snMaxVec) {
            let distance = SCNVector3(
                x: snMaxVec.x - snMinVec.x,
                y: snMaxVec.y - snMinVec.y,
                z: snMaxVec.z - snMinVec.z)
            scoreNode.pivot = SCNMatrix4MakeTranslation(distance.x / 2, distance.y / 3, distance.z / 2)
        }
        scoreTxt.firstMaterial!.diffuse.contents = UIColor.white
        scoreTxt.firstMaterial!.specular.contents = UIColor.white


        // Add Highest score
        highScoreTitleTxt = SCNText(string: "Best Score", extrusionDepth: 8)
        highScoreTitleTxt.font = UIFont(name: "Hangar-Flat", size: 20)
        highScoreTitleNode = SCNNode(geometry: highScoreTitleTxt)
        highScoreTitleNode.name = "highScoreTitle"
        highScoreTitleNode.scale = SCNVector3Make(0.009, 0.009, 0.009)
        highScoreTitleNode.position = SCNVector3Make(0.0, 0.4, 0.45)
        highScoreTitleTxt.flatness = 0.1
        highScoreTitleTxt.chamferRadius = 0.1
        var hstMinVec = SCNVector3Zero
        var hstMaxVec = SCNVector3Zero
        if highScoreTitleNode.__getBoundingBoxMin(&hstMinVec, max: &hstMaxVec) {
            let distance = SCNVector3(
                x: hstMaxVec.x - hstMinVec.x,
                y: hstMaxVec.y - hstMinVec.y,
                z: hstMaxVec.z - hstMinVec.z)
            highScoreTitleNode.pivot = SCNMatrix4MakeTranslation(distance.x / 2, distance.y / 3, distance.z / 2)
        }
        highScoreTitleTxt.firstMaterial!.diffuse.contents = UIColor.white
        highScoreTitleTxt.firstMaterial!.specular.contents = UIColor.white
        

        highScoreTxt = SCNText(string: "2048", extrusionDepth: 8)
        highScoreTxt.font = UIFont(name: "Hangar-Flat", size: 20)
        highScoreNode = SCNNode(geometry: highScoreTxt)
        highScoreNode.name = "highScoreTxt"
        highScoreNode.scale = SCNVector3Make(0.018, 0.018, 0.018)
        highScoreNode.position = SCNVector3Make(0.0, 0.05, 0.45)
        highScoreTxt.flatness = 0.1
        highScoreTxt.chamferRadius = 0.1
        var hsMinVec = SCNVector3Zero
        var hsMaxVec = SCNVector3Zero
        if highScoreNode.__getBoundingBoxMin(&hsMinVec, max: &hsMaxVec) {
            let distance = SCNVector3(
                x: hsMaxVec.x - hsMinVec.x,
                y: hsMaxVec.y - hsMinVec.y,
                z: hsMaxVec.z - hsMinVec.z)
            highScoreNode.pivot = SCNMatrix4MakeTranslation(distance.x / 2, distance.y / 3, distance.z / 2)
        }
        highScoreTxt.firstMaterial!.diffuse.contents = UIColor.white
        highScoreTxt.firstMaterial!.specular.contents = UIColor.white


        // Add Replay button
        replayBtnTxt = SCNText(string: "\u{f21c}", extrusionDepth: 8)
        replayBtnTxt.font = UIFont(name: "Ionicons", size: 20)
        replayBtnNode = SCNNode(geometry: replayBtnTxt)
        replayBtnNode.name = "replayBtn"
        replayBtnNode.scale = SCNVector3Make(0.05, 0.05, 0.05)
        replayBtnNode.position = SCNVector3Make(0.0, -0.9, 0.5)
        replayBtnTxt.flatness = 0.1
        replayBtnTxt.chamferRadius = 0.1
        var rpbMinVec = SCNVector3Zero
        var rpbMaxVec = SCNVector3Zero
        if replayBtnNode.__getBoundingBoxMin(&rpbMinVec, max: &rpbMaxVec) {
            let distance = SCNVector3(
                x: rpbMaxVec.x - rpbMinVec.x,
                y: rpbMaxVec.y - rpbMinVec.y,
                z: rpbMaxVec.z - rpbMinVec.z)
            replayBtnNode.pivot = SCNMatrix4MakeTranslation(distance.x / 2, distance.y / 3, distance.z / 2)
        }
        replayBtnTxt.firstMaterial!.diffuse.contents = UIColor.white
        replayBtnTxt.firstMaterial!.specular.contents = UIColor.white


        // Add highscore button
        highscoreBtnTxt = SCNText(string: "\u{f348}", extrusionDepth: 8)
        highscoreBtnTxt.font = UIFont(name: "Ionicons", size: 20)
        highscoreBtnNode = SCNNode(geometry: highscoreBtnTxt)
        highscoreBtnNode.name = "scoreBtn"
        highscoreBtnNode.scale = SCNVector3Make(0.03, 0.03, 0.03)
        highscoreBtnNode.position = SCNVector3Make(-0.9, -0.9, 0.45)
        highscoreBtnTxt.flatness = 0.1
        highscoreBtnTxt.chamferRadius = 0.1
        var hsbMinVec = SCNVector3Zero
        var hsbMaxVec = SCNVector3Zero
        if highscoreBtnNode.__getBoundingBoxMin(&hsbMinVec, max: &hsbMaxVec) {
            let distance = SCNVector3(
                x: hsbMaxVec.x - hsbMinVec.x,
                y: hsbMaxVec.y - hsbMinVec.y,
                z: hsbMaxVec.z - hsbMinVec.z)
            highscoreBtnNode.pivot = SCNMatrix4MakeTranslation(distance.x / 2, distance.y / 3, distance.z / 2)
        }
        highscoreBtnTxt.firstMaterial!.diffuse.contents = UIColor.white
        highscoreBtnTxt.firstMaterial!.specular.contents = UIColor.white
        
        
        // Add home button
        homeBtnTxt = SCNText(string: "\u{f38f}", extrusionDepth: 8)
        homeBtnTxt.font = UIFont(name: "Ionicons", size: 20)
        homeBtnNode = SCNNode(geometry: homeBtnTxt)
        homeBtnNode.name = "homeBtn"
        homeBtnNode.scale = SCNVector3Make(0.03, 0.03, 0.03)
        homeBtnNode.position = SCNVector3Make(0.9, -0.9, 0.45)
        homeBtnTxt.flatness = 0.1
        homeBtnTxt.chamferRadius = 0.1
        var hbMinVec = SCNVector3Zero
        var hbMaxVec = SCNVector3Zero
        if homeBtnNode.__getBoundingBoxMin(&hbMinVec, max: &hbMaxVec) {
            let distance = SCNVector3(
                x: hbMaxVec.x - hbMinVec.x,
                y: hbMaxVec.y - hbMinVec.y,
                z: hbMaxVec.z - hbMinVec.z)
            homeBtnNode.pivot = SCNMatrix4MakeTranslation(distance.x / 2, distance.y / 3, distance.z / 2)
        }
        homeBtnTxt.firstMaterial!.diffuse.contents = UIColor.white
        homeBtnTxt.firstMaterial!.specular.contents = UIColor.white
        
        self.addChildNode(backPanel)
        self.addChildNode(gameoverHeaderNode)
        self.addChildNode(scoreTitleNode)
        self.addChildNode(scoreNode)
        self.addChildNode(highScoreTitleNode)
        self.addChildNode(highScoreNode)
        self.addChildNode(highscoreBtnNode)
        self.addChildNode(replayBtnNode)
        self.addChildNode(homeBtnNode)
        
    }
    
    func setScore(val:Int){
        self.score = val
    }
    
    var score : Int = 0 {
        didSet {
            // update score text
            print("Score added ",score)
            scoreTxt.string = String(score)
            // get best score from memory
            highScoreTxt.string = String( GameScoreManager.sharedInstance.getHighScore() )
        }
    }
    
    
    
    
    
}
