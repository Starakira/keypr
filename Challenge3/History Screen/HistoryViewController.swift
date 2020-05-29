//
//  HistoryViewController.swift
//  Challenge3
//
//  Created by Muhammad Bangun Agung on 27/05/20.
//  Copyright © 2020 joahan wirasugianto. All rights reserved.
//

import UIKit

var historyScripts: [Script] = []

class HistoryViewController: UIViewController {
    @IBOutlet weak var historyTableView: UITableView!
    
    var selectedIndex = Int()
        
        override func viewDidLoad() {
            super.viewDidLoad()
            historyScripts = createHistoryScriptArray()
            
            historyTableView.delegate = self
            historyTableView.dataSource = self
        }
        
        func createHistoryScriptArray() -> [Script]{
            var tempHistoryScript: [Script] = []
            
            let historyScript1 = Script(image: #imageLiteral(resourceName: "Scriptsmall"), title: "script1", date: "111111")
            let historyScript2 = Script(image: #imageLiteral(resourceName: "Scriptsmall"), title: "script2", date: "121212")
            
            tempHistoryScript.append(historyScript1)
            tempHistoryScript.append(historyScript2)
            
            return tempHistoryScript
        }
        
    }

    extension HistoryViewController: UITableViewDataSource, UITableViewDelegate {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return historyScripts.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let historyScript = historyScripts[indexPath.row]
            
            let cell = historyTableView.dequeueReusableCell(withIdentifier: "HistoryScriptCell") as! HistoryScriptTableViewCell
            
            cell.setHistoryScript(script: historyScript)
            
            return cell
        }
        
    }
