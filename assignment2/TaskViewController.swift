//
//  ViewController.swift
//  assignment2
//
//  Created by Abhishekkumar Israni on 2018-10-24.
//  Copyright © 2018 Abhishekkumar Israni. All rights reserved.
//
import os.log
import UIKit

class TaskViewController: UIViewController, UIImagePickerControllerDelegate , UITextFieldDelegate , UINavigationControllerDelegate , UITextViewDelegate, UIScrollViewDelegate {
    
    
    
    @IBOutlet weak var cancelEditing: UIBarButtonItem!
    @IBOutlet weak var prioritySegment: UISegmentedControl!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var datePickerTF: UITextField!
    
    @IBOutlet weak var taskImage: UIImageView!
  
    @IBOutlet weak var selectImage: UIButton!
    @IBOutlet weak var taskDescriptionHere: UITextView!
    //Scroll View
   // @IBOutlet weak var scrollView: UIScrollView!
    
    //@IBOutlet weak var imageView: UIImageView!
    
    
    var task : Task?
    var imageView = UIImageView()
    

    
    //Properties
    let datePicker=UIDatePicker()
    
    @IBOutlet weak var taskTextField: UITextField!
    
    @IBOutlet weak var imsgeScrollView: UIScrollView!
    
    
    
    // Using segmented control for selecting priority
    @IBOutlet weak var mySegmentedControl: UISegmentedControl!
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        self.centreScrollViewContents()
    }

    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.imageView
    }

    func displayImageInsideScrollView(image: UIImage? = nil) {

        var setImage : UIImage?
        self.imsgeScrollView.isHidden = false
        if self.task != nil {
            if image != nil {
                setImage = image
            } else if (self.task?.photo != nil) {
                setImage = self.task?.photo
                self.taskImage.isHidden = true
            } else {
                self.imsgeScrollView.isHidden = true
                return
            }
        } else {
            if image != nil {
                 self.taskImage.isHidden = true
                setImage = image
            } else {
                self.imsgeScrollView.isHidden = true
                return
            }
        }
      

        self.imageView.image = setImage
        self.imageView.contentMode = .center
        
        self.imageView.frame = CGRect(x: 0, y: 0,
                                      width: (setImage!.size.width),
                                      height: (setImage!.size.height))
        
        
        self.imageView.isUserInteractionEnabled = true
        self.imsgeScrollView.contentSize = (setImage!.size)
        
        let scrollViewFrame = self.imsgeScrollView.frame
        let scaledWidth = scrollViewFrame.size.width / self.imsgeScrollView.contentSize.width
        let scaledHeight = scrollViewFrame.size.width / self.imsgeScrollView.contentSize.width
        let minScale = min(scaledHeight, scaledWidth)
        
        self.imsgeScrollView.minimumZoomScale = minScale
        self.imsgeScrollView.maximumZoomScale = 1
        self.imsgeScrollView.zoomScale = minScale
        
        self.imsgeScrollView.addSubview(self.imageView)

    }
    
    func centreScrollViewContents() {
        let boundSize = self.imsgeScrollView.bounds.size
        var contentsFrame = self.imageView.frame
        
        if contentsFrame.size.width < boundSize.width {
            contentsFrame.origin.x = (boundSize.width - contentsFrame.size.width) / 2
        } else {
            contentsFrame.origin.x = 0
        }
        
        if contentsFrame.size.height < boundSize.height {
            contentsFrame.origin.y = (boundSize.height - contentsFrame.size.height) / 2
        } else {
            contentsFrame.origin.y = 0
        }
        self.imageView.frame = contentsFrame
    }

    func saveAndCropImage() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(self.imsgeScrollView.bounds.size, true, UIScreen.main.scale)
        let offset = self.imsgeScrollView.contentOffset
        guard let context = UIGraphicsGetCurrentContext() else {
            fatalError("ss")
        }
        context.translateBy(x: -offset.x, y: -offset.y)
        self.imsgeScrollView.layer.render(in: context)
        let screenshot = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return screenshot
