//
//  ScriptTableViewCell.swift
//  Challenge3
//
//  Created by Muhammad Bangun Agung on 25/05/20.
//  Copyright © 2020 joahan wirasugianto. All rights reserved.
//

import UIKit

class ScriptTableViewCell: UITableViewCell {

    @IBOutlet weak var scriptImageView: UIImageView!
    @IBOutlet weak var scriptTitleLabel: UILabel!
    @IBOutlet weak var scriptDateLabel: UILabel!
    
    
    func setScript(script: Script) {
        scriptImageView.image = script.image
        scriptTitleLabel.text = script.title
        scriptDateLabel.text = script.date
    }
}
