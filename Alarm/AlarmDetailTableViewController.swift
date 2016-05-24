//
//  AlarmDetailTableViewController.swift
//  Alarm
//
//  Created by Habib Miranda on 5/23/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import UIKit

class AlarmDetailTableViewController: UITableViewController {
    
    var alarm: Alarm?
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var alarmName: UITextField!
    @IBOutlet weak var enableAlarmButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        if let alarm = alarm {
            updateWithAlarm(alarm)
        }
        setUpView()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Action Buttons
    
    @IBAction func enableAlarmButtonTapped(sender: AnyObject) {
        guard let alarm = alarm else { return }
        AlarmController.sharedController.toggleEnabled(alarm)
        setUpView()
    }
    
    @IBAction func saveButtonTapped(sender: AnyObject) {
        guard let title = alarmName.text,
            thisMorningAtMidnight = DateHelper.thisMorningAtMidnight else { return }
        let timeIntervalSinceMidnight = datePicker.date.timeIntervalSinceDate(thisMorningAtMidnight)
        if let alarm = alarm {
            AlarmController.sharedController.updateAlarm(alarm, fireTimeFromMidnight: timeIntervalSinceMidnight, name: title)
        } else {
            let _ = AlarmController.sharedController.addAlarm(timeIntervalSinceMidnight, name: title)
        }
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    // MARK: - Tabvle View Data Source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func updateWithAlarm(alarm: Alarm) {
        if let date = alarm.fireDate {
            datePicker.date = date
            alarmName.text = alarm.name
        }
    }
    func setUpView() {
        if alarm == nil {
            enableAlarmButton.hidden = true
        } else {
            enableAlarmButton.hidden = false
            if alarm?.enabled == true {
                enableAlarmButton.setTitle("Disable", forState: .Normal)
                enableAlarmButton.backgroundColor = UIColor.redColor()
                enableAlarmButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
            } else {
                enableAlarmButton.setTitle("Enable", forState: .Normal)
                enableAlarmButton.backgroundColor = UIColor.grayColor()
                enableAlarmButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
            }
        }
    }
    
    /*
     // Override to support rearranging the table view.
     override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
