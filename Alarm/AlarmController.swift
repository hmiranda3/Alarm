//
//  AlarmController.swift
//  Alarm
//
//  Created by Habib Miranda on 5/23/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import Foundation

class AlarmController {
    
    static let sharedController = AlarmController()
    
    var alarms: [Alarm] = []
    
    init() {
        alarms = mockAlarms
    }
    
    var mockAlarms: [Alarm] {
        let wakeUpAlarm = Alarm(fireTimeFromMidnight: 700, name: "Wake Up!")
        let schoolAlarm = Alarm(fireTimeFromMidnight: 900, name: "Time For School!")
        let lunchAlarm = Alarm(fireTimeFromMidnight: 1230, name: "Lunch Time!")
        return [wakeUpAlarm, schoolAlarm, lunchAlarm]
    }
    
    func addAlarm(fireTimeFromMidnight: NSTimeInterval, name: String) {
        let alarm = Alarm(fireTimeFromMidnight: fireTimeFromMidnight, name: name)
        alarms.append(alarm)
    }
    
    
    func updateAlarm(alarm: Alarm, fireTimeFromMidnight: NSTimeInterval, name: String) {
        alarm.name = name
        alarm.fireTimeFromMidnight = fireTimeFromMidnight
    }
    
    
    func deleteAlarm(alarm: Alarm) {
        if let index = alarms.indexOf(alarm) {
            alarms.removeAtIndex(index)
        }
    }
    
    func toggleEnabled(alarm: Alarm) {
        alarm.enabled = !alarm.enabled
    }
}

//Create an updateAlarm(alarm: Alarm, fireTimeFromMidnight: NSTimeInterval, name: String) function that updates an existing alarm's fire time and name.

//Create a deleteAlarm(alarm: Alarm) function that removes the alarm from the alarms array
//note: There is no 'removeObject' function on arrays. You will need to find the index of the object and then remove the object at that index. Refer to documentation if you need to know how to find the index of an object.

//note: If you face a compiler error, you may need to check that you have properly implented the Equatable protocol for Alarm objects