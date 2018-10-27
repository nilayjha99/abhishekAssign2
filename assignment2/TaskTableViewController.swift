//
//  TaskTableViewController.swift
//  assignment2
//
//  Created by Abhishekkumar Israni on 2018-10-26.
//  Copyright © 2018 Abhishekkumar Israni. All rights reserved.
//

import UIKit

class TaskTableViewController: UITableViewController {
    
    
    //MARK: Properties
    
    var tasks = [Task]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Load the sample data.
        loadSampleTasks()
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
            fatalError("The dequeued cell is not an instance of MealTableViewCell.")
        }
        
        // Fetches the appropriate meal for the data source layout.
         let task = tasks[indexPath.row]

        cell.nameLabel.text = task.name
        cell.taskImage.image = task.photo
        cell.priorityLabel.text = task.priority
        cell.dateLabel.text = task.priorityDate
        
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    
    
    //MARK: Private Methods
    
    private func loadSampleTasks() {
        let photo1 = UIImage(named: "photo1")
        let photo2 = UIImage(named: "photo2")
        let photo3 = UIImage(named: "photo3")
        
        guard let task1 = Task(name: "high", photo: photo1, priority: "!", priorityDate:"27/10/2018") else {
            fatalError("Unable to instantiate meal1")
        }
        
        guard let task2 = Task(name: "meet nilay", photo: photo2, priority: "!!!" , priorityDate:"27/10/2018") else {
            fatalError("Unable to instantiate meal2")
        }
        
        guard let task3 = Task(name: "paybill", photo: photo3, priority: "!!" , priorityDate:"27/10/2018" ) else {
            fatalError("Unable to instantiate meal2")
        }
        tasks += [task1, task2, task3]
    }

}
