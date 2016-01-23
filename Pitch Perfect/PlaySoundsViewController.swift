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
    var receivedAudio:RecordedAudio!
    
    var audioEngine:AVAudioEngine!
    var audioFile:AVAudioFile!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        if let path = NSBundle.mainBundle().pathForResource("movie_quote", ofType: "mp3"){
//            let fileUrl = NSURL(fileURLWithPath: path)
//            
//        } else {
//            print("the filepath is empty")
//        }
      
        audioPlayer = try! AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl)
        audioPlayer.enableRate = true
        
        audioEngine = AVAudioEngine()
        audioFile = try! AVAudioFile(forReading: receivedAudio.filePathUrl)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func playQuoteSlowly(sender: AnyObject) {
        // I got the next line from Stack Overflow sample code provided by lecture
        audioPlayer.stop()
        audioPlayer.rate = 0.5
        // Start recording from the beginning
        audioPlayer.currentTime = 0.0
        audioPlayer.play()
    }

    @IBAction func playQuoteQuickly(sender: AnyObject) {
        audioPlayer.stop()
        audioPlayer.rate = 2.0
        // Start recording from the beginning
        audioPlayer.currentTime = 0.0

        audioPlayer.play()
    }
    
    @IBAction func playChipmunkAudio(sender: AnyObject) {
        playAudioWithVariablePitch(1000)
    }
    
    @IBAction func playDarthVaderAudio(sender: AnyObject) {
        playAudioWithVariablePitch(-1000)
    }
    
    func playAudioWithVariablePitch(pitch: Float) {
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        
        let audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        let changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        try! audioEngine.start()
        
        audioPlayerNode.play()
    }
    
    @IBAction func stopQuote(sender: AnyObject) {
        audioPlayer.stop()
        
    }
}
