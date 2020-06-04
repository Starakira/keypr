//
//  ScriptTimeTableViewCell.swift
//  Challenge3
//
//  Created by Muhammad Bangun Agung on 02/06/20.
//  Copyright © 2020 joahan wirasugianto. All rights reserved.
//

import UIKit

class ScriptTimeTableViewCell: UITableViewCell {
    @IBOutlet weak var timePicker: UIPickerView!
    @IBOutlet weak var scriptTimeLabel: UILabel!
    
    var hour: [Int] = []
    var min: [Int] = []
    var sec: [Int] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.createTimeArray()
        
        self.timePicker.delegate = self
        self.timePicker.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    func createTimeArray() {
        for n in 0...23 {
            hour.append(n+1)
        }
        
        for n in 0...59 {
            min.append(n+1)
        }
        
        for n in 0...59 {
            sec.append(n+1)
        }
    }
}

extension ScriptTimeTableViewCell: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return hour.count
        } else if component == 1 {
            return min.count
        } else {
            return sec.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return String(hour[row])
        } else if component == 1 {
            return String(min[row])
        } else {
            return String(sec[row])
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        let selectedHour = timePicker.selectedRow(inComponent: 0) + 1
        let selectedMinute = timePicker.selectedRow(inComponent: 1) + 1
        let selectedSecond = timePicker.selectedRow(inComponent: 2) + 1
        
        scriptTimeLabel.text = "\(selectedHour) H \(selectedMinute) M \(selectedSecond) S"
    }
}
