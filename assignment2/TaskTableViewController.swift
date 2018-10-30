//
//  TaskTableViewController.swift
//  assignment2
//
//  Created by Abhishekkumar Israni on 2018-10-26.
//  Copyright © 2018 Abhishekkumar Israni. All rights reserved.
//

import UIKit
import os.log

class TaskTableViewController: UITableViewController {
    
    
    //MARK: Properties
    
    var tasks = [Task]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Use the edit button item provided by the table view controller.
        navigationItem.leftBarButtonItem = editButtonItem
        
        // Load any saved meals, otherwise load sample data.
        if let savedTasks = loadTasks() {
            tasks += savedTasks
        }
        else {
            // Load the sample data.
            loadSampleTasks()
        }
        
        
       
     
    }

   
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
       
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tasks.count
    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "tasksViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)as? tasksViewCell  else {
            fatalError("The dequeued cell is not an instance of tasksViewCell.")
        }
        
        // Fetches the appropriate meal for the data source layout.
         let task = tasks[indexPath.row]

        cell.nameLabel.text = task.name
        if task.thumbnail != nil {
          cell.taskImageInCell.image = task.thumbnail
        }
        if task.priority == 0 {
        //cell.priorityLabel.text = String(task.priority)
        
        cell.priorityLabel.text = "!"
            cell.priorityLabel.textColor = UIColor.green
        }
        else if task.priority == 1{
            
            cell.priorityLabel.text = "!!"
            cell.priorityLabel.textColor = UIColor.orange
        }
        else if task.priority == 2
        {
            cell.priorityLabel.text = "!!!"
            cell.priorityLabel.highlightedTextColor = UIColor.red
            cell.priorityLabel.textColor = UIColor.red
        }
            
        cell.dateLabel.text = task.priorityDate
        
        return cell
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

   
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tasks.remove(at: indexPath.row)
            saveTasks()
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
 

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        super.prepare(for: segue, sender: sender)
        
        switch(segue.identifier ?? "") {
        case "AddTask":
            os_log("Adding a new meal.", log: .default, type: .debug)
            
        case "ShowDetail":
            guard let taskDetailViewController = segue.destination as? TaskViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            guard let selectedTaskCell = sender as? tasksViewCell else {
                fatalError("Unexpected sender: \(sender)")
            }
            
            guard let indexPath = tableView.indexPath(for: selectedTaskCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            
            let selectedTask = tasks[indexPath.row]
            taskDetailViewController.task = selectedTask
            
            
        default:
            fatalError("Unexpected Segue Identifier; \(String(describing: segue.identifier))")
        }
        
    }
   

    
    
    //MARK: Private Methods
    
    private func loadSampleTasks() {
        let photo1 = UIImage(named: "photo1")
        let photo2 = UIImage(named: "photo2")
        let photo3 = UIImage(named: "photo3")
        
        guard let task1 = Task(name: "PAY EB", photo: photo1, priority: 1, priorityDate:"27/10/2018") else {
            fatalError("Unable to instantiate meal1")
        }
        
        guard let task2 = Task(name: "meet nilay", photo: photo2, priority: 2 , priorityDate:"27/10/2018") else {
            fatalError("Unable to instantiate meal2")
        }
        
        guard let task3 = Task(name: "paybill", photo: photo3, priority: 3 , priorityDate:"27/10/2018" ) else {
            fatalError("Unable to instantiate meal2")
        }
        tasks += [task1, task2, task3]
    }

    
    //MARK Actions for adding new tasks to the table view cell
    
    @IBAction func unwindToTaskList(sender: UIStoryboardSegue) {
        
        if let sourceViewController = sender.source as? TaskViewController, let task = sourceViewController.task {
            
            
             if let selectedIndexPath = tableView.indexPathForSelectedRow {
                // Update an existing task
                tasks[selectedIndexPath.row] = task
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            }
             else {
                // Add a new meal.
                let newIndexPath = IndexPath(row: tasks.count, section: 0)
                
                tasks.append(task)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
                
           saveTasks()
        }
     }
    
    private func saveTasks() {
        
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(tasks, toFile: Task.ArchiveURL.path)
       
        if isSuccessfulSave {
            os_log("Meals successfully saved.", log: OSLog.default, type: .debug)
        } else {
            os_log("Failed to save meals...", log: OSLog.default, type: .error)
        }
    }
    
    private func loadTasks() -> [Task]? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: Task.ArchiveURL.path) as? [Task]
    }
    
}
