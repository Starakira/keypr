//
//  scriptSettingTableViewCell.swift
//  challenge3_scriptSettings
//
//  Created by Angelica Irene Christina on 26/05/20.
//  Copyright © 2020 Angelica Irene Christina. All rights reserved.
//

import UIKit
//
//protocol TextFieldInTableViewCellDelegate: class {
//    func textField(editingDidBeginIn cell:scriptSettingTableViewCell)
//    func textField(editingChangedInTextField newText: String, in cell: scriptSettingTableViewCell)
//}

class scriptSettingTableViewCell: UITableViewCell, UITextViewDelegate, UITextFieldDelegate {
    
    var indexPath:IndexPath = IndexPath.init(row: 0, section: 0)
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var titleTextField: UITextField!

    func textField (text: String?, placeholder: String) {
        titleTextField.text = text
        titleTextField.placeholder = placeholder
        titleTextField.delegate = self
        titleTextField.clearsOnBeginEditing = false
        titleTextField.autocorrectionType = UITextAutocorrectionType.no
        titleTextField.autocapitalizationType = UITextAutocapitalizationType.sentences
        titleTextField.accessibilityValue = text
        titleTextField.accessibilityLabel = placeholder
        titleTextField.adjustsFontSizeToFitWidth = true
        titleTextField.isUserInteractionEnabled = true
        
    }


    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var timePicker: UIPickerView!
    @IBOutlet weak var hourLabel: UILabel!
    @IBOutlet weak var minLabel: UILabel!
    @IBOutlet weak var secLabel: UILabel!
    
//    var hoursArray = [NSMutableArray].self
//
//    hoursArray = [[NSMutableArray alloc] init]
//
//    var timePickerVisible:Bool?
//    var timePickerHidden:Bool?
//
//    var dateLabelChanged:UIColor!
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        DispatchQueue.main.async {
//            self.titleTextField.becomeFirstResponder()
//        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }


}
