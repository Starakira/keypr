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
import Speech

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
    
    //Variable Sppech Recognition
    var simpan:String?
    var salah:Int = 0
    var gaksama:Int = 0
    var sama:Int = 0
              var plus:Int = 0
              var akurasi:Double? = 0
    
    //variable Promter
    //en-US
    //id-ID
    
    let audioEgine = AVAudioEngine()
    let speechRecognizer : SFSpeechRecognizer? = SFSpeechRecognizer(locale: Locale(identifier: "id-ID"))
    let request = SFSpeechAudioBufferRecognitionRequest()
    var task: SFSpeechRecognitionTask!
    var isStart: Bool = false
    
    

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
                
                //SpeechRecognition
                startSpeechRecognization()
                
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
            let skrip = "mantap sekali bos";
            let skripLow = skrip.lowercased()
            let result = skripLow.components(separatedBy: [" " , "," , ".","*","+","/"])
            let simpanLow = simpan!.lowercased()
           // let simpanLow = "mantap sekali berlau bos berlabu dlskadpkjas dasjdpiasj dasd kasd asd as";
            let result2 = simpanLow.components(separatedBy: [" " , "," , ".","*","+","/"])
            print(result2)
            
            
            let total = result.count
            print(total)
          
          
            for hasil in 0...result2.count-1  {
                for cek in plus...hasil {
                    if plus < result.count {
                        if result[plus] == result2[cek] {
                            print("sama")
                            plus += 1
                            sama += 1
                        }else{
                            //print(cek)
                        }
                    }else{
                        break
                    }
                }
            }
            
            
            print("Sama \(sama)")
            akurasi! += Double(sama)/Double(total)*100
            print("akurasinya adalah : \(akurasi!)")
            
            
            //SpeechRecognition
            cancelSpeechRecognization()
            
            //Countdown Timer
            timer!.invalidate()
            circularProgressView.animate(fromAngle: circularProgressView.angle, toAngle: 0, duration: 0.5, completion: nil)
            
            //Stop audio Recording
            audioRecorder.stop()
            btnStartRec.setTitle("Start Recording", for: .normal)
            
            //Kirim Data
            let data = storyboard?.instantiateViewController(identifier: "saveRecorder") as! saveRecorderTableViewController
            UserDefaults.standard.set(numberOfRecords ,forKey: "myNumber")
            data.jumlahRecord = numberOfRecords
                          
            data.modalPresentationStyle = .fullScreen
            self.present(data, animated: true)
        }
    }




    override func viewDidLoad() {
        super.viewDidLoad()
        //Req SpeechRecognition
        self.requestPermission()
        
        //Countdown
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
    
    func startSpeechRecognization(){
            let node = audioEgine.inputNode
            let recordingFormat = node.outputFormat(forBus: 0)
            
            node.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { buffer, _ in
                self.request.append(buffer)
            }
            
            //AVAudioEngine bertanggung jawab untuk menerima sinyal audio dari mikrofon.
            audioEgine.prepare()
            do{
                try audioEgine.start()
                print("mulai")
            }catch{
                alertView(message: "ERROR comes here to starting audio listner =\(error.localizedDescription) ")
                print("ERROR comes here to starting audio listner =\(error.localizedDescription) ")
            }
            
            
            //Mengecek apakah support pada perangkat
            guard let myRecognization = SFSpeechRecognizer() else {
                self.alertView(message: "Recogization is not allow on your local")
                print("Not Support")
                return
            }
            
            //Memberitahu user internet tidak tersedia
            if !myRecognization.isAvailable {
                self.alertView(message: " Recogization is free right now, please try again aftar some time")
                print("Internet tidak tersedia")
                return
            }
            
            // SFSpeechRecognitionTask untuk mentranskripsikan audio ke teks.
            task = speechRecognizer!.recognitionTask(with: request, resultHandler: { (response, error) in
                guard let response = response else {
                    if error != nil {
                        self.alertView(message: error.debugDescription)
                        print("ndd suara yang masuk")
                    }else {
                        self.alertView(message: "Problem in giving the responses")
                        print("MASUK")
                    }
                    return
                }
                
                
                let message = response.bestTranscription.formattedString
                print("Message : \(message)")
              //  self.speech.text = message
                self.simpan = message
                
                
                // Speaking AveragePauseDuration
                if response.isFinal{
                let speakingRate = response.bestTranscription.speakingRate
                print("speakingRate : \(speakingRate)")
                let averagePauseDuration = response.bestTranscription.averagePauseDuration
                print("averagePauseDuration : \(averagePauseDuration)")
                }
            })
        }
    
    //func untuk mengulang dari awal Rekaman otoamatis akan di hapus
      func cancelSpeechRecognization() {
          task.finish()
          task.cancel()
          task = nil
        
        akurasiText()
          request.endAudio()
          audioEgine.stop()
          audioEgine.inputNode.removeTap(onBus: 0)
      }
    
    func akurasiText() {
        
    }
    
    //Meminta ijin ke USER menggunakan speechRecognition
func requestPermission() {
    self.btnStartRec.isEnabled = false
    SFSpeechRecognizer.requestAuthorization { (authStatus) in OperationQueue.main.addOperation {
        if authStatus == .authorized {
            print("ACCEPTED")
            self.btnStartRec.isEnabled = true
        }else if authStatus == .denied {
            self.alertView(message: "User denied the permission")
        }else if authStatus == .notDetermined {
            self.alertView(message: "Is User phone there is no speech recognization")
        }else if authStatus == .restricted {
            self.alertView(message: "User has been restricted for using the speech recognization")
        }
        }
    }
}
    
func alertView(message : String) {
        let controller = UIAlertController.init(title: "Error ocured ...!", message: message, preferredStyle: .alert)
        controller.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in
            controller.dismiss(animated: true, completion: nil)
        }))
    }
}
