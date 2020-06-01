//
//  addScriptViewController.swift
//  challenge3_scriptSettings
//
//  Created by Angelica Irene Christina on 27/05/20.
//  Copyright © 2020 Angelica Irene Christina. All rights reserved.
//

import UIKit

class addScriptViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate {
    

    @IBOutlet weak var saveScriptButton: UIBarButtonItem!
    @IBOutlet weak var cancelScriptButton: UIBarButtonItem!
    @IBOutlet weak var titleTableView: UITableView!
    @IBOutlet weak var timeTableView: UITableView!
    
    
    @IBAction func cancelScriptButton(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
    var activeTextField: UITextField? = nil
    var hour:Int = 0
    var minutes:Int = 0
    var seconds:Int = 0
    
    let pickOut = scriptSettingTableViewCell()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        titleTableView.dataSource = self
        titleTableView.delegate = self

        timeTableView.dataSource = self
        timeTableView.delegate = self
        timeTableView.reloadData()
        
    }
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        pickOut.timePicker.isHidden = true
//        pickOut.timePicker.isHidden = false
//        pickOut.timePicker.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    var sections:Int?
    func numberOfSections(in tableView: UITableView) -> Int {
        if tableView == self.titleTableView {
            sections = 1
        }
        if tableView == self.timeTableView {
            sections = 2
        }
        return sections!
    }
    
    var rowCount:Int?
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.titleTableView {
            rowCount = 1
            }
        if tableView == self.timeTableView {
            switch section {
            case 0:
                rowCount = 1
            case 1:
                rowCount = 1
            default:
                fatalError()
            }
        }
        return rowCount!
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return 3
     }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            switch component {
             case 0:
                 return 25
             case 1, 2:
                 return 60
             default:
                 return 0
            }
         }

    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
             return pickerView.frame.size.width/3
        }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
             switch component {
             case 0:
                hour = row
                print(hour)
                return "\(row) hour"
             case 1:
                minutes = row
                return "\(row) min"
             case 2:
                seconds = row
                return "\(row) sec"
             default:
                return ""
             }
         }
  
    let label = UILabel()
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int,  reusing view: UIPickerView?) -> UIView {
        label.text = String(row)
        label.textAlignment = .center
        switch component {
        case 0:
            hour = row
            label.text = String(row) + " hours"
        case 1:
            minutes = row
            label.text = String(row) + " min"
        case 2:
            seconds = row
            label.text = String(row) + " sec"
        default:
            break
        }
//        switch component {
//             case 0:
//                 hour = row
//             case 1:
//                 minutes = row
//             case 2:
//                 seconds = row
//             default:
//                 break;
//            }
        return label
        }

    let cell: UITableViewCell = scriptSettingTableViewCell.init()
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == self.titleTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Title Cell", for: indexPath) as! scriptSettingTableViewCell
            cell.textField(text: "", placeholder: "Script Rehearsal")
//            cell.titleTextField.delegate = self
            return cell
        }
        if tableView == self.timeTableView {
            switch indexPath.section {
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: "Time View", for: indexPath) as!scriptSettingTableViewCell
                cell.timeLabel.text = "\(hour) Hour \(minutes) Minutes \(seconds) Seconds"
                return cell
            case 1:
                let cell = tableView.dequeueReusableCell(withIdentifier: "Time Picker", for: indexPath) as! scriptSettingTableViewCell
                cell.timePicker.dataSource = self
                cell.timePicker.delegate = self
//                cell.timePicker.isHidden = true
                return cell
            default:
                fatalError()
                }
            }
        return cell
        }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        self.activeTextField = textField
        return true
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        self.activeTextField = nil
    }
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        if indexPath.section == 0 && indexPath.row == 3 {
//            let height:CGFloat = timerPick.timePicker.isHidden ? 0.0 : 216.0
//            return height
//        }
//        return super[tableView, heightForRowAtIndexPath: indexPath]
//    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if tableView == titleTableView {
//        }
//        if tableView == timeTableView {
//            switch indexPath.row {
//            case 0:
//                
//            }
//        }
//       
//        print("did select:      \(indexPath.row)    ")
//    }
    


    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
}
