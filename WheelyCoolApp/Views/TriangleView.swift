//
//  TriangleView.swift
//  WheelyCoolApp
//
//  Created by jChavez17 on 2/6/19.
//  Copyright © 2019 jChavez17. All rights reserved.
//

import UIKit

class TriangleView : UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func draw(_ rect: CGRect) {
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        context.beginPath()
        context.move(to: CGPoint(x: rect.maxX, y: rect.minY))
        context.addLine(to: CGPoint(x: rect.minX, y: (rect.maxY / 2.0)))
        context.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        context.closePath()
        
        context.setFillColor(UIColor.black.cgColor)
        context.fillPath()
    }
}
