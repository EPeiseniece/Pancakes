//
//  SavedTableViewController.swift
//  Pancakes
//
//  Created by elina.peiseniece on 01/09/2021.
//

import UIKit
import CoreData

class SavedTableViewController: UITableViewController {
    
    var savedItems = [Recipes]()
    var context: NSManagedObjectContext?
    
    @IBOutlet weak var editButtonLabel: UIBarButtonItem!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.reloadData()

        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        context = appDelegate.persistentContainer.viewContext
        loadData()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        loadData()
        countItems()
    }

    
    
    func saveData(){
        do {
            try context?.save()
 
        } catch  {
            print(error.localizedDescription)
        }
        loadData()
    }
     
    func loadData(){
        let request: NSFetchRequest<Recipes> = Recipes.fetchRequest()
        do {
            savedItems = try (context?.fetch((request)))!
            tableView.reloadData()
        } catch {
            fatalError("Error retrieveing saved Items")
        }
    }
    
    func countItems()
    {
        let itemsInTable = String(self.tableView.numberOfRows(inSection: 0))
        self.title = "Saved \(itemsInTable)"
    }
        
    @IBAction func infoButtonTapped(_ sender: Any) {
        basicAlert(title: "Select article", message: "To read full article, please select it")
    }
    
    @IBAction func editButtonTapped(_ sender: Any) {
        tableView.isEditing = !tableView.isEditing
        if tableView.isEditing{
            editButtonLabel.title = "Save"
        }else{
            editButtonLabel.title = "Edit"
        }
        
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return savedItems.count
    }

 
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "savedCell", for: indexPath)

        let item = savedItems[indexPath.row]
        cell.textLabel?.text = item.recipeTitle
        cell.textLabel?.numberOfLines = 0
        
        if let image = UIImage(data: item.image!){
            cell.imageView?.image = image

    }
        return cell
    }

        override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 150
        }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let alert = UIAlertController(title: "Delete", message: "Are you sure you want to delete?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

            alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { _ in
                let item = self.savedItems[indexPath.row]
                self.context?.delete(item)
                self.saveData()
            }))
            self.present(alert, animated: true)
            countItems()
        }

    }

    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        let row = savedItems.remove(at: fromIndexPath.row)
        savedItems.insert(row, at: to.row)
        


    }

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let vc = storyboard.instantiateViewController(identifier: "WebViewController") as? WebViewController else {
            return
        }
        let item = savedItems[indexPath.row]
        vc.urlString = item.url!
        
        
 //       present(vc, animated: true, completion: nil)
        navigationController?.pushViewController(vc, animated: true)
    }
}
