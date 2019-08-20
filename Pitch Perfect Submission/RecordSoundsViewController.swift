//
//  RecordSoundsViewController.swift
//  Pitch Perfect Submission
//
//  Created by Dylan Simerly on 3/20/16.
//  Copyright © 2016 dylansimerly. All rights reserved.


import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {
    
    // Connect buttons and label to outlets
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var pauseResumeButton: UIButton!

    // Declare variables for AVAudioRecorder and RecordedAudio
    var audioRecorder:AVAudioRecorder!
    var recordedAudio:RecordedAudio!
    
    // Enable the recording button and hide all other buttons-labels
    override func viewWillAppear(_ animated: Bool) {
        recordingLabel.isHidden = false
        pauseResumeButton.isHidden = true
        stopButton.isHidden = true
        recordButton.isEnabled = true
    }
    
    // Connect button to action to record audio
    @IBAction func recordButton(_ sender: AnyObject) {
        print("Record Button Pressed!")
        recordingLabel.text = String("Recording...")
        recordingLabel.isHidden = false
        pauseResumeButton.isHidden = false
        stopButton.isHidden = false
        recordButton.isEnabled = false
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let recordingName = "my_audio.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURL(withPathComponents: pathArray)
        print(filePath!)

        
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSession.Category(rawValue: convertFromAVAudioSessionCategory(AVAudioSession.Category.playAndRecord)))
        
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()

    }

    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if (flag){
            recordedAudio = RecordedAudio()
            recordedAudio.filePathUrl = recorder.url
            recordedAudio.title = recorder.url.lastPathComponent
            performSegue(withIdentifier: "stopRecording", sender: recordedAudio)
        } else {
            print("Recording was not Successful")
            recordButton.isEnabled = true
            recordingLabel.isHidden = true
            pauseResumeButton.isHidden = true
            stopButton.isHidden = true
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "stopRecording"){
            let playSoundsVC:PlaySoundsViewController = segue.destination as!PlaySoundsViewController
            let data = sender as! RecordedAudio
            playSoundsVC.receivedAudio = data
        }
    }
    
    // Connect button to action to stop recording
    @IBAction func stopButton(_ sender: AnyObject) {
        print("Stop Button Pressed!")
        recordingLabel.text = String("Tap Mic To Record")
        recordingLabel.isHidden = true
        pauseResumeButton.isHidden = true
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
        pauseResumeButton.setImage(UIImage(named: "Pause"), for: UIControl.State())
    }
    
    // Connect button to action to pause/resume recording
    @IBAction func pauseResumeButton(_ sender: UIButton) {
        print("Pause/Resume Button Pressed!")
        if (audioRecorder.isRecording) {
            audioRecorder.pause()
            recordingLabel.text = String("Press Play To Continue Recording")
            pauseResumeButton.setImage(UIImage(named: "Play"), for: UIControl.State())
        } else {
            audioRecorder.record()
            recordingLabel.text = String("Recording...")
            pauseResumeButton.setImage(UIImage(named: "Pause"), for: UIControl.State())
            }
        }
}






// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromAVAudioSessionCategory(_ input: AVAudioSession.Category) -> String {
	return input.rawValue
}
