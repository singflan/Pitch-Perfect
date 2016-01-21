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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let path = NSBundle.mainBundle().pathForResource("movie_quote", ofType: "mp3"){
            let fileUrl = NSURL(fileURLWithPath: path)
            audioPlayer = try! AVAudioPlayer(contentsOfURL: fileUrl)
            audioPlayer.enableRate = true
            
        } else {
            print("the filepath is empty")
        }
        
        
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
    
    func
    
    
    @IBAction func stopQutoe(sender: AnyObject) {
        audioPlayer.stop()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
