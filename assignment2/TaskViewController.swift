//
//  ViewController.swift
//  assignment2
//
//  Created by Abhishekkumar Israni on 2018-10-24.
//  Copyright © 2018 Abhishekkumar Israni. All rights reserved.
//
import os.log
import UIKit

class TaskViewController: UIViewController, UITextFieldDelegate , UINavigationControllerDelegate {
    
    
    
    @IBOutlet weak var prioritySegment: UISegmentedControl!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var datePickerTF: UITextField!
    
    @IBOutlet weak var taskImage: UIImageView!
  
    //Scroll View
   // @IBOutlet weak var scrollView: UIScrollView!
    
    //@IBOutlet weak var imageView: UIImageView!
    
    /*
     This value is either passed by `MealTableViewController` in `prepare(for:sender:)`
     or constructed as part of adding a new meal.
     */
    var task : Task?
    
    
    
    //Properties
    let datePicker=UIDatePicker()
    
    
    @IBOutlet weak var taskTextField: UITextField!
    
    
    
    
    // Using segmented control for selecting priority
    @IBOutlet weak var mySegmentedControl: UISegmentedControl!
    
    
    
    //Navigation
    
    // This method lets you configure a view controller before it's presented.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        // Configure the destination view controller only when the save button is pressed.
        
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
            
            }
        let name = taskTextField.text ?? ""
        let photo = taskImage.image
        let priority = prioritySegment.selectedSegmentIndex
        let date = datePickerTF.text ?? ""
    
        task = Task(name: name, photo: photo, priority: priority , priorityDate: date)
    
    }
    
    
    //Actions
        override func viewDidLoad() {
        super.viewDidLoad()
        
            // Enable the Save button only if the text field has a valid Meal name.
            updateSaveButtonState()
                
       //Handle the text field’s user input through delegate callbacks.
        taskTextField.delegate = self
        
        //function call here
        createDatePicker()
    }
    
    //will popup date picker when text field is tapped
    func createDatePicker(){
        
        //Formatting the display
        datePicker.datePickerMode = .date
        
        //assigning date picker to textfied
        datePickerTF.inputView=datePicker
    
    
    // creating a tool bar
        let toolBar=UIToolbar()
        toolBar.sizeToFit()
        
    //adding a "done" button on the tool bar
        
        let doneButton=UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneClicked))
        
        let immediateButton = UIBarButtonItem(title: "Immediate", style: .done, target: nil, action: #selector(setTextFieldImmediate))
        
        let UnSpecified = UIBarButtonItem(title: "Unspecified", style: .done, target: nil, action: #selector(unSpecified))
        
        toolBar.setItems([doneButton,immediateButton,UnSpecified], animated: true)
        
        datePickerTF.inputAccessoryView = toolBar
    }
    
    // for assigning value to the text field when "done" pressed
    @objc func doneClicked(){
        
        //format of the display
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
         dateFormatter.timeStyle = .medium
        datePickerTF.text = dateFormatter.string(from: datePicker.date)
        self.view.endEditing(true)
        
    }
    
    // sets value of the text field as Immediate
    @objc func setTextFieldImmediate()
    {
        datePickerTF.text = "Immediate"
        self.view.endEditing(true)
        
    }
    
    
    // Selects value of the text Field as Unspecified
    @objc func unSpecified()
    {
        datePickerTF.text = "Unspecified"
        self.view.endEditing(true)
    }
    
    
    /*func viewForZoomingScrollView(scrollView:UIScrollView)->UIView?
    {
        
        
        return self.imageView
    }
    */
    
    
    //MARK: - Private Methods : Actions for text field edititing methods
    
    
    private func updateSaveButtonState() {
        // Disable the Save button if the text field is empty.
        let text = taskTextField.text ?? ""
        saveButton.isEnabled = !text.isEmpty
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // Disable the Save button while editing.
        saveButton.isEnabled = false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Hide the keyboard.
        textField.resignFirstResponder()
        return true
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
      taskTextField.text = textField.text
        updateSaveButtonState()
        navigationItem.title = textField.text
        
        
    }
    
    
    //MARK: - Segmented button tapped
    
    @IBAction func choosePriotity(_ sender: UISegmentedControl) {
        
        
        
        
        print("# of Segments = \(sender.numberOfSegments)")
        
        switch sender.selectedSegmentIndex {
        case 0:
            print("first segement clicked")
        case 1:
            print("second segment clicked")
        case 2:
            print("third segemnet clicked")
        default:
            break;
        }  //Switch
        
    }
    
    
  
    
    
    
}
