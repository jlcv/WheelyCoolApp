//
//  ViewController.swift
//  WheelyCoolApp
//
//  Created by jChavez17 on 2/5/19.
//  Copyright © 2019 jChavez17. All rights reserved.
//

import UIKit

//MARK: - AddWheelOptionDelegate
protocol AddWheelOptionDelegate: class {
    func didAddWheelItem(wheelOption: WheelOption)
}

class InputViewController: UIViewController {
    
    weak var delegate: AddWheelOptionDelegate?
    
    //MARK: - UIComponents
    var backgroundView: UIView = {
        let backgroundView = UIView()
        return backgroundView
    }()
    
    var containerView: UIView = {
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.white
        backgroundView.layer.cornerRadius = 10.0
        backgroundView.clipsToBounds = true
        return backgroundView
    }()
    
    var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = NSLocalizedString("Add Item", comment: "")
        titleLabel.font = UIFont.boldSystemFont(ofSize: 19.0)
        titleLabel.textAlignment = .center
        return titleLabel
    }()
    
    lazy var itemTextField: UITextField = {
        let itemTextField = UITextField()
        itemTextField.placeholder = NSLocalizedString("Item name", comment: "")
        itemTextField.textAlignment = .center
        itemTextField.borderStyle = .roundedRect
        itemTextField.delegate = self
        return itemTextField
    }()
    
    var acceptButton: ActionButton = {
        let acceptButton = ActionButton()
        acceptButton.setTitle(NSLocalizedString("Accept", comment: ""), for: .normal)
        acceptButton.addTarget(self, action: #selector(acceptTapped), for: .touchUpInside)
        return acceptButton
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareInterface()
    }
    
    //MARK: - Interface
    private func prepareInterface() {
        backgroundView.backgroundColor = UIColor.init(red: 0.8, green: 0.8, blue: 0.8, alpha: 0.8)
        backgroundView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(self.backgroundTapped)))
        addComponents()
        setupConstraints()
    }
    
    private func addComponents() {
        view.addSubview(backgroundView)
        view.addSubview(containerView)
        view.addSubview(titleLabel)
        view.addSubview(itemTextField)
        view.addSubview(acceptButton)
    }
    
    private func setupConstraints() {
        backgroundView.setCenters(
            centerX: view.centerXAnchor,
            centerY: view.centerYAnchor
        )
        backgroundView.setAnchors(
            width: view.frame.width,
            height: view.frame.height
        )
        containerView.setCenters(
            centerX: view.centerXAnchor,
            centerY: view.centerYAnchor
        )
        containerView.setAnchors(
            width: (view.frame.width * 0.75),
            height: (view.frame.width * 0.75)
        )
        titleLabel.setAnchors(
            top: containerView.safeTopAnchor,
            left: containerView.safeLeftAnchor,
            right: containerView.safeRightAnchor,
            bottom: nil,
            paddingTop: 32,
            paddingLeft: 32,
            paddingRight: -32,
            paddingBottom: 0,
            width: 0,
            height: 60)
        itemTextField.setCenters(
            centerX: view.centerXAnchor,
            centerY: view.centerYAnchor
        )
        itemTextField.setAnchors(
            width: (view.frame.width * 0.60),
            height: 50.0
        )
        acceptButton.setAnchors(
            top: nil,
            left: containerView.safeLeftAnchor,
            right: containerView.safeRightAnchor,
            bottom: containerView.safeBottomAnchor,
            paddingTop: 0,
            paddingLeft: 32,
            paddingRight: -32,
            paddingBottom: -32,
            width: 0,
            height: 60)
        view.layoutSubviews()
    }
    
    //MARK: - Actions
    @objc private func backgroundTapped(sender: UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func acceptTapped(sender: UIButton!) {
        let wheelOptionName = itemTextField.text ?? ""
        if (wheelOptionName.count > 0) {
            delegate?.didAddWheelItem(wheelOption: WheelOption.init(name: wheelOptionName))
            dismiss(animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: NSLocalizedString("Alert", comment: ""), message: "Please add a valid name.", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("Accept", comment: ""), style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
}

extension InputViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true }
        let count = text.count + string.count - range.length
        return count <= 10
    }
}
