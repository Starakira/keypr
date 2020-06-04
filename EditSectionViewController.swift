//
//  EditSectionViewController.swift
//  createOutline
//
//  Created by wienona martha parlina on 31/05/20.
//  Copyright © 2020 wienona martha parlina. All rights reserved.
//

import UIKit

protocol AddDefaultSectionViewControllerDelegate {
    func addKeypointToSection(kp: [keypoint], Index: Int)
}

class EditSectionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, AddKeypointViewControllerDelegate {
    var sendDefaultSectionTitle: String!
    var sendDefaultSectionDescription: String!
    var sendIndex: Int!
    var sendDefaultSectionKeypoints: Array<keypoint>!
    var sendRequest = 0
    
    @IBOutlet weak var KeypointsTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if sendRequest == 1 {
            keypoints = sendDefaultSectionKeypoints
        }
        
        //set section Title and Description
        self.title = sendDefaultSectionTitle
        DefaultSectionTitle?.text = sendDefaultSectionTitle ?? ""
        defaultSectionDescription?.text = sendDefaultSectionDescription
    }
    
    @IBOutlet weak var DefaultSectionTitle: UILabel?
    @IBOutlet weak var defaultSectionDescription: UILabel?
    
    var delegate: SectionsViewController?
    
    
    func deleteKeypoint(index: Int) {
        keypoints.remove(at: index)
         KeypointsTableView.reloadData()
    }
    
    var keypoints = [keypoint]()
    
    func addKeypoint(kp: keypoint) {
        keypoints.append(kp)
        KeypointsTableView.reloadData()
    }
    
    func editKeypoint(kp: keypoint, index: Int) {
        keypoints[index] = kp
        KeypointsTableView.reloadData()
    }
    
    @IBAction func saveSection(_ sender: UIBarButtonItem) {
        
        delegate?.addKeypointToSection(kp: keypoints, Index: sendIndex)
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func backToSection(_ sender: UIBarButtonItem) {
         self.navigationController?.popViewController(animated: true)
        
    }
    @IBAction func addKp(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(identifier: "editKp") as! AddKeypointViewController
               vc.delegate = self
              
               self.navigationController?.pushViewController(vc, animated: true)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return keypoints.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = KeypointsTableView.dequeueReusableCell(withIdentifier: "kpCell", for: indexPath) as! SectionTableViewCell
        
        cell.titleCell.text = keypoints[indexPath.row].keypointTitle
        cell.subtitleCell.text = "\(keypoints[indexPath.row].keywords.count) Keywords"
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(identifier: "editKp") as! AddKeypointViewController
        vc.delegate = self
            
        vc.sendKeypoint = keypoints[indexPath.row]
        vc.sendIndex = indexPath.row
        vc.sendRequest = 1
        vc.NotEmpty[0] = true
        vc.NotEmpty[1] = true
        self.navigationController?.pushViewController(vc, animated: true)
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


