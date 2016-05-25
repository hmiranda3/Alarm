//
//  AlarmController.swift
//  Alarm
//
//  Created by Habib Miranda on 5/23/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import UIKit

class AlarmController {
    
    static let sharedController = AlarmController()
    
    private let kAlarms = "AlarmKey"
    
    var alarms: [Alarm] = []
    
    weak var delegate: AlarmScheduler?
    
    init() {
        alarms = mockAlarms
        loadFromPersistentStorage()
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
        saveToPersistentStorage()
        return
    }
    
    
    func updateAlarm(alarm: Alarm, fireTimeFromMidnight: NSTimeInterval, name: String) {
        alarm.name = name
        alarm.fireTimeFromMidnight = fireTimeFromMidnight
        saveToPersistentStorage()
    }
    
    
    func deleteAlarm(alarm: Alarm) {
        if let index = alarms.indexOf(alarm) {
            alarms.removeAtIndex(index)
            saveToPersistentStorage()
        }
    }
    
    func toggleEnabled(alarm: Alarm) {
        alarm.enabled = !alarm.enabled
        saveToPersistentStorage()
    }

    
    func filePath(key: String) -> String {
        let directorySearchResults = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory,NSSearchPathDomainMask.AllDomainsMask, true)
        let documentsPath: AnyObject = directorySearchResults[0]
        let entriesPath = documentsPath.stringByAppendingString("/\(key).plist")
        
        return entriesPath
    }
    
    func saveToPersistentStorage() {
        NSKeyedArchiver.archiveRootObject(self.alarms, toFile: self.filePath(kAlarms))
    }
    
    func loadFromPersistentStorage() {
        guard let alarms = NSKeyedUnarchiver.unarchiveObjectWithFile(self.filePath(kAlarms)) as? [Alarm] else {
            return
        }
        self.alarms = alarms
    }
}

protocol AlarmScheduler: class {
    
    func scheduleLocalNotifications(alarm: Alarm)
    
    func cancelLocalNotifications(alarm: Alarm)
}

extension AlarmScheduler {
    
    func scheduleLocalNotifications(alarm: Alarm) {
        let localNotifications = UILocalNotification()
        localNotifications.category = alarm.uuid
        localNotifications.alertTitle = "Alert!"
        localNotifications.alertBody = "Alert Body!"
        localNotifications.fireDate = alarm.fireDate
        localNotifications.repeatInterval = .Day
        UIApplication.sharedApplication().scheduleLocalNotification(localNotifications)
        
    }
    
    func cancelLocalNotifications(alarm: Alarm) {
        guard let scheduledNotifications = UIApplication.sharedApplication().scheduledLocalNotifications else { return }
        for notification in scheduledNotifications {
            if notification.category ?? "" == alarm.uuid {
                UIApplication.sharedApplication().cancelLocalNotification(notification)
            }
        }
    }
}

//extension AlarmScheduler {
//    func scheduleLocalNotification(alarm: Alarm) {
//        let localNotification = UILocalNotification()
//        localNotification.category = alarm.uuid
//        localNotification.alertTitle = "Time's up!"
//        localNotification.alertBody = "Your alarm titled \(alarm.name) is done"
//        localNotification.fireDate = alarm.fireDate
//        localNotification.repeatInterval = .Day
//        UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
//    }
//
//    func cancelLocalNotification(alarm: Alarm) {
//        guard let scheduledNotifications = UIApplication.sharedApplication().scheduledLocalNotifications else {return}
//        for notification in scheduledNotifications {
//            if notification.category ?? "" == alarm.uuid {
//                UIApplication.sharedApplication().cancelLocalNotification(notification)
//            }
//        }
//}

//
//In your AlarmController file but outside of the class, create a protocol AlarmScheduler. This protocol will need two functions: scheduleLocalNotification(alarm: Alarm) and cancelLocalNotification(alarm: Alarm).
//Below your protocol, create an extension AlarmScheduler. In there, you can rewrite the two protocol functions but also give them function bodies.

//Your scheduleLocalNotification(alarm: Alarm) function should create an instance of a UILocalNotification, give it an alert title, alert body, and fire date. You will also need to set it's category property to something unique (hint: the unique identifier we put on each alarm object is pretty unique). It should also be set to repeat at one day intervals. You will then need to schedule this local notification with the application's shared application.
//Your cancelLocalnotification(alarm: Alarm) function will need to get all of the application's scheduled notifications using UIApplication.sharedApplication.scheduledLocalNotifications. This will give you an array of local notifications. You can loop through them and cancel the local notifications whose category matches the alarm using UIApplication.sharedApplication.cancelLocalNotification(notification: notification).
//Now go to your list view controller and detail view controller and make them conform to the AlarmScheduler protocol. Notice how the compiler does not make you implement the schedule and cancel functions from the protocol. This is because by adding an extension to the protocol, we have created the implementation of these functions for all classes that conform to the protocol.
//Go to your AlarmListTableViewController. In your switchCellSwitchValueChanged function you will need to schedule a notification if the switch is being turned on, and cancel the notification if the switch is being turned off. You will also need to cancel the notification when you delete an alarm.
//Go to your AlarmDetailTableViewController. Your enableButtonTapped action will need to either schedule or cancel a notification depending on its state, and will also need to call your AlarmController.sharedInstance.toggleEnabled(alarm: Alarm) function if it isn't being called already. Your saveButtonTapped will need to schedule a notification when saving a brand new alarm, and will need to cancel and re-set a notification when saving existing alarms (this is because the user may have changed the time for the alarm).








