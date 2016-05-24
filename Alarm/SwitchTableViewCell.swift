//
//  SwitchTableViewCell.swift
//  Alarm
//
//  Created by Habib Miranda on 5/23/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import UIKit

class SwitchTableViewCell: UITableViewCell {

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var switchLabel: UISwitch!
    
    weak var delegate: SwitchTableViewCellDelegate?
    
    func updateWithAlarm(alarm: Alarm) {
        timeLabel.text = alarm.fireTimeAsString
        nameLabel.text = alarm.name
        switchLabel.on  = alarm.enabled
    }
    
    @IBAction func switchValueChanged(sender: AnyObject) {
        delegate?.switchCellSwitchValueChanged(self)
    }

}

// This is analogous to telling a coffee shop to make coffee. We don't tell it how, jsut tell it pot do it.
protocol SwitchTableViewCellDelegate: class {
    func switchCellSwitchValueChanged(cell: SwitchTableViewCell)
}


