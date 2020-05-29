//
//  ScriptUIViewController.swift
//  Challenge3
//
//  Created by Muhammad Bangun Agung on 25/05/20.
//  Copyright © 2020 joahan wirasugianto. All rights reserved.
//

import UIKit
import CoreData

var scripts: [Script] = []

let appDelegate = UIApplication.shared.delegate as! AppDelegate
let context = appDelegate.persistentContainer.viewContext

class ScriptUIViewController: UIViewController {
    @IBOutlet var scriptTableView: UITableView!
    
    var selectedIndex = Int()
    
    var idArr: [Int16] = []
    var titleArr: [String] = []
    var dateArr: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createCoreData()
        
        requestCoreData()
        
        scripts = createScriptArray()
        
        scriptTableView.delegate = self
        scriptTableView.dataSource = self
    }
    
    func createScriptArray() -> [Script]{
        var tempScript: [Script] = []
        var script: Script
        
        for index in 0...idArr.count - 1 {
            script = Script(image: #imageLiteral(resourceName: "Scriptsmall"), title: titleArr[index], date: dateArr[index])
            
            tempScript.append(script)
        }
        
        return tempScript
    }
    
    func createCoreData() {
        let newScript = NSEntityDescription.insertNewObject(forEntityName: "Scripts", into: context)
        
        newScript.setValue(4, forKey: "id")
        newScript.setValue("script4", forKey: "title")
        newScript.setValue("111111", forKey: "date")
        
        do {
            try context.save()
            print ("Core Data Saved!")
        } catch {
            //ERROR HANDLING
        }
    }
    
    func requestCoreData() {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Scripts")
        
        do {
            let results = try context.fetch(request)
            
            if results.count > 0 {
                for result in results as! [NSManagedObject]{
                    if let id = result.value(forKey: "id") as? Int16 {
                        idArr.append(id)
                    }
                    
                    if let title = result.value(forKey: "title") as? String {
                        titleArr.append(title)
                    }
                    
                    if let date = result.value(forKey: "date") as? String {
                        dateArr.append(date)
                    }
                }
            }
            
        } catch {
            //ERROR HANDLING
        }
    }
    
    func deleteCoreData() {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Scripts")
        let delete = NSBatchDeleteRequest(fetchRequest: request)
        
        do {
            try context.execute(delete)
        } catch {
            //ERROR HANDLING
        }
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
