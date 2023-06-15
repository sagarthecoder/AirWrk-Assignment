//
//  TableViewCell.swift
//  AirWrk-Assignment
//
//  Created by Sagar on 6/16/23.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var searchtextTabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
