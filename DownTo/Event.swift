//
//  Event.swift
//  DownTo
//
//  Created by Ryan McCaffrey on 11/14/15.
//  Copyright © 2015 HP2015. All rights reserved.
//

import Foundation

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