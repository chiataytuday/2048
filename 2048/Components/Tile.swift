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
    
    var id : Int = 0 {
        didSet { }
    }
    
    var row : Int = 0 {
        didSet { }
    }
    
    var col : Int = 0 {
        didSet { }
    }
    
    var value : Int = 0{
        didSet {
            self.active = true
            switch value {
            case tilevalue.v2:
                self.setMaterialForValue(value: material.m2)
            case tilevalue.v4:
                self.setMaterialForValue(value: material.m4)
            case tilevalue.v8:
                self.setMaterialForValue(value: material.m8)
            case tilevalue.v16:
                self.setMaterialForValue(value: material.m16)
            case tilevalue.v32:
                self.setMaterialForValue(value: material.m32)
            case tilevalue.v64:
                self.setMaterialForValue(value: material.m64)
            case tilevalue.v128:
                self.setMaterialForValue(value: material.m128)
            case tilevalue.v256:
                self.setMaterialForValue(value: material.m256)
            case tilevalue.v512:
                self.setMaterialForValue(value: material.m512)
            case tilevalue.v1024:
                self.setMaterialForValue(value: material.m1024)
            case tilevalue.v2048:
                self.setMaterialForValue(value: material.m2048)
            default:
                self.setMaterialForValue(value: 1000)
                self.active = false
            }
        }
    }
    
    var active : Bool = false {
        didSet {
            if active { self.show()}
            else{ self.hide() }
        }
    }
    
    required init(coder: NSCoder) { fatalError("NSCoding not supported") }
    
    init(geometry: SCNBox, name:String, materials:Array<SCNMaterial>, position:SCNVector3, pivot:SCNMatrix4, scale:SCNVector3, id:Int, row:Int, col:Int){
            super.init()
            self.geometry = geometry
            self.name = name
            self.geometry?.materials = materials
            self.position = position
            self.pivot = pivot
            self.scale = scale
            self.id = id
            self.active = false
            self.row = row
            self.col = col
            self.hide()
    }
    
    func setMaterial(materials:Array<SCNMaterial>){ self.geometry?.materials = materials }
    
    func hide(){ self.opacity = 0.2 }
    
    func show(){ self.opacity = 1.0 }
    
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
            self.hide()
        }
    }
    
}
