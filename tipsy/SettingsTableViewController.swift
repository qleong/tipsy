//
//  SettingsTableViewController.swift
//  tipsy
//
//  Created by Quintin Leong on 2/26/17.
//  Copyright © 2017 Quintin Leong. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController, UIPickerViewDataSource,UIPickerViewDelegate {

    @IBOutlet weak var tipPercentagePicker: UIPickerView!
    @IBOutlet weak var tipSelectView: UIView!
    var userTipPercentages: [Int] = []
    var savedUserTipValues: [Double] = []
    static let DEFAULT_ONE_KEY = "default_percentage_one"
    static let DEFAULT_TWO_KEY = "default_percentage_two"
    static let DEFAULT_THREE_KEY = "default_percentage_three"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Get UserSettings
        loadSavedUserTipPercentages()
        
        // Setup the uiPicker
        setupTipPercentages()
        tipSelectView.viewWithTag(0)?.isHidden = true
        tipPercentagePicker.dataSource = self
        tipPercentagePicker.delegate = self
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupTipPercentages() {
        for percentage in 1...100 {
            userTipPercentages.append(percentage)
        }
    }
    
    func loadSavedUserTipPercentages() {
        let defaults = UserDefaults.standard
        savedUserTipValues.removeAll()
        if defaults.object(forKey: SettingsTableViewController.DEFAULT_ONE_KEY) == nil {
            defaults.set(0.18, forKey: SettingsTableViewController.DEFAULT_ONE_KEY)
        }
        if defaults.object(forKey: SettingsTableViewController.DEFAULT_TWO_KEY) == nil {
            defaults.set(0.2, forKey: SettingsTableViewController.DEFAULT_TWO_KEY)
        }
        if defaults.object(forKey: SettingsTableViewController.DEFAULT_THREE_KEY) == nil {
            defaults.set(0.25, forKey: SettingsTableViewController.DEFAULT_THREE_KEY)
        }
        defaults.synchronize()
        savedUserTipValues.append(defaults.double(forKey: SettingsTableViewController.DEFAULT_ONE_KEY))
        savedUserTipValues.append(defaults.double(forKey: SettingsTableViewController.DEFAULT_TWO_KEY))
        savedUserTipValues.append(defaults.double(forKey: SettingsTableViewController.DEFAULT_THREE_KEY))
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // One section in settings
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 3 rows in the single section
        return 3
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 && indexPath.row == 0 {
            tipSelectView.viewWithTag(0)?.isHidden = false
//            tableView.deselectRow(at: indexPath, animated: true)
            let currentDefaultPercentage = Int(savedUserTipValues[0] * 100) - 1
            tipPercentagePicker.selectRow(currentDefaultPercentage, inComponent: 0, animated: true)
        } else if indexPath.section == 0 && indexPath.row == 1 {
            tipSelectView.viewWithTag(0)?.isHidden = false
//            tableView.deselectRow(at: indexPath, animated: true)
            let currentDefaultPercentage = Int(savedUserTipValues[1] * 100) - 1
            tipPercentagePicker.selectRow(currentDefaultPercentage, inComponent: 0, animated: true)
        } else if indexPath.section == 0 && indexPath.row == 2 {
            tipSelectView.viewWithTag(0)?.isHidden = false
//            tableView.deselectRow(at: indexPath, animated: true)
            let currentDefaultPercentage = Int(savedUserTipValues[2] * 100) - 1
            tipPercentagePicker.selectRow(currentDefaultPercentage, inComponent: 0, animated: true)
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return userTipPercentages.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(format: "%d%%", userTipPercentages[row])
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // This code has the percentage change event
        let indexPath = tableView.indexPathForSelectedRow![1]
        savedUserTipValues[indexPath] = Double(userTipPercentages[row]) / 100.00
        syncUserDefaultValues()
    }
    
    func syncUserDefaultValues() {
        let defaults = UserDefaults.standard
        defaults.set(savedUserTipValues[0], forKey: SettingsTableViewController.DEFAULT_ONE_KEY)
        defaults.set(savedUserTipValues[1], forKey: SettingsTableViewController.DEFAULT_TWO_KEY)
        defaults.set(savedUserTipValues[2], forKey: SettingsTableViewController.DEFAULT_THREE_KEY)
        defaults.synchronize()
    }

}
