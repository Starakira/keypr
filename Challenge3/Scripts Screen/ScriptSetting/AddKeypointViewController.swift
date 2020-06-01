//
//  ViewController.swift
//  WSTagsFieldExample
//
//  Created by Ricardo Pereira on 04/07/16.
//  Copyright © 2016 Whitesmith. All rights reserved.
//

import UIKit
import WSTagsField

protocol AddKeypointViewControllerDelegate {
    func addKeypoint(kp: keypoint)
    func editKeypoint(kp: keypoint, index: Int)
    func deleteKeypoint(index: Int)
}

class AddKeypointViewController: UIViewController {
    var delegate: EditSectionViewController?
    var keywords = [String]()
    var keypoints = [keypoint]()
    var NotEmpty = [false, false]
    
    //send
    var sendRequest = 0
    var sendKeypoint = keypoint()
    var sendIndex = Int()
    var sendNotEmpty = [Bool]()
    
    @IBOutlet weak var saveKeypointOutlet: UIBarButtonItem!
    @IBOutlet weak var OutlineTitle: UITextField!
    @IBAction func saveKeypoint(_ sender: UIBarButtonItem) {
        
       
        
        var newKeypoint = keypoint()
        newKeypoint.keypointTitle = OutlineTitle.text ?? ""
        newKeypoint.keywords = keywords
        if sendRequest == 1{
            delegate?.editKeypoint(kp: newKeypoint, index: sendIndex)
        }
       
        else{
        delegate?.addKeypoint(kp: newKeypoint)
        }
        
        self.navigationController?.popViewController(animated: true)
        
        
    }
 
    @IBOutlet weak var keypointTotal: UITextView!
    
    fileprivate let tagsField = WSTagsField()

    @IBOutlet fileprivate weak var tagsView: UIView!
    
    @IBOutlet weak var anotherField: UITextField!
    
    //delete outline
    @IBAction func deleteOutline(_ sender: UIButton) {
        let alert = UIAlertController(title: "Are you sure?", message: "removing Keypoint will also remove keywords", preferredStyle: .alert)

        //if user press YES
        alert.addAction(UIAlertAction(title: "Delete", style: .default, handler: { action in
            self.delegate?.deleteKeypoint(index: self.sendIndex)
              self.navigationController?.popViewController(animated: true)
        }))
        
        //if user press NO
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

        self.present(alert, animated: true)
    }
    @IBAction func outlineTitleField(_ sender: Any) {
        if OutlineTitle.text?.isEmpty == false  {
            NotEmpty[0] = true
        }
        else{
            NotEmpty[0] = false
        }
        
        if NotEmpty[0] == true && NotEmpty[1] == true {
                       self.saveKeypointOutlet.isEnabled = true
                   }
      else if NotEmpty[0] == false || NotEmpty[1] == false{
                       self.saveKeypointOutlet.isEnabled = false
        }
    }
    @IBOutlet weak var deleteOutline: UIButton!
    
    
    override func viewDidLoad() {
        
        
        super.viewDidLoad()
       
       if NotEmpty[0] == true && NotEmpty[1] == true {
                         self.saveKeypointOutlet.isEnabled = true
                     }
        else if NotEmpty[0] == false || NotEmpty[1] == false{
                         self.saveKeypointOutlet.isEnabled = false
          }
        
        keypointTotal.text = "\(sendKeypoint.keywords.count) Keywords" ?? "0 Keywords"
        OutlineTitle.text = sendKeypoint.keypointTitle ?? ""
        tagsField.frame = tagsView.bounds
        tagsView.addSubview(tagsField)

        //tagsField.translatesAutoresizingMaskIntoConstraints = false
        //tagsField.heightAnchor.constraint(equalToConstant: 150).isActive = true
        if sendRequest == 1 {
            for keyword in sendKeypoint.keywords {
                tagsField.addTag(keyword)
                keywords.append(keyword)
            }
            
        }
       
        tagsField.cornerRadius = 3.0
        tagsField.spaceBetweenLines = 10
        tagsField.spaceBetweenTags = 10

        //tagsField.numberOfLines = 3
        //tagsField.maxHeight = 100.0

        tagsField.layoutMargins = UIEdgeInsets(top: 2, left: 6, bottom: 2, right: 6)
        tagsField.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10) //old padding

