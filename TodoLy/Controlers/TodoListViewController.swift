//
//  ViewController.swift
//  TodoLy
//
//  Created by Hector Moreno on 1/31/19.
//  Copyright © 2019 Hector Moreno. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    var itemArray = [ItemList]()
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")

    override func viewDidLoad() {
        super.viewDidLoad()
        loadItems()

    }

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem){
        var textFiel = UITextField()
        let alert = UIAlertController.init(title: "Add New todoey Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction.init(title: "Add Item", style: .default) { (action) in
            self.itemArray.append(ItemList(title: textFiel.text!, isCheck: false))
            self.saveItems()
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
        let item = itemArray[indexPath.row]
        cell.textLabel?.text = item.title
        cell.accessoryType = item.isCheck! ? .checkmark : .none
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        itemArray[indexPath.row].isCheck = !itemArray[indexPath.row].isCheck!
        saveItems()
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func saveItems(){
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
        } catch {
            print("Error encodign item array, \(error)")
        }
        tableView.reloadData()
    }

    func loadItems(){
        if let data = try? Data(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
            do{
                itemArray = try decoder.decode([ItemList].self, from: data)
            } catch {
                print("Error encodign item array, \(error)")
            }
        }

    }
}

