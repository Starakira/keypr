//
//  HistoryViewController.swift
//  Challenge3
//
//  Created by Muhammad Bangun Agung on 27/05/20.
//  Copyright © 2020 joahan wirasugianto. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController {
    @IBOutlet weak var historyTableView: UITableView!
    @IBOutlet weak var historySearchBar: UISearchBar!
    
    var historyScripts: [Script] = []
    var selectedIndex = Int()
    
    var searchHistory: [Script] = []
    var searching = false
        
    override func viewDidLoad() {
        super.viewDidLoad()
        historyScripts = createHistoryScriptArray()
        searchHistory = createHistoryScriptArray()
        
        historyTableView.dataSource = self
        historyTableView.delegate = self
        
        historySearchBar.delegate = self
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
        if searching{
            return searchHistory.count
        } else {
            return historyScripts.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let historyScript = historyScripts[indexPath.row]
        let searchHistoryScript = searchHistory[indexPath.row]
        
        let cell = historyTableView.dequeueReusableCell(withIdentifier: "HistoryScriptCell") as! HistoryScriptTableViewCell
        
        if searching {
            cell.setHistoryScript(script: searchHistoryScript)
        } else {
            cell.setHistoryScript(script: historyScript)
        }
        
        return cell
    }
    
}

extension HistoryViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchHistory = historyScripts.filter ({ $0.title.lowercased().prefix(searchText.count) == searchText.lowercased() })
        searching = true
        historyTableView.reloadData()
    }
}
