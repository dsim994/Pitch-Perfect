//
//  PlaySoundsViewController.swift
//  Pitch Perfect Submission
//
//  Created by Dylan Simerly on 3/21/16.
//  Copyright © 2016 dylansimerly. All rights reserved.


import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    
    // Declare variables needed globally
    var audioPlayer:AVAudioPlayer!
    var receivedAudio:RecordedAudio!
    var audioEngine: AVAudioEngine!
    var audioFile:AVAudioFile!

    override func viewDidLoad() {
        super.viewDidLoad()
    // Initalize Audio Player
        audioPlayer = try!AVAudioPlayer(contentsOf: receivedAudio.filePathUrl as URL)
        audioPlayer.enableRate=true;
        
        audioEngine = AVAudioEngine()
        audioFile = try! AVAudioFile(forReading: receivedAudio.filePathUrl as URL)
        
    do {
        try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback,
            options: AVAudioSession.CategoryOptions.mixWithOthers)
        try AVAudioSession.sharedInstance().setActive(true)
    } catch let error as NSError {
        print(error.localizedDescription)
        }
    }
    
    // Create a function to stop and reset audioEngine/Player
    func stopAndReset() {
        audioEngine.stop()
        audioEngine.reset()
        audioPlayer.stop()
    }
    
    // Create a function to define rate
    func playAudioAtRate(_ rate: Float) {
        stopAndReset()
        audioPlayer.rate = rate
        audioPlayer.currentTime = 0
        audioPlayer.play()
    }
    
    // Connect button to action and slow down rate
    @IBAction func playSlowAudio(_ sender: UIButton) {
        stopAndReset()
        audioPlayer.currentTime = 0.0
        audioPlayer.rate = 0.5
        audioPlayer.play()
    }
    
    // Connect button to action and increase rate
    @IBAction func playFastAudio(_ sender: UIButton) {
        stopAndReset()
        audioPlayer.currentTime = 0.0
        audioPlayer.rate = 2.0
        audioPlayer.play()
    }
    
    // Create a function to define pitch
    func playAudioWithVariablePitch(_ pitch: Float){
        stopAndReset()
        
        let audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attach(audioPlayerNode)
        
        let changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attach(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, at: nil, completionHandler: nil)
        try! audioEngine.start()
        
        audioPlayerNode.play()
    }
    
    // Connect button to action to increase pitch
    @IBAction func playChipmunkAudio(_ sender: UIButton) {
        stopAndReset()
        playAudioWithVariablePitch(1000)
    }
    
    // Connect button to action to decrease pitch
    @IBAction func playDarthVaderAudio(_ sender: UIButton) {
        stopAndReset()
        playAudioWithVariablePitch(-700)
    }
    
    // Create a function to define effects
    func playAudioWithEffect(_ effect: NSObject){
        stopAndReset()

        let audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attach(audioPlayerNode)
        audioEngine.attach(effect as! AVAudioNode)
        
        audioEngine.connect(audioPlayerNode, to: effect as! AVAudioNode, format: nil)
        audioEngine.connect(effect as! AVAudioNode, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, at: nil, completionHandler: nil)
        audioPlayerNode.scheduleFile(audioFile, at: nil, completionHandler: nil)
        try! audioEngine.start()

        audioPlayerNode.play()
    }
    
    // Connect a button to action to add delay effect
    @IBAction func playEchoAudio(_ sender: UIButton) {
        stopAndReset()
        let delayEffect = AVAudioUnitDelay()
        delayEffect.delayTime = 0.8
        playAudioWithEffect(delayEffect)
    }
    
    // Connect a button to action to add reverb effect
    @IBAction func playReverbAudio(_ sender: UIButton) {
        stopAndReset()
        let reverbEffect = AVAudioUnitReverb()
        reverbEffect.loadFactoryPreset(.largeRoom2)
        reverbEffect.wetDryMix = 200
        playAudioWithEffect(reverbEffect)
    }
    
    // Connect a button to action to stop all engines and audio
    @IBAction func stopButton(_ sender: UIButton) {
        stopAndReset()
    }
}
    


