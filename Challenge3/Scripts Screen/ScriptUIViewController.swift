//
//  ScriptUIViewController.swift
//  Challenge3
//
//  Created by Muhammad Bangun Agung on 25/05/20.
//  Copyright © 2020 joahan wirasugianto. All rights reserved.
//

import UIKit
import CoreData

var scripts = [Script]()

let appDelegate = UIApplication.shared.delegate as! AppDelegate
let context = appDelegate.persistentContainer.viewContext

class ScriptUIViewController: UIViewController {
    @IBOutlet var scriptTableView: UITableView!
    @IBOutlet weak var scriptEditButton: UIBarButtonItem!
    
    var selectedIndex = Int()
    
    var idArr: [Int16] = []
    var titleArr: [String] = []
    var dateArr: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //createCoreData()
        requestCoreData()
        
        print(idArr)
        
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
    
    @IBAction func scriptEditButtonAction(_ sender: UIBarButtonItem) {
        switch sender.tag {
        case 0:
            setEditing(true, animated: true)
            scriptTableView.reloadData()
            scriptEditButton.title = "Done"
            scriptEditButton.tag = 1
        case 1:
            setEditing(false, animated: true)
            scriptTableView.reloadData()
            scriptEditButton.title = "Edit"
            scriptEditButton.tag = 0
        default:
            setEditing(false, animated: true)
            scriptTableView.reloadData()
            scriptEditButton.title = "Edit"
        }
        
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        scriptTableView.setEditing(editing, animated: true)
        
        if self.isEditing
        {
             self.scriptEditButton.title = "Done"
            
            
        }
        else
        {
             self.scriptEditButton.title = "Edit"
        }
        
    }
    
    func createCoreData() {
        let newScript = NSEntityDescription.insertNewObject(forEntityName: "Scripts", into: context)
        
        newScript.setValue(idArr.count+1, forKey: "id")
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
    
    func deleteAllCoreData() {
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
    
    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            context.delete(id)
        }
        
        scripts.remove(at: indexPath.row)
        scriptTableView.deleteRows(at: [indexPath], with: .automatic)
        idArr.remove(at: indexPath.row)
        titleArr.remove(at: indexPath.row)
        dateArr.remove(at: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        scripts[sourceIndexPath.row] = scripts[destinationIndexPath.row]
    }
}
