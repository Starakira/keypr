//
//  TableViewCell.swift
//  createOutline
//
//  Created by wienona martha parlina on 30/05/20.
//  Copyright © 2020 wienona martha parlina. All rights reserved.
//

import UIKit

class SectionTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cevronCell: UIImageView!
    @IBOutlet weak var subtitleCell: UILabel!
    @IBOutlet weak var titleCell: UILabel!
    @IBOutlet weak var iconCell: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