        tagsField.placeholder = "Enter Keyword"
        tagsField.placeholderColor = .gray
        tagsField.placeholderAlwaysVisible = true
        tagsField.backgroundColor = .none
        tagsField.textField.returnKeyType = .continue
        tagsField.delimiter = ","
        print(tagsField.text)
        tagsField.textDelegate = self

        textFieldEvents()
    }
    
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tagsField.beginEditing()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tagsField.frame = tagsView.bounds
    }
    
    @IBAction func touchReadOnly(_ sender: UIButton) {
        tagsField.readOnly = !tagsField.readOnly
        sender.isSelected = tagsField.readOnly
    }

    @IBAction func touchChangeAppearance(_ sender: UIButton) {
        tagsField.layoutMargins = UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1)
        tagsField.contentInset = UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2) //old padding
        tagsField.cornerRadius = 10.0
        tagsField.spaceBetweenLines = 2
        tagsField.spaceBetweenTags = 2
        tagsField.tintColor = .red
        tagsField.textColor = .systemPink
        tagsField.selectedColor = .yellow
        tagsField.selectedTextColor = .black
        tagsField.delimiter = ","
        tagsField.isDelimiterVisible = true
        tagsField.borderWidth = 2
        tagsField.borderColor = .none
        tagsField.textField.textColor = .green
        tagsField.placeholderColor = .green
        tagsField.placeholderAlwaysVisible = false
        tagsField.font = UIFont.systemFont(ofSize: 90)
        tagsField.keyboardAppearance = .dark
        tagsField.acceptTagOption = .space
    }

    

   

}

extension AddKeypointViewController {
    func returnKeypoints(lol: String){
        keywords.append(lol)
    }
    
    
    func checkEmptyness() {
        if self.keywords.isEmpty == false {
            self.NotEmpty[1] = true
        }
        if self.keywords.isEmpty == true
        {
            print("lol")
             self.NotEmpty[1] = false
            
        }
        
        //change save button enable
        if self.NotEmpty[0] == true && self.NotEmpty[1] == true {
            self.saveKeypointOutlet.isEnabled = true
        }
        else if self.NotEmpty[0] == false || self.NotEmpty[1] == false{
            self.saveKeypointOutlet.isEnabled = false
        }
        
    }
    
    fileprivate func textFieldEvents() {
        tagsField.onDidAddTag = { field, tag in
            
            // Keypoints append
            self.keywords.append(tag.text)
            print(self.keywords)
            print("onDidAddTag", tag.text)
            
            //keypoints total changing
            self.keypointTotal.text = "\(self.keywords.count) Keywords"
            
            
            self.checkEmptyness()
            
            
        }
        
        
        
        tagsField.onDidRemoveTag = { field, tag in
            print("onDidRemoveTag", tag.text)
            //remove keypoint from array
            self.keywords.index(of: tag.text).map { self.keywords.remove(at: $0) }
            //print(self.keypoints)
            self.checkEmptyness()
            
            
        }

        tagsField.onDidChangeText = { _, text in
            print("onDidChangeText")
        }

        tagsField.onDidChangeHeightTo = { _, height in
            print("HeightTo \(height)")
        }

        tagsField.onDidSelectTagView = { _, tagView in
            print("Select \(tagView)")
        }

        tagsField.onDidUnselectTagView = { _, tagView in
            print("Unselect \(tagView)")
        }

        tagsField.onShouldAcceptTag = { field in
            return field.text != "OMG"
        }
    }

}

extension AddKeypointViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == tagsField {
            anotherField.becomeFirstResponder()
        }
        return true
    }

}
