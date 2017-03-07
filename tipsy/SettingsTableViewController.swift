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
    @IBOutlet var settingsTableView: UITableView!
    private let uipickerId = 0
    private let userSettings = UserDefaults.standard
    private let tableRowToDefaultKey = [0: SettingsTableViewController.DEFAULT_ONE_KEY,
                                        1: SettingsTableViewController.DEFAULT_TWO_KEY,
                                        2: SettingsTableViewController.DEFAULT_THREE_KEY]
    private var userTipPercentageOptions: [Int] = []
    private var lastSelectedTableRow: IndexPath? = nil
    private var tipPercentageDefaults = [SettingsTableViewController.DEFAULT_ONE_KEY: 0.18,
                                         SettingsTableViewController.DEFAULT_TWO_KEY: 0.2,
                                         SettingsTableViewController.DEFAULT_THREE_KEY: 0.25]
    private var themeSetting = SettingsTableViewController.APP_THEME_ORIGINAL
    static let DEFAULT_ONE_KEY = "default_percentage_one"
    static let DEFAULT_TWO_KEY = "default_percentage_two"
    static let DEFAULT_THREE_KEY = "default_percentage_three"
    static let APP_THEME_KEY = "application_theme"
    static let APP_THEME_ORIGINAL = "original_app_theme"
    static let APP_THEME_DARK = "dark_app_theme"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Get UserSettings
        loadSavedUserTipPercentages()
        loadThemeSettings()
        
        // Setup the uiPicker
        setupUiPicker()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        checkThemeCell()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupUiPicker() {
        setupTipPercentages()
        tipSelectView.viewWithTag(uipickerId)?.isHidden = true
        tipPercentagePicker.dataSource = self
        tipPercentagePicker.delegate = self
    }
    
    func setupTipPercentages() {
        for percentage in 1...100 {
            userTipPercentageOptions.append(percentage)
        }
    }
    
    func loadSavedUserTipPercentages() {
        for (key, _) in tipPercentageDefaults {
            if userSettings.object(forKey: key) == nil {
                userSettings.set(tipPercentageDefaults[key], forKey: key)
            } else {
                tipPercentageDefaults[key] = userSettings.double(forKey: key)
            }
        }
    }
    
    func loadThemeSettings() {
        if userSettings.object(forKey: SettingsTableViewController.APP_THEME_KEY) == nil {
            themeSetting = SettingsTableViewController.APP_THEME_ORIGINAL
            userSettings.set(SettingsTableViewController.APP_THEME_ORIGINAL, forKey: SettingsTableViewController.APP_THEME_KEY)
        } else {
            themeSetting = userSettings.string(forKey:SettingsTableViewController.APP_THEME_KEY)!
        }
    }
    
    func checkThemeCell() {
        // This function should only be called when the viewDidAppear
        let originalTheme = themeSetting == SettingsTableViewController.APP_THEME_ORIGINAL ?
            UITableViewCellAccessoryType.checkmark : UITableViewCellAccessoryType.none
        let darkTheme = themeSetting == SettingsTableViewController.APP_THEME_DARK ?
            UITableViewCellAccessoryType.checkmark : UITableViewCellAccessoryType.none
        self.tableView.cellForRow(at: IndexPath(row: 0, section: 1))!.accessoryType = originalTheme
        settingsTableView.cellForRow(at: IndexPath(row: 1, section: 1))!.accessoryType = darkTheme
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // One section in settings
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 3 rows in the single section
        if section == 0 {
            return 3
        } else if section == 1{
            return 2
        } else {
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            defaultTipSectionSelected(didSelectRowAt: indexPath)
        case 1:
            themeSectionSelected(didSelectRowAt: indexPath)
        default: break
        }
    }
    
    func defaultTipSectionSelected(didSelectRowAt indexPath: IndexPath) {
        if !((tipSelectView.viewWithTag(uipickerId)?.isHidden)!) && lastSelectedTableRow! == indexPath {
            tipSelectView.viewWithTag(uipickerId)?.isHidden = true
            tableView.deselectRow(at: indexPath, animated: true)
        } else {
            tipSelectView.viewWithTag(uipickerId)?.isHidden = false
            let currentDefaultPercentage = Int(tipPercentageDefaults[tableRowToDefaultKey[indexPath.row]!]! * 100) - 1
            tipPercentagePicker.selectRow(currentDefaultPercentage, inComponent: indexPath.section, animated: true)
            lastSelectedTableRow = indexPath
        }
    }
    
    func themeSectionSelected(didSelectRowAt indexPath: IndexPath) {
        if !(tipSelectView.viewWithTag(uipickerId)?.isHidden)! {
            tipSelectView.viewWithTag(uipickerId)?.isHidden = true
        }
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return userTipPercentageOptions.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(format: "%d%%", userTipPercentageOptions[row])
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let indexPath = tableView.indexPathForSelectedRow![1]
        tipPercentageDefaults[tableRowToDefaultKey[indexPath]!] = Double(userTipPercentageOptions[row]) / 100.00
        syncUserDefaultValues()
    }
    
    func syncUserDefaultValues() {
        for (key, value) in tipPercentageDefaults {
            userSettings.set(value, forKey: key)
        }
        userSettings.synchronize()
    }
    
}
