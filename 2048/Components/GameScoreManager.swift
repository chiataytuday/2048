//
//  GameScoreManager.swift
//  2048
//
//  Created by per thoresson on 10/5/17.
//  Copyright © 2017 per thoresson. All rights reserved.
//

import Foundation

class GameScoreManager {
    static let sharedInstance = GameScoreManager()
    
    let userDefaults = UserDefaults.standard
    
    
    func saveScore(score:Int){
        
    }
    
    
    // Bool helpers
    func getFlagForKey(key:String) -> Bool { return userDefaults.bool(forKey:key) }
    func setFlagForKey(key:String, val:Bool){ userDefaults.set(val, forKey: key) }
}
