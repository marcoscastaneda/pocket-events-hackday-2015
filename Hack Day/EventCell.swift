//
//  EventCell.swift
//  Hack Day
//
//  Created by Marcos Castaneda on 7/15/15.
//  Copyright (c) 2015 State Farm. All rights reserved.
//

import UIKit

class EventCell: UITableViewCell {

    @IBOutlet weak var labelEventTitle: UILabel!
    @IBOutlet weak var labelEventTime: UILabel!
    @IBOutlet weak var labelEventCategory: UILabel!
    @IBOutlet weak var labelEventCount: UILabel!
    @IBOutlet weak var imageViewEvent: UIImageView!
    @IBOutlet weak var labelEventVenue: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
