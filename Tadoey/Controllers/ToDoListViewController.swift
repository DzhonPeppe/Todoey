//
//  ViewController.swift
//  Tadoey
//
//  Created by John Peppe on 6/26/18.
//  Copyright © 2018 John Peppe. All rights reserved.
//

import UIKit
import RealmSwift

class ToDoListViewController: UITableViewController {
    
    var toDoItem : Results<Item>?
    
    let realm = try! Realm()
    
    var selectedCategory : Category? {
        didSet {
            loadItems()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
    }

    //MARK: - Tableview Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoItem?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        if let item = toDoItem?[indexPath.row] {
            
            cell.textLabel?.text = item.title
            
            //Ternary operator ==>
            //value = condition ? valueIfTrue : valueIfFalse
            
            cell.accessoryType = item.done ? .checkmark : .none
            
        } else {
            
            cell.textLabel?.text = "No Items Added"
            
        }
        
      
        
        return cell
        
    }
    
    //MARK: - Tableview Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        if let item = toDoItem?[indexPath.row] {
            
            do {
                try realm.write {
                    
                    item.done = !item.done
                }
            }catch {
                print("Error saving done status, \(error)")
            }
        }
        
        tableView.reloadData()
        
//        context.delete(itemArray[indexPath.row])
//        itemArray.remove(at: indexPath.row)
        
//        toDoItems?[indexPath.row].done = !toDoItem[indexPath.row].done
//
//        saveItems()
//
        tableView.deselectRow(at: indexPath, animated: true)
        
    }

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //What will happen when add item pressed on alert
            
            if let currentCategory = self.selectedCategory {
                do {
                    try self.realm.write {
                        let newItem = Item()
                        newItem.title = textField.text!
                        newItem.dateCreated = Date()
                        currentCategory.items.append(newItem)
                    }
                    } catch {
                        print("Error saving new items, \(error)_")
                    }
                }
            
            self.tableView.reloadData()
            
            }
            
        
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Item"
            textField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    //MARK: - Model Manipulation Methods
    
    
    
    
    func loadItems() {

        toDoItem = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
        
        tableView.reloadData()
        
    }
    
    
    
}


//MARK: - Search bar methods

extension ToDoListViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        toDoItem = toDoItem?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "dateCreated", ascending: true)
        
        tableView.reloadData()

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





    


















