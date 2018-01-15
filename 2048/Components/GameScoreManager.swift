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
    
    let highscore:String = "highscore"
    let userDefaults = UserDefaults.standard
    
    func saveScore(score:Int){
        var scores = userDefaults.object(forKey: highscore) as? [Int] ?? [Int]()                            // get current existing score
        scores.append(score)                                                                                // add score to stack
        scores = scores.sorted(by: >)                                                                       // sort array decending
        while scores.count > 10 { scores.removeLast() }                                                     // limit the highscore list to the last 10 games
        userDefaults.set(scores, forKey: highscore)                                                         // store the list of scores back to userdefaults
    }
    
    func getScores() -> Array<Int> { return userDefaults.object(forKey: highscore) as? [Int] ?? [Int]() }   // Returns list of scores
    
    func getHighScore() -> Int {                                                                            // Return Highest Score
        var ret = 0
        var list = getScores()
        if list.count>0 {
            for itm in list { print("list: ",itm) }
            list = list.sorted { $0 > $1 }
            ret = list[0]
        }
        return ret
    }
    
    // Bool helpers
    func getFlagForKey(key:String) -> Bool { return userDefaults.bool(forKey:key) }                         // Returns Bool value for Key
    func setFlagForKey(key:String, val:Bool){ userDefaults.set(val, forKey: key) }                          // Set Bool flag for Key
}
