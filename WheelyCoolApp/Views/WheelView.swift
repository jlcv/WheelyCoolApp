//
//  WheelView.swift
//  WheelyCoolApp
//
//  Created by jChavez17 on 2/6/19.
//  Copyright © 2019 jChavez17. All rights reserved.
//

import UIKit
import QuartzCore

class WheelView: UIView {
    
    var items: [WheelOption] = []
    
    lazy var rotation: CABasicAnimation = {
        let rotation = CABasicAnimation(keyPath: "transform.rotation")
        rotation.fillMode = CAMediaTimingFillMode.forwards
        rotation.isRemovedOnCompletion = false
        return rotation
    }()
    
    //MARK: - Lifecycle
    init (items: [WheelOption]) {
        super.init(frame: CGRect.zero)
        self.items = items
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Interface
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = (bounds.width / 2.0)
        clipsToBounds = true
        addItemLabels()
        self.backgroundColor = .lightGray
    }
    
    private func addItemLabels() {
        for (index, item) in items.enumerated() {
            let itemLabel = UILabel.init(frame: CGRect.init(x: frame.size.width, y: frame.size.height, width: (frame.size.width / 2.0), height: 40))
            itemLabel.text = item.name
            itemLabel.textAlignment = .center
            itemLabel.layer.anchorPoint = CGPoint.init(x: 0.0, y: 0.5)
            itemLabel.layer.position = CGPoint(x: frame.size.width / 2.0,
                                               y: frame.size.height / 2.0)
            itemLabel.transform = CGAffineTransform(rotationAngle: CGFloat(CircleCalculator.getAngleSize(itemCount: items.count) * Float(index)))
            itemLabel.tag = index
            addSubview(itemLabel)
        }
    }
    
    //MARK: - Public Methods
    public func rotate(itemCount: Int) {
        guard itemCount > 0 else {
            return
        }
        rotation.toValue = CircleCalculator.generateRandomRotationValue(itemCount: itemCount)
        rotation.duration = 5
        let timingFunction = CAMediaTimingFunction(controlPoints: 0.2, 0.4, 0.7, 0.9)
        rotation.timingFunction = timingFunction
        layer.add(rotation, forKey: "initializeAnimation")
    }
}
