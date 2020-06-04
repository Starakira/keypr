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
    
    var scriptTitle: String = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.tField.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == tField {
            
            textField.resignFirstResponder()
            return false
        }
        
        func setTitle(title: String) {
            scriptTitle = title
        }
        
        return true
    }
}
