//
//  ViewController.swift
//  TodoLy
//
//  Created by Hector Moreno on 1/31/19.
//  Copyright © 2019 Hector Moreno. All rights reserved.
//

import UIKit
import CoreData

class TodoListViewController: UITableViewController {

    var itemArray = [Item]()
    var selectedCategory: Category? {
        didSet{
            loadItems()
        }
    }
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))

    }

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem){
        var textFiel = UITextField()
        let alert = UIAlertController.init(title: "Add New todoey Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction.init(title: "Add Item", style: .default) { (action) in
            let newItem = Item(context: self.context)
            newItem.done = false
            newItem.title = textFiel.text!
            newItem.parentCategory = self.selectedCategory
            self.itemArray.append(newItem)
            self.saveItems()
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
        cell.accessoryType = item.done ? .checkmark : .none
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        saveItems()
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func saveItems(){
        do {
            try context.save()
        } catch {
            print("Error encodign item array, \(error)")
        }
        tableView.reloadData()
    }

    func loadItems(with request: NSFetchRequest<Item> = Item.fetchRequest(), predicate: NSPredicate? = nil){
        let categorypredicate = NSPredicate(format: "parentCategory.name MATCHES %@", selectedCategory!.name!)
        if let aditionalPredicate = predicate {
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categorypredicate, aditionalPredicate])
        } else {
            request.predicate = categorypredicate
        }

        do {
            itemArray = try context.fetch(request)
        } catch {
            print("Error fetching item array, \(error)")
        }
        tableView.reloadData()
    }
}

//MARK: - Search bar methods
extension TodoListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        loadItems(with: request, predicate: predicate)
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadItems()
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }

        }
    }
}
