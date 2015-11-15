//
//  Event.swift
//  DownTo
//
//  Created by Ryan McCaffrey on 11/14/15.
//  Copyright © 2015 HP2015. All rights reserved.
//

import Foundation

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")

        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }

    convenience init(netHex:Int) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff)
    }
}

class Countdown : CustomStringConvertible {
    var startMinutes: Int
    var currentMinutes: Int
    var currentSeconds: Int
    var description: String {
        get {
            if currentSeconds < 10 {
                return "\(currentMinutes):0\(currentSeconds)"
            }
            return  "\(currentMinutes):\(currentSeconds)"
        }
    }
    var done: Bool {
        get {
            return currentMinutes == 0 && currentSeconds == 0
        }
    }

    init(startMinutes: Int, currentMinutes: Int, currentSeconds: Int) {
        self.startMinutes = startMinutes
        self.currentMinutes = currentMinutes
        self.currentSeconds = currentSeconds
    }
    
    init(timeOfCreation: String, eventLength: Int) {
        //time format from DB is 2015-11-15T09:32:03.03+00:00
        let deadlineMinute: Int = Int(timeOfCreation.substringWithRange(Range<String.Index>(start: timeOfCreation.startIndex.advancedBy(14), end: timeOfCreation.endIndex.advancedBy(-12))))! + eventLength
        let deadlineSecond: Int = Int(timeOfCreation.substringWithRange(Range<String.Index>(start: timeOfCreation.startIndex.advancedBy(17), end: timeOfCreation.endIndex.advancedBy(-9))))!
        
        let currentDate = NSDate()
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "mm:ss"
        let convertedDate = dateFormatter.stringFromDate(currentDate)
        let currentMinute: Int = Int(convertedDate.substringWithRange(Range<String.Index>(start: convertedDate.startIndex.advancedBy(0), end: convertedDate.endIndex.advancedBy(-3))))!
        let currentSecond: Int = Int(convertedDate.substringWithRange(Range<String.Index>(start: convertedDate.startIndex.advancedBy(3), end: convertedDate.endIndex.advancedBy(0))))!
        
        self.startMinutes = eventLength
        self.currentMinutes = deadlineMinute - currentMinute
        self.currentSeconds = deadlineSecond - currentSecond
    }

    convenience init(_ startMinutes: Int) {
        self.init(startMinutes: startMinutes, currentMinutes: startMinutes, currentSeconds: 0)
    }

    func decrement() {
        currentSeconds--
        if currentSeconds < 0 {
            if currentMinutes == 0 {
                currentSeconds = 0
                return
            }
            currentMinutes--
            currentSeconds = 59
        }
    }

    func increment() {
        currentSeconds++
        if currentSeconds == 60 {
            currentMinutes++
            currentSeconds = 0
        }
    }
}

struct User {
    var name: String
    var id: String
}

class Event : CustomStringConvertible {
    var creatorName: String
    var creatorUserId: String
    var receiverName: String
    var receiverUserId: String

    var eventName: String
    var eventLocation: String
    var eventTime: Int

    var description: String {
        get {
            return "\(self.createDictionary())"
        }
    }

    init(creatorName: String, creatorUserId: String, receiverName: String, receiverUserId: String, eventName: String, eventLocation: String, eventTime: Int) {
        self.creatorName = creatorName
        self.creatorUserId = creatorUserId
        self.receiverName = receiverName
        self.receiverUserId = receiverUserId

        self.eventName = eventName
        self.eventLocation = eventLocation
        self.eventTime = eventTime
    }

    convenience init(creator: User, receiver: User, eventName: String, eventLocation: String, eventTime: Int) {
        self.init(creatorName: creator.name, creatorUserId: creator.id,
            receiverName: receiver.name, receiverUserId: receiver.id,
            eventName: eventName, eventLocation: eventLocation, eventTime: eventTime)
    }

    // FIXME
    class func fromDictionary(dictionary: [String: AnyObject]) -> Event {
        return Event.init(creatorName: dictionary["creator_name"] as! String, creatorUserId: dictionary["creator_userid"] as! String, receiverName: dictionary["receiver_name"] as! String, receiverUserId: dictionary["receiver_userid"] as! String, eventName: dictionary["name"] as! String, eventLocation: dictionary["location"] as! String, eventTime: dictionary["time"] as! Int)
    }

    func createDictionary() -> [String: AnyObject] {
        return ["creator_name": creatorName, "creator_userid": creatorUserId, "receiver_name": receiverName, "receiver_userid": receiverUserId, "name": eventName, "location": eventLocation, "time": eventTime]
    }
}