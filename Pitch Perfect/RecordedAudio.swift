//
//  RecordedAudio.swift
//  Pitch Perfect
//
//  Created by Dustin Flanary on 1/22/16.
//  Copyright © 2016 Dustin Flanary. All rights reserved.
//

import Foundation

class RecordedAudio: NSObject{
    var filePathUrl: NSURL!
    var title: String!
    
    // Creating an initializer for this class
    init(filePathURL: NSURL, title: String) {
        self.filePathUrl = filePathURL
        self.title = title
    }
}

