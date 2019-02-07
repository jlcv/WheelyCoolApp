//
//  SetupTableViewController.swift
//  WheelyCoolApp
//
//  Created by jChavez17 on 2/5/19.
//  Copyright © 2019 jChavez17. All rights reserved.
//

import UIKit
import CoreData

class SetupTableViewController: BaseTableViewController<WheelOptionTableViewCell, WheelOption> {
    
    //MARK: - UIComponents
    private var continueButton: ActionButton = {
        let continueButton = ActionButton()
        continueButton.setTitle(NSLocalizedString("Continue", comment: ""), for: .normal)
        continueButton.addTarget(self, action: #selector(continueTapped), for: .touchUpInside)
        return continueButton
    }()
    
    private lazy var addButton: UIBarButtonItem = {
        let addButton = UIBarButtonItem(
            title: NSLocalizedString("Add", comment: ""),
            style: .plain,
            target: self,
            action: #selector(self.addTapped(sender:)))
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
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "WheelOptions")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                let wheelOptionName = data.value(forKey: "name") as! String
                items.append(WheelOption.init(name:wheelOptionName))
            }
        } catch {
            print("Fetch failed")
        }
    }
    
    private func saveWheelOption(wheelOption: WheelOption) -> Bool {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "WheelOptions", in: context)
        let newWheelOption = NSManagedObject(entity: entity!, insertInto: context)
        newWheelOption.setValue(wheelOption.name, forKey: "name")
        do {
            try context.save()
        } catch {
            print("Failed saving")
            return false
        }
        return true
    }
    
    private func deleteWheelOption(wheelOption: WheelOption) -> Bool {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "WheelOptions")
        request.returnsObjectsAsFaults = false
        request.predicate = NSPredicate.init(format: "name == '\(wheelOption.name)'")
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                context.delete(data)
            }
        } catch {
            print("Fetch failed")
            return false
        }
        
        do {
            try context.save()
        } catch {
            print("Failed deleting")
            return false
        }
        return true
    }
    
    // MARK: - Interface
    private func prepareInterface() {
        title = Constants.Titles.SetupTableViewController
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 60.0
        tableView.tableFooterView = UIView()
        self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 120, right: 0)
        addComponents()
        setupConstraints()
    }
    
    private func addComponents() {
        navigationItem.rightBarButtonItem = addButton
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
    
    //MARK: - UITableViewEdit
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if (deleteWheelOption(wheelOption: items[indexPath.row])) {
                items.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        }
    }
    
    //MARK: - Actions
    @objc private func addTapped(sender: UITabBarItem!) {
        if (items.count > 11) {
            let alert = UIAlertController(title: NSLocalizedString("Alert", comment: ""), message: NSLocalizedString("Reached item limit.", comment: ""), preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("Accept", comment: ""), style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        let inputViewController = InputViewController()
        inputViewController.modalPresentationStyle = .overCurrentContext
        inputViewController.modalTransitionStyle = .crossDissolve
        inputViewController.delegate = self
        navigationController?.present(inputViewController, animated: true, completion: nil)
    }
    
    @objc private func continueTapped(sender: UIButton!) {
        let spinWheelViewController = SpinWheelViewController.init(items: items)
        navigationController?.pushViewController(spinWheelViewController, animated: true)
    }
}

extension SetupTableViewController: AddWheelOptionDelegate {
    func didAddWheelItem(wheelOption: WheelOption) {
        if (saveWheelOption(wheelOption: wheelOption)) {
            items.append(wheelOption)
            tableView.reloadData()
        }
    }
}
