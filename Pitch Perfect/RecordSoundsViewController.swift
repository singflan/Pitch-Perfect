//
//  RecordSoundsViewController.swift
//  Pitch Perfect
//
//  Created by Dustin Flanary on 1/20/16.
//  Copyright © 2016 Dustin Flanary. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {
    @IBOutlet weak var tapToRecordLabel: UILabel!
    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var playButton: UIButton!

    var audioRecorder:AVAudioRecorder!
    var recordedAudio:RecordedAudio!

    override func viewWillAppear(animated: Bool) {
        // When the view appears, hide and unhide the appropiate buttons and labels
        tapToRecordLabel.hidden = false
        stopButton.hidden = true
        recordButton.enabled = true
    }

    @IBAction func recordAudio(sender: AnyObject) {
        // unhide the hidden buttons
        recordingLabel.hidden = false
        stopButton.hidden = false
        recordButton.enabled = false
        tapToRecordLabel.text = "recording in progress"
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
        
        // Creating a unique identifier for each audio recording using the date & time
        let currentDateTime = NSDate()
        let formatter = NSDateFormatter()
        formatter.dateFormat = "ddMMyyyy-HHmmss"
        let recordingName = formatter.stringFromDate(currentDateTime)+".wav"
        let PathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURLWithPathComponents(PathArray)
        print(filePath)
        
        try! audioRecorder = AVAudioRecorder(URL: filePath!, settings:  [:])
        
        audioRecorder.delegate = self
        audioRecorder.meteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "stopRecording") {
            let playSoundsVC:PlaySoundsViewController = segue.destinationViewController as! PlaySoundsViewController
            let data = sender as! RecordedAudio
            playSoundsVC.receivedAudio = data
        }
    }
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder, successfully flag: Bool) {
        if(flag){
            recordedAudio = RecordedAudio(filePathURL: recorder.url, title: recorder.url.lastPathComponent!)
            
            self.performSegueWithIdentifier("stopRecording", sender: recordedAudio)
        } else {
            print("Recording was not successful")
            recordButton.enabled = true
            stopButton.hidden = true
        }
    }

    @IBAction func stopRecording(sender: AnyObject) {
        recordingLabel.hidden = true
        tapToRecordLabel.text = "Tap to record"
        
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }
    
}

