//
//  recorderViewController.swift
//  Challenge3
//
//  Created by joahan wirasugianto on 31/05/20.
//  Copyright © 2020 joahan wirasugianto. All rights reserved.
//

import UIKit
import AVFoundation
import CoreGraphics

class recorderViewController: UIViewController, AVAudioRecorderDelegate {

    //IBOulet
    @IBOutlet weak var circularProgressView: KDCircularProgress!
    @IBOutlet weak var btnStartRec: UIButton!
    @IBOutlet weak var timerLabel: UILabel!
    
    //Variable Recorder
    var waveformView:SCSiriWaveformView!
    var recordingSession:AVAudioSession!
    var audioRecorder:AVAudioRecorder!
    var audioPlayer:AVAudioPlayer!
    var numberOfRecords = 0
    
    //Variable Timer
    var totalTimeInSec:Double = 10
    var timer : Timer?
    var timeInSec = 60.0 {
    didSet {
    if  timeInSec <= 0 {
        timer!.invalidate()
        }
        }}
    

    //Button Start Record
    @IBAction func record(_ sender: Any) {
        //Check if we have an active record
        
        if audioRecorder == nil {
            numberOfRecords += 1
            let filename = getDirectory().appendingPathComponent("\(numberOfRecords).m4a")
            print("nama nya = ", filename)
            
            let settings = [AVFormatIDKey: Int(kAudioFormatMPEG4AAC), AVSampleRateKey: 44100, AVNumberOfChannelsKey: 1, AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue]
            
            resetCounter()
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(recorderViewController.changeLabelText), userInfo:nil, repeats: true)
            
            //Start audio recording
            do{
        
                //WAVE SOUND
                let bounds = UIScreen.main.bounds
                                                    
                waveformView = SCSiriWaveformView(frame: CGRect(x:0, y: 400, width: bounds.width, height: 300))
                waveformView.waveColor = UIColor.black
                waveformView.backgroundColor = .clear
                waveformView.primaryWaveLineWidth = 4.0
                waveformView.secondaryWaveLineWidth = 2.0
                self.view.addSubview(waveformView)
                              
                //END
                
                //Animation Wave Loop
                let displayLink:CADisplayLink = CADisplayLink(target: self, selector: #selector(self.updateMeters))
                displayLink.add(to: .current, forMode: .default)
                
                audioRecorder = try AVAudioRecorder(url: filename, settings: settings)
                audioRecorder.delegate = self
                audioRecorder.record()
                audioRecorder.isMeteringEnabled = true
                audioRecorder.prepareToRecord()
           
                
                btnStartRec.setTitle("Stop Recording", for: .normal)
                
            }catch{
                displayAlert(title: "Ups!", message: "Recording failed")
            }
        }else{
            timer!.invalidate()
            circularProgressView.animate(fromAngle: circularProgressView.angle, toAngle: 0, duration: 0.5, completion: nil)
            //Stop audio Recording
            audioRecorder.stop()
            btnStartRec.setTitle("Start Recording", for: .normal)
            
            let data = storyboard?.instantiateViewController(identifier: "saveRecorder") as! saveRecorderTableViewController
           
            UserDefaults.standard.set(numberOfRecords ,forKey: "myNumber")
            data.jumlahRecord = numberOfRecords
                          
            data.modalPresentationStyle = .fullScreen
            self.present(data, animated: true)
        }
    }




    override func viewDidLoad() {
        super.viewDidLoad()
        timerLabel.text = "Time"
        
        timeInSec = totalTimeInSec
        
        //Setting up Session (Memberikan Permission ke hp unutk menggunakan RECORD)
        recordingSession = AVAudioSession.sharedInstance()
        
        if let number:Int = UserDefaults.standard.object(forKey: "myNumber") as? Int {
            numberOfRecords = number
        }
        
        AVAudioSession.sharedInstance().requestRecordPermission { (hasPermission) in
            if hasPermission {
                print("ACCEPTED")
            }else{
                print("DON'T ACCEPTED")
                self.btnStartRec.isEnabled = false
            }
        }
    }
    

    //Funcetion thet gets path to directory (save Record)
    func getDirectory()-> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = paths[0]
        return documentDirectory
    }
    
    //Funcetion that displays an alert
    func displayAlert(title:String, message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
       present(alert, animated: true, completion: nil)
    }
    
    @objc func updateMeters() {
        audioRecorder.updateMeters()
        let normalizedValue:CGFloat = pow(5, CGFloat(audioRecorder.averagePower(forChannel: 0))/20)
        waveformView.update(withLevel: normalizedValue)
       }
    
    func resetCounter () {
      timeInSec = totalTimeInSec
    }
    
    @objc func changeLabelText() {
      timeInSec -= 1
      let newAngleValue = newAngle()

        circularProgressView.animate(toAngle: Double(newAngleValue), duration: 0.5, completion: nil)
        circularProgressView.set(colors: UIColor(red: 0.18, green: 0.77, blue: 1.00, alpha: 1.00), UIColor(red: 0.00, green: 0.41, blue: 0.98, alpha: 1.00))
        circularProgressView.progressThickness = 0.4
        circularProgressView.trackThickness = 0.4
        circularProgressView.startAngle = -90
        circularProgressView.clockwise = false

        let (_,m,s) = secondsToHoursMinutesSeconds(seconds: Int(timeInSec))

      timerLabel.text = "\(m):\(s)"
    }
    
    func newAngle() -> Int {
      return Int(360 * (timeInSec / totalTimeInSec))
    }
    
    func secondsToHoursMinutesSeconds (seconds : Int) -> (Int, Int, Int) {
       return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
     }
    
    func simpleAlert (title:String,message:String,style:UIAlertAction.Style = UIAlertAction.Style.default,button:String = "OK") {

        let alertController = UIAlertController(title: title, message:   "n" + message, preferredStyle: UIAlertController.Style.alert)
      alertController.addAction(UIAlertAction(title: button, style: style,handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }

}
