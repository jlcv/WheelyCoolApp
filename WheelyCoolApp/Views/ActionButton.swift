//
//  ActionButton.swift
//  WheelyCoolApp
//
//  Created by jChavez17 on 2/5/19.
//  Copyright © 2019 jChavez17. All rights reserved.
//

import UIKit

class ActionButton: UIButton {
    
    //MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        prepareInterface()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Interface
    private func prepareInterface() {
        self.layer.cornerRadius = 10.0
        self.clipsToBounds = true
        self.backgroundColor = UIColor.MaterialColor.green50
        self.setTitleColor(.black, for: .normal)
    }
}
