//
//  tasksViewCell.swift
//  assignment2
//
//  Created by Abhishekkumar Israni on 2018-10-26.
//  Copyright © 2018 Abhishekkumar Israni. All rights reserved.
//

import UIKit

class tasksViewCell: UITableViewCell {

    //MARK: Properties
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var priorityLabel: UILabel!
    
    @IBOutlet weak var taskImageInCell: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
