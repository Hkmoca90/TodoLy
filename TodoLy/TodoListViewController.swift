//
//  ViewController.swift
//  TodoLy
//
//  Created by Hector Moreno on 1/31/19.
//  Copyright © 2019 Hector Moreno. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    let defaults = UserDefaults.standard
    var itemArray = ["Yea","SAT", "Infonavit"]
    override func viewDidLoad() {
        super.viewDidLoad()
        if let items = defaults.array(forKey: "TodoListArray") as? [String] {
            itemArray = items
        }

    }

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem){
        var textFiel = UITextField()
        let alert = UIAlertController.init(title: "Add New todoey Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction.init(title: "Add Item", style: .default) { (action) in
            self.itemArray.append(textFiel.text!)
            self.defaults.set(self.itemArray, forKey: "TodoListArray")
            self.tableView.reloadData()
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textFiel = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(itemArray[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: true)
        let hasCheckmark = tableView.cellForRow(at: indexPath)?.accessoryType
        if hasCheckmark == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
    }
}

