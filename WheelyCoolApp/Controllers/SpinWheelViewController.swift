//
//  SpinWheelViewController.swift
//  WheelyCoolApp
//
//  Created by jChavez17 on 2/5/19.
//  Copyright © 2019 jChavez17. All rights reserved.
//

import UIKit

class SpinWheelViewController: UIViewController {
    var wheelOptions = [WheelOption]()
    
    //MARK: - UIComponents
    lazy var wheelView: WheelView = {
        let wheelView = WheelView.init(items: wheelOptions)
        wheelView.backgroundColor = .black
        return wheelView
    }()
    
    var spinButton: ActionButton = {
        let spinButton = ActionButton()
        spinButton.setTitle(NSLocalizedString("Spin the wheel!", comment: ""), for: .normal)
        spinButton.addTarget(self, action: #selector(spinTapped), for: .touchUpInside)
        return spinButton
    }()
    
    var triangleView: TriangleView = {
        let triangleView = TriangleView()
        triangleView.backgroundColor = .clear
        return triangleView
    }()

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareInterface()
    }
    
    init (items: [WheelOption]) {
        super.init(nibName: nil, bundle: nil)
        self.wheelOptions = items
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Interface
    private func prepareInterface() {
        view.backgroundColor = .white
        title = Constants.Titles.WheelViewController
        addComponents()
        setupConstraints()
    }
    
    private func addComponents() {
        view.addSubview(wheelView)
        view.addSubview(spinButton)
        view.addSubview(triangleView)
    }
    
    private func setupConstraints() {
        
        wheelView.setAnchors(
            width: (view.frame.width * 0.75),
            height:(view.frame.width * 0.75)
        )
        wheelView.setCenters(
            centerX: view.centerXAnchor,
            centerY: view.centerYAnchor
        )
        spinButton.setAnchors(
            top: nil,
            left: view.safeLeftAnchor,
            right: view.safeRightAnchor,
            bottom: view.safeBottomAnchor,
            paddingTop: 0,
            paddingLeft: 32,
            paddingRight: -32,
            paddingBottom: -32,
            width: 0,
            height: 60
        )
        triangleView.setAnchors(
            width: 20.0,
            height: 20.0)
        triangleView.setCenters(
            centerX: wheelView.rightAnchor,
            centerY: view.centerYAnchor
        )
        view.layoutSubviews()
    }
    
    //MARK: - Actions
    @objc func spinTapped() {
        wheelView.rotate(itemCount: wheelOptions.count)
    }
}
