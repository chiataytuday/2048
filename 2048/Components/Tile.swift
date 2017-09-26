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
    
//    var tileID:Int = nil
    
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
    
    func setMaterial(materials:Array<SCNMaterial>){
        self.geometry?.materials = materials
    }
    
    func hide(){
        self.opacity = 0.0
    }
    
    func show(){
        self.opacity = 1.0
    }
    
    func setMaterialForValue(value:CGFloat){
        
        switch value {
        case material.m2:
            self.geometry?.materials = [mat2]
        case material.m4:
            self.geometry?.materials = [mat4]
        case material.m8:
            self.geometry?.materials = [mat8]
        case material.m16:
            self.geometry?.materials = [mat16]
        case material.m32:
            self.geometry?.materials = [mat32]
        case material.m64:
            self.geometry?.materials = [mat64]
        case material.m128:
            self.geometry?.materials = [mat128]
        case material.m256:
            self.geometry?.materials = [mat256]
        case material.m512:
            self.geometry?.materials = [mat512]
        case material.m1024:
            self.geometry?.materials = [mat1024]
        case material.m2048:
            self.geometry?.materials = [mat2048]
        default:
            self.geometry?.materials = [logoMat]
        }
    }
    
}
