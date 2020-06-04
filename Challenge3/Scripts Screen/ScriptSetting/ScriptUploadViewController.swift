//
//  ScriptUploadViewController.swift
//  Challenge3
//
//  Created by richard santoso on 05/06/20.
//  Copyright © 2020 joahan wirasugianto. All rights reserved.
//

import UIKit

class ScriptUploadViewController: UIViewController, UITextViewDelegate {
    @IBOutlet weak var scriptField: UITextView!
     var scriptText = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.scriptField.delegate = self
        // Do any additional setup after loading the view.
    }
    @IBAction func saveButton(_ sender: Any) {
    scriptText = scriptField.text
    let vc = storyboard?.instantiateViewController(identifier: "scriptSettings") as! ScriptSettingsViewController
     vc.savedScriptText = scriptText
     //self.navigationController?.popViewController(animated: true)
     self.navigationController?.pushViewController(vc, animated: true)
     //label.text = scriptText
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
