//
//  ViewController.swift
//  Pitch Perfect
//
//  Created by Dustin Flanary on 1/20/16.
//  Copyright © 2016 Dustin Flanary. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var recordButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(animated: Bool) {
        stopButton.hidden = true
        recordButton.enabled = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func recordAudio(sender: AnyObject) {
        recordingLabel.hidden = false
        stopButton.hidden = false
        recordButton.enabled = false
        
    }

    @IBAction func stopRecording(sender: AnyObject) {
        recordingLabel.hidden = true
    }
}

