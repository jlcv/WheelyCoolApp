//
//  SetupTableViewController.swift
//  WheelyCoolApp
//
//  Created by jChavez17 on 2/5/19.
//  Copyright © 2019 jChavez17. All rights reserved.
//

import UIKit

class SetupTableViewController: BaseTableViewController<WheelOptionTableViewCell, WheelOption> {
    
    //MARK: - UIComponents
    lazy var continueButton: ActionButton = {
        let continueButton = ActionButton()
        continueButton.setTitle(NSLocalizedString("Continue", comment: ""), for: .normal)
        continueButton.addTarget(self, action: #selector(continueTapped), for: .touchUpInside)
        return continueButton
    }()
    
    lazy var addButton: UIBarButtonItem = {
        let addButton = UIBarButtonItem(
            title: NSLocalizedString("Add", comment: ""),
            style: .plain,
            target: self,
            action: #selector(addTapped(sender:)))
        return addButton
    }()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.prepareData()
        self.prepareInterface()
    }
    
    // MARK: - Data
    private func prepareData() {
        let optionA = WheelOption.init(name: "Pizza")
        let optionB = WheelOption.init(name: "Burger")
        let optionC = WheelOption.init(name: "Pasta")
        items = [optionA, optionB, optionC]
    }
    
    // MARK: - Interface
    private func prepareInterface() {
        self.title = Constants.Titles.SetupTableViewController
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 60.0;
        self.tableView.separatorStyle = .none
        self.addComponents()
        self.setupConstraints()
    }
    
    private func addComponents() {
        self.navigationItem.rightBarButtonItem = addButton
        view.addSubview(continueButton)
    }
    
    private func setupConstraints() {
        continueButton.setAnchors(
            top: nil,
            left: view.safeLeftAnchor,
            right: view.safeRightAnchor,
            bottom: view.safeBottomAnchor,
            paddingTop: 0,
            paddingLeft: 32,
            paddingRight: -32,
            paddingBottom: -32,
            width: 0,
            height: 60)
        view.layoutSubviews()
    }
    
    //MARK: - Action
    @objc private func addTapped(sender: UIBarButtonItem!) {
        
    }
    
    @objc private func continueTapped(sender: UIButton!) {
        let spinWheelViewController = SpinWheelViewController()
        self.navigationController?.pushViewController(spinWheelViewController, animated: true)
    }
    
    // MARK: - Navigation
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
