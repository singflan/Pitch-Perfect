//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by Dustin Flanary on 1/21/16.
//  Copyright © 2016 Dustin Flanary. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {

    var audioPlayer:AVAudioPlayer!
    var audioPlayer2:AVAudioPlayer!
    var receivedAudio:RecordedAudio!
    var audioEngine:AVAudioEngine!
    var audioFile:AVAudioFile!
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        audioPlayer = try! AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl)
        audioPlayer.enableRate = true
        
        audioPlayer2 = try! AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl)
        audioPlayer2.enableRate = true
        
        audioEngine = AVAudioEngine()
        audioFile = try! AVAudioFile(forReading: receivedAudio.filePathUrl)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func playQuoteSlowly(sender: AnyObject) {
        playAudioWithVariableSpeed(0.5)
    }

    @IBAction func playQuoteQuickly(sender: AnyObject) {
        playAudioWithVariableSpeed(2.0)
    }
    
    @IBAction func playChipmunkAudio(sender: AnyObject) {
        playAudioWithVariablePitch(1000)
    }
    
    @IBAction func playDarthVaderAudio(sender: AnyObject) {
        playAudioWithVariablePitch(-850)
    }
    
    func playAudioWithVariablePitch(pitch: Float) {
        resetEngine()
        
        let changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        
        setupAndAttachEffectNode(changePitchEffect)
    }

    /*  For the echo, I used some code I found from the following blog [post written in 2014]:
    http://sandmemory.blogspot.com.ar/2014/12/how-would-you-add-reverbecho-to-audio.html? 
    
    But instead of having the echo running a tenth of a second after the start of the file, I have it play the entire file and then repeat it. I'm not sure which makes more sense to do. */
    
    @IBAction func playEcho(sender: AnyObject) {

        resetEngine()
        playAudioWithVariableSpeed(1.0)
        
        
        // This is the variable I added so that the echo occurs after the first recording finishes.
        let recordingLength = audioPlayer.duration
        
        //The only piece of the original code I took out it the following (if I use it, I'll do a longer delay)=> let delay:NSTimeInterval = 0.5;
      
        let playtime:NSTimeInterval
        playtime = audioPlayer.deviceCurrentTime + recordingLength // I replaced 'delay' with my recordingLength variable
        audioPlayer2.stop()
        audioPlayer2.currentTime = 0
        audioPlayer2.volume = 0.8;
        audioPlayer2.playAtTime(playtime)
    }
    
     //I got this code from a forum discussion: https://discussions.udacity.com/t/adding-exceeds-specifications-echo-effect/12929/6
    @IBAction func playReverb(sender: AnyObject) {
        // I mostly just ajusted the code from playAudioWithVariablePitch method. I've created my own methods to do some of the actions.
        
        resetEngine()
        
        let reverb = AVAudioUnitReverb()
        
        reverb.loadFactoryPreset(.LargeRoom2)
        reverb.wetDryMix = 70
        
        setupAndAttachEffectNode(reverb)
        
    }
    
    // Stop and reset any audio that is playing to prevent sound overlap
    @IBAction func stopQuote(sender: AnyObject) {
        resetEngine()
    }
    
    func resetEngine(){
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
    }
    
    func setupAndAttachEffectNode(effectNode: AVAudioNode) {
        
        let audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        audioEngine.attachNode(effectNode)
        
        audioEngine.connect(audioPlayerNode, to: effectNode, format: nil)
        audioEngine.connect(effectNode, to: audioEngine.outputNode,format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        try! audioEngine.start()
        
        audioPlayerNode.play()
    }
    
    func playAudioWithVariableSpeed(rate: Float) {
        // I got the following from the Stack Overflow sample code provided by lecture
        audioPlayer.stop()
        audioEngine.reset()
        audioPlayer.rate = rate
        audioPlayer.currentTime = 0.0 // Start recording from the beginning
        audioPlayer.play()
    }
}
