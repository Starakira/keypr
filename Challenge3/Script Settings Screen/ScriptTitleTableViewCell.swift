//
//  ScriptTitleTableViewCell.swift
//  Challenge3
//
//  Created by Muhammad Bangun Agung on 02/06/20.
//  Copyright © 2020 joahan wirasugianto. All rights reserved.
//

import UIKit

class ScriptTitleTableViewCell: UITableViewCell, UITextFieldDelegate {
    @IBOutlet weak var tField: UITextField!
    @IBOutlet weak var tLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.tField.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == tField {
            tLabel.text = tField.text
            textField.resignFirstResponder()
            return false
        }
        
        return true
    }
}