//        self.task?.updateThumbnail(thumbnail: screenshot, frameOffset: self.imageView.frame, zoomLevel: self.imageScrollView!.zoomScale)
      
    }

    
    //Navigation
    
    // This method lets you configure a view controller before it's presented.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        // Configure the destination view controller only when the save button is pressed.
        
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
            
            }
        let name = taskTextField.text ?? ""
        let photo = (self.imageView.image == nil) ? nil : self.imageView.image
        let priority = prioritySegment.selectedSegmentIndex
        let date = datePickerTF.text ?? ""
        let notes = taskDescriptionHere.text ?? ""
        let thumbnail = (task != nil) ? ((task!.photo != nil) ? saveAndCropImage() : nil) : nil
        task = Task(name: name, photo: photo, priority: priority , priorityDate: date, textDescription: notes, thumbnail: thumbnail)
    }
    
    
    //Actions
        override func viewDidLoad() {
        super.viewDidLoad()
        
            // Enable the Save button only if the text field has a valid Meal name.
            updateSaveButtonState()
                
       //Handle the text field’s user input through delegate callbacks.
        taskTextField.delegate = self
        imsgeScrollView.delegate = self
            // editing existing meals
            
            if let task = task {
                navigationItem.title = task.name
                self.saveButton.isEnabled = true
                taskTextField.text = task.name
                if (task.photo != nil) {
                    taskImage.image = task.photo
                }
                prioritySegment.selectedSegmentIndex = task.priority
                datePickerTF.text = (task.priorityDate != "") ? task.priorityDate : "Unspecified"
                taskDescriptionHere.text = (task.textDescription != nil) ? task.textDescription : ""
                print(task.priorityDate)
                displayImageInsideScrollView()
            } else {
                datePickerTF.text = "Unspecified"
                displayImageInsideScrollView()
            }
        
            //function call here
        createDatePicker()
    }
    
    @IBAction func chooseTaskImage(_ sender: UIButton) {
        // image controller
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        
        // build action sheet
        let imageActionSheet = UIAlertController(title: "Photo Source", message: "choose a source.", preferredStyle: .actionSheet)
        
        let cameraAction = UIAlertAction(title: "Camera", style: .default, handler: { (action: UIAlertAction) in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                imagePickerController.sourceType = .camera
                self.present(imagePickerController, animated: true, completion: nil)
            } else {
                print("no camera")
            }
        })
        
        imageActionSheet.addAction(cameraAction)
        
        let galleryAction = UIAlertAction(title: "Photo Gallery", style: .default, handler: { (action: UIAlertAction) in
            imagePickerController.sourceType = .photoLibrary
            self.present(imagePickerController, animated: true, completion: nil)
            
        })
        
        imageActionSheet.addAction(galleryAction)
        
        let cancelActon = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        
        imageActionSheet.addAction(cancelActon)
        
        present(imageActionSheet, animated: true)

    }
    
    //MARK: - UIImagePickerControllerDelegate -
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // if cancel is pressed from image picker
        // then return to current view closing photo library
        // Dismiss the picker if the user canceled.
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: - UIImagePickerControllerDelegate -
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        // if user selects an image process the input
        // The info dictionary may contain multiple representations of the image. You want to use the original.
        guard let chosenImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        
        
        // Set photoImageView to display the selected image.
        self.displayImageInsideScrollView(image: chosenImage)
        
        // Dismiss the picker.
        dismiss(animated: true, completion: nil)
    }
    

    //will popup date picker when text field is tapped
    func createDatePicker(){
        
        //Formatting the display
        datePicker.datePickerMode = .dateAndTime
        
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
        dateFormatter.dateStyle = .short
         dateFormatter.timeStyle = .short
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
    
    
  
    @IBAction func cancelEditingWhenTapped(_ sender: UIBarButtonItem) {
        
        
        let isPresentingInAddTaskMode = presentingViewController is UINavigationController
        
        if isPresentingInAddTaskMode {
            dismiss(animated: true, completion: nil)
        }
        else if let owningNavigationController = navigationController{
            owningNavigationController.popViewController(animated: true)
        }
        else {
            fatalError("The TaskViewVController is not inside a navigation controller.")
        }
    }
    
    
    
    //MARK: - Image part edititng
    
    @IBAction func selectIImageOrCameraRoll(_ sender: UITapGestureRecognizer) {
        
        // Hide the keyboard.
        taskTextField.resignFirstResponder()
        
        // UIImagePickerController is a view controller that lets a user pick media from their photo library.
        let imagePickerController = UIImagePickerController()
        
        // Only allow photos to be picked, not taken.
       // imagePickerController.sourceType = .photoLibrary
   
        imagePickerController.sourceType = UIImagePickerController.SourceType.photoLibrary
        
//        imagePickerController.sourceType = UIImagePickerController.SourceType.camera
    }
    
   // End keyboard when nothing to write in text view
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan( touches , with: event)
       // self.view.endEditing(true)
        self.taskDescriptionHere.resignFirstResponder()
    }
    
}

