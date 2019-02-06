//
//  WheelOptionTableViewCell.swift
//  WheelyCoolApp
//
//  Created by jChavez17 on 2/5/19.
//  Copyright © 2019 jChavez17. All rights reserved.
//

import UIKit

class WheelOptionTableViewCell: BaseTableViewCell<WheelOption> {

    //MARK: - Components
    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        return nameLabel
    }()
    
    //MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
        addComponents()
        setupLayoutConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Data
    override var item: WheelOption! {
        didSet {
            nameLabel.text = item.name
        }
    }
    
    //MARK: - Interface
    private func setupCell() {
        selectionStyle = .none
    }
    
    private func addComponents() {
        contentView.addSubview(nameLabel)
    }
    
    private func setupLayoutConstraints() {
        nameLabel.setAnchors(
            top: contentView.safeTopAnchor,
            left: contentView.safeLeftAnchor,
            right: contentView.safeRightAnchor,
            bottom: contentView.safeBottomAnchor,
            paddingTop: 32,
            paddingLeft: 32,
            paddingRight: -32,
            paddingBottom: -32,
            width: 0,
            height: 0)
        layoutSubviews()
    }
    
    //MARK: - Private methods
    private func getIndicatorViewColor(status: Int) -> UIColor {
        switch status {
        case 1:
            return UIColor.red
        case 2:
            return UIColor.yellow
        case 3:
            return UIColor.green
        default:
            return UIColor.red
        }
    }
}
