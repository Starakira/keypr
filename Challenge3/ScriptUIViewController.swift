//
//  ScriptUIViewController.swift
//  Challenge3
//
//  Created by Muhammad Bangun Agung on 25/05/20.
//  Copyright © 2020 joahan wirasugianto. All rights reserved.
//

import UIKit

var scripts: [Script] = []

class ScriptUIViewController: UIViewController {
    @IBOutlet var scriptTableView: UITableView!
    
    var selectedIndex = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scripts = createScriptArray()
        
        scriptTableView.delegate = self
        scriptTableView.dataSource = self
    }
    
    func createScriptArray() -> [Script]{
        var tempScript: [Script] = []
        
        let script1 = Script(image: #imageLiteral(resourceName: "Scriptsmall"), title: "script1", date: "111111")
        let script2 = Script(image: #imageLiteral(resourceName: "Scriptsmall"), title: "script2", date: "121212")
        
        tempScript.append(script1)
        tempScript.append(script2)
        
        return tempScript
    }
    
}

extension ScriptUIViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scripts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let script = scripts[indexPath.row]
        
        let cell = scriptTableView.dequeueReusableCell(withIdentifier: "ScriptCell") as! ScriptTableViewCell
        
        cell.setScript(script: script)
        
        return cell
    }
    
}
