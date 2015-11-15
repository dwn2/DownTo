//
//  Event.swift
//  DownTo
//
//  Created by Ryan McCaffrey on 11/14/15.
//  Copyright © 2015 HP2015. All rights reserved.
//

import Foundation

class Event {
    var creatorName: String
    var eventTime: NSDate
    var eventName: String
    var eventLocation: String
    
    init(creatorName: String, eventTime: NSDate, eventName: String, eventLocation: String) {
        self.creatorName = creatorName
        self.eventTime = eventTime
        self.eventName = eventName
        self.eventLocation = eventLocation
    }
    
    func getCreatorName() -> String {
        return self.creatorName
    }
    
    func getEventTime() -> NSDate {
        return self.eventTime
    }
    
    func getEventName() -> String {
        return self.creatorName
    }
    
    func getEventLocation() -> String {
        return self.creatorName
    }
}