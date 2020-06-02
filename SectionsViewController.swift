//
//  SectionsViewController.swift
//  createOutline
//
//  Created by wienona martha parlina on 30/05/20.
//  Copyright © 2020 wienona martha parlina. All rights reserved.
//

import Foundation
import UIKit

class SectionsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, AddDefaultSectionViewControllerDelegate {
   
    var sectionList = [Section(), Section(), Section()
    ]
    var editStatus = 0
    @IBOutlet weak var SectionTableView: UITableView!
    override func viewDidLoad() {
    super.viewDidLoad()
       
        //default section
        sectionList[0].SectionTitle = "Introduction"
        sectionList[1].SectionTitle = "Body"
        sectionList[2].SectionTitle = "Closing"
        
    }
    
    
    func addKeypointToSection(kp: [keypoint], Index: Int) {
        sectionList[Index].keypoints = kp
        SectionTableView.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sectionList.count
       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = SectionTableView.dequeueReusableCell(withIdentifier: "sectionCell", for: indexPath) as! SectionTableViewCell
        
        if editStatus == 1 {
            cell.cevronCell.isHidden = true
            
        }
      
        cell.titleCell.text = sectionList[indexPath.row].SectionTitle
        cell.subtitleCell.text = "\(sectionList[indexPath.row].keypoints.count) Keypoints"
        return cell
       }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         let vc = storyboard?.instantiateViewController(identifier: "sectionIntro") as! EditSectionViewController
               vc.delegate = self
        vc.sendDefaultSectionTitle = sectionList[indexPath.row].SectionTitle
        vc.sendIndex = indexPath.row
        vc.sendDefaultSectionKeypoints = sectionList[indexPath.row].keypoints
        vc.sendRequest = 1
        switch sectionList[indexPath.row].SectionTitle {
        case "Introduction":
            vc.sendDefaultSectionDescription = "Grab audience’s attention by asking questions or telling your audience about the big picture"
        case "Body":
            vc.sendDefaultSectionDescription = "Start pointing out Support materials like data and research findings or simply fun facts"
        case "Closing":
            vc.sendDefaultSectionDescription = "End your performance with quotes or value that you want your audience to pursue"
        default:
            vc.sendDefaultSectionDescription = "No Description"
        }
               self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
    @IBOutlet weak var editSectionBtn: UIBarButtonItem!
    
    @IBAction func editSectionCell(_ sender: UIBarButtonItem) {
        setEditing(true, animated: true)
        SectionTableView.reloadData()
        
    }
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        editStatus = 1
        SectionTableView.setEditing(editing, animated: true)
        
        if self.isEditing
        {
             self.editSectionBtn.title = "Done"
            
            
        }
        else
        {
             self.editSectionBtn.title = "Edit"
        }
        
    }
    
     func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }

    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }

   func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    
        sectionList.remove(at: indexPath.row)
    
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        //
    }
       
       
}
