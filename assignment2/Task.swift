//
//  File.swift
//  assignment2
//
//  Created by Abhishekkumar Israni on 2018-10-26.
//  Copyright © 2018 Abhishekkumar Israni. All rights reserved.
//

import UIKit
import os.log
class Task: NSObject, NSCoding {
    
    
    
    
    //MARK: Properties
    
    var name: String
    var photo: UIImage?
    var priority: Int
    var priorityDate : String
    var textDescription : String?
    //MARK: - Archiving Paths
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("tasks")
    
    //MARK: - Types -
    
    struct PropertyKey {
        
         static let name = "name"
         static let photo = "photo"
         static let priority = "priority"
         static let  priorityDate = "priorityDate"
        
        static let textDescription = "textDescription"
    }
    
    
    //MARK Initialisers
    //MARK: Initialization
    
    init?(name: String, photo: UIImage?, priority: Int , priorityDate: String, textDescription: String? = nil) {
       
        // Initialization should fail if there is no name or if the rating is negative.
        if name.isEmpty   {
            return nil
        }
        // Initialize stored properties.
        self.name = name
        self.photo = photo
        self.priority = priority
        self.priorityDate = priorityDate
        self.textDescription = textDescription
    }
    
    //MARK: -  NSCoding
    func encode(with aCoder: NSCoder) {
        
        aCoder.encode(name, forKey: PropertyKey.name)
        aCoder.encode(photo, forKey: PropertyKey.photo)
        aCoder.encode(priority, forKey: PropertyKey.priority)
        aCoder.encode(priorityDate, forKey: PropertyKey.priorityDate)
        aCoder.encode(textDescription, forKey: PropertyKey.textDescription)
    }
    
    
    required convenience init?(coder aDecoder: NSCoder) {
        // The name is required. If we cannot decode a name string, the initializer should fail.
            guard let Name = aDecoder.decodeObject(forKey: PropertyKey.name) as? String else {
            os_log("Unable to decode the name for a task object.", log: OSLog.default, type: .debug)
            return nil
            }
            // Because photo is an optional property of Meal, just use conditional cast.
            let photo = aDecoder.decodeObject(forKey: PropertyKey.photo) as? UIImage
        
        
            let priority = aDecoder.decodeInteger(forKey: PropertyKey.priority) as Int
        
            let priorityDate = aDecoder.decodeObject(forKey: PropertyKey.priorityDate) as? String
            let TextDescription = aDecoder.decodeObject(forKey: PropertyKey.textDescription) as? String
            // Must call designated initializer.
        self.init(name: Name, photo: photo, priority: priority ,priorityDate : priorityDate!, textDescription: TextDescription)
    }
    

}
