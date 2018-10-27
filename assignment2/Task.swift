//
//  File.swift
//  assignment2
//
//  Created by Abhishekkumar Israni on 2018-10-26.
//  Copyright © 2018 Abhishekkumar Israni. All rights reserved.
//

import UIKit
class Task {
    
    //MARK: Properties
    
    var name: String
    var photo: UIImage?
    var priority: Int
    var priorityDate : String
    
    //MARK Initialisers
    //MARK: Initialization
    
    init?(name: String, photo: UIImage?, priority: Int , priorityDate: String) {
       
        // Initialization should fail if there is no name or if the rating is negative.
        if name.isEmpty   {
            return nil
        }
        // Initialize stored properties.
        self.name = name
        self.photo = photo
        self.priority = priority
        self.priorityDate = priorityDate
    }
}
