//
//  GameViewController.swift
//  2048
//
//  Created by per thoresson on 9/1/17.
//  Copyright © 2017 per thoresson. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    
    var viewRef:SKView! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            let scene = HomeScene(size: self.view.bounds.size);
            
            scene.gameViewController = self
            
            viewRef = view
            
            viewRef.ignoresSiblingOrder = true
            viewRef.showsFPS = true
            viewRef.showsNodeCount = true
            viewRef.presentScene(scene)
        }
        
    }
    
    func moveToScene(to:CGFloat){
        
        print("moveToScene")
        
        switch to {
        case scenes.game:
            let gameScene = GameScene(size: viewRef.bounds.size)
            gameScene.gameViewController = self
            viewRef?.presentScene(gameScene, transition: sceneTransitionFade)
            break
        case scenes.info:
            let infoScene = InfoScene(size: CGSize(width: screenW, height: screenH))
            infoScene.gameViewController = self
            viewRef?.presentScene(infoScene, transition: sceneTransitionFade)
            break
        case scenes.score:
            let highscoreScene = HighscoreScene(size: CGSize(width: screenW, height: screenH))
            highscoreScene.gameViewController = self
            viewRef?.presentScene(highscoreScene, transition: sceneTransitionFade)
            break
        case scenes.settings:
            let settingScene = SettingsScene(size: CGSize(width: screenW, height: screenH))
            settingScene.gameViewController = self
            viewRef?.presentScene(settingScene, transition: sceneTransitionFade)
            break
        default:
            let homeScene = HomeScene(size: CGSize(width: screenW, height: screenH))
            homeScene.gameViewController = self
            viewRef?.presentScene(homeScene, transition: sceneTransitionFade)
        }

    }
    

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
