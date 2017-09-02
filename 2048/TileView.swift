//
//  TileView.swift
//  2048
//
//  Created by per thoresson on 9/2/17.
//  Copyright © 2017 per thoresson. All rights reserved.
//

import UIKit

/// A view representing a single swift-2048 tile.
class TileView : UIView {
    var value : Int = 0 {
        didSet {
            backgroundColor = delegate.tileColor(value)
            numberLabel.textColor = delegate.tileNumberColor(value)
            numberLabel.text = "\(value)"
        }
    }
    
    unowned let delegate : StyleDefinitionsProtocol
    let numberLabel : UILabel
    
    required init(coder: NSCoder) {
        fatalError("NSCoding not supported")
    }
    
    init(position: CGPoint, width: CGFloat, value: Int, radius: CGFloat, delegate d: StyleDefinitionsProtocol) {
        delegate = d
        numberLabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: width))
        numberLabel.textAlignment = NSTextAlignment.center
        numberLabel.minimumScaleFactor = 0.5
        numberLabel.font = delegate.tileFont()
        
        super.init(frame: CGRect(x: position.x, y: position.y, width: width, height: width))
        addSubview(numberLabel)
        layer.cornerRadius = radius
        
        self.value = value
        backgroundColor = delegate.tileColor(value)
        numberLabel.textColor = delegate.tileNumberColor(value)
        numberLabel.text = "\(value)"
    }
}
