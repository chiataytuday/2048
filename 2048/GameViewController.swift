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
        var nextScene:SKScene! = nil
        
        print("moveToScene")
        
        switch to {
        case scenes.game:
            nextScene = GameScene(size: viewRef.bounds.size)
            break
        case scenes.info:
            nextScene = InfoScene(size: CGSize(width: screenW, height: screenH))
            break
        case scenes.score:
            nextScene = HighscoreScene(size: CGSize(width: screenW, height: screenH))
            break
        case scenes.settings:
            nextScene = SettingsScene(size: CGSize(width: screenW, height: screenH))
            break
        default:
            nextScene = HomeScene(size: CGSize(width: screenW, height: screenH))
        }
        
        // viewRef.presentScene(nextScene)
        
        viewRef?.presentScene(nextScene, transition: sceneTransitionFade)
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
