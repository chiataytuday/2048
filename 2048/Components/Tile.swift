//
//  Tile.swift
//  2048
//
//  Created by per thoresson on 9/25/17.
//  Copyright © 2017 per thoresson. All rights reserved.
//

import SceneKit
import SpriteKit
import GameplayKit

class Tile : SCNNode {
    
    required init(coder: NSCoder) {
        fatalError("NSCoding not supported")
    }
    init(geometry: SCNBox, name:String, materials:Array<SCNMaterial>, position:SCNVector3, pivot:SCNMatrix4, scale:SCNVector3){
            super.init()
            self.geometry = geometry
            self.name = name
            self.geometry?.materials = materials
            self.position = position
            self.pivot = pivot
            self.scale = scale
    }
    
}