//
//  ScriptSettingsViewController.swift
//  Challenge3
//
//  Created by Muhammad Bangun Agung on 02/06/20.
//  Copyright © 2020 joahan wirasugianto. All rights reserved.
//

import UIKit

class ScriptSettingsViewController: UIViewController {
    @IBOutlet weak var titleTableView: UITableView!
    @IBOutlet weak var timeTableView: UITableView!
    @IBOutlet weak var scriptUploadTableView: UITableView!
    @IBOutlet weak var scriptSectionTableView: UITableView!
    @IBOutlet weak var scriptDeleteTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleTableView.dataSource = self
        titleTableView.delegate = self
        
        timeTableView.dataSource = self
        timeTableView.delegate = self
        
        scriptUploadTableView.dataSource = self
        scriptUploadTableView.delegate = self
        
        scriptSectionTableView.dataSource = self
        scriptSectionTableView.delegate = self
        
        scriptDeleteTableView.dataSource = self
        scriptDeleteTableView.delegate = self
    }
    
    @IBAction func scriptSettingsCancelButtonAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func scriptSettingsSaveButtonAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}

extension ScriptSettingsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if (tableView == titleTableView) {
            let cell = titleTableView.dequeueReusableCell(withIdentifier: "Script Title Cell") as! ScriptTitleTableViewCell
            
            return cell
        } else if (tableView == timeTableView) {
            let cell = timeTableView.dequeueReusableCell(withIdentifier: "Script Time Cell") as! ScriptTimeTableViewCell
            
            cell.timePicker.reloadAllComponents()
            
            return cell
        } else if (tableView == scriptUploadTableView) {
            let cell = scriptUploadTableView.dequeueReusableCell(withIdentifier: "Script Upload Cell") as! ScriptUploadTableViewCell
            
            return cell
        } else if (tableView == scriptSectionTableView) {
            let cell = scriptSectionTableView.dequeueReusableCell(withIdentifier: "Script Section Cell") as! ScriptSectionTableViewCell
            
            return cell
        } else {
            let cell = scriptDeleteTableView.dequeueReusableCell(withIdentifier: "Script Delete Cell") as! ScriptDeleteTableViewCell
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (tableView == scriptSectionTableView){
            performSegue(withIdentifier: "Expand Section", sender: self)
        }
    }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        if (tableView == scriptSectionTableView) {
            return true
        } else {
            return false
        }
    }
}
