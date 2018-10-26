//
//  PrioritySelector.swift
//  assignment2
//
//  Created by Abhishekkumar Israni on 2018-10-24.
//  Copyright © 2018 Abhishekkumar Israni. All rights reserved.
//

import UIKit

class PrioritySelector: UIStackView {

    //MARK Instialisation
    
    override init(frame: CGRect) {
         super.init(frame : frame)
        setupPriorityButtons()
    }
    
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupPriorityButtons()
    }
    
    
    //MARK Private Methods
    
    private func setupPriorityButtons() {
        
        
        //define red(high) priority button
//        let priorityButton1=UIButton()
//        priorityButton1.backgroundColor = UIColor.red
//        priorityButton1.translatesAutoresizingMaskIntoConstraints = false
//        priorityButton1.heightAnchor.constraint(equalToConstant: 15.0).isActive = true
//        priorityButton1.widthAnchor.constraint(equalToConstant: 15.0).isActive = true
//        // Add the button to the stack
//        addArrangedSubview(priorityButton1)
//
        /*
       ////define orange(medium) priority button
        let priorityButton2=UIButton()
        priorityButton2.backgroundColor = UIColor.orange
        priorityButton2.backgroundColor = UIColor.red
        priorityButton2.translatesAutoresizingMaskIntoConstraints = false
        priorityButton2.heightAnchor.constraint(equalToConstant: 44.0).isActive = true
        priorityButton2.widthAnchor.constraint(equalToConstant: 44.0).isActive = true
        addArrangedSubview(priorityButton2)
        
        //define green(low) priority button
        let priorityButton3=UIButton()
        priorityButton3.backgroundColor = UIColor.green
        priorityButton3.backgroundColor = UIColor.red
        priorityButton3.translatesAutoresizingMaskIntoConstraints = false
        priorityButton3.heightAnchor.constraint(equalToConstant: 44.0).isActive = true
        priorityButton3.widthAnchor.constraint(equalToConstant: 44.0).isActive = true
        addArrangedSubview(priorityButton3)
    */
    
    
    }
    
    
}
