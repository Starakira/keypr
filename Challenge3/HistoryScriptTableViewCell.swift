//
//  HistoryScriptTableViewCell.swift
//  Challenge3
//
//  Created by Muhammad Bangun Agung on 27/05/20.
//  Copyright © 2020 joahan wirasugianto. All rights reserved.
//

import UIKit

class HistoryScriptTableViewCell: UITableViewCell {
    @IBOutlet weak var historyScriptImageView: UIImageView!
    @IBOutlet weak var historyScriptTitleLabel: UILabel!
    @IBOutlet weak var historyScriptDateLabel: UILabel!
    
    func setHistoryScript(script: Script) {
        historyScriptImageView.image = script.image
        historyScriptTitleLabel.text = script.title
        historyScriptDateLabel.text = script.date
    }
}
