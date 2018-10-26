//
//  ViewController.swift
//  assignment2
//
//  Created by Abhishekkumar Israni on 2018-10-24.
//  Copyright © 2018 Abhishekkumar Israni. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIScrollViewDelegate {
    
    
    
    @IBOutlet weak var datePickerTF: UITextField!
    
    //Scroll View
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var imageView: UIImageView!
    
    
    //Properties
    let datePicker=UIDatePicker()
    

    //Actions
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
       //Zoom Levels
        self.scrollView.minimumZoomScale = 1.0
        self.scrollView.maximumZoomScale = 6.0
        
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
    
    
    func viewForZoomingScrollView(scrollView:UIScrollView)->UIView?
    {
        
        
        return self.imageView
    }
    
    
    
}

