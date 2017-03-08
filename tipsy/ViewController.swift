//
//  ViewController.swift
//  tipsy
//
//  Created by Quintin Leong on 2/10/17.
//  Copyright © 2017 Quintin Leong. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var billLabel: UILabel!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var totalField: UILabel!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var tipField: UILabel!
    @IBOutlet weak var tipControl: UISegmentedControl!
    private let userSettings = UserDefaults.standard
    private var numberFormatter = NumberFormatter()
    private let segmentToPercentageKey = [0: SettingsTableViewController.DEFAULT_ONE_KEY,
                                          1: SettingsTableViewController.DEFAULT_TWO_KEY,
                                          2: SettingsTableViewController.DEFAULT_THREE_KEY]
    private var tipPercentages = [SettingsTableViewController.DEFAULT_ONE_KEY: 0.18,
                                  SettingsTableViewController.DEFAULT_TWO_KEY: 0.2,
                                  SettingsTableViewController.DEFAULT_THREE_KEY: 0.25]
    private var currentTheme = SettingsTableViewController.APP_THEME_ORIGINAL
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set input as first responder
        billField.delegate = self
        billField.becomeFirstResponder()
        
        // Setup number formatter format style
        numberFormatter.numberStyle = NumberFormatter.Style.decimal

        // Retrieve segmented control values from user settings.
        setupSegmentedControl()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if (self.isMovingToParentViewController == false) {
            setupSegmentedControl()
            refreshTip()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        updateTheme()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func updateTheme() {
        let theme = userSettings.string(forKey: SettingsTableViewController.APP_THEME_KEY)
        if theme == nil  || theme! == currentTheme {
            return
        }
        currentTheme = theme!
        let backgroundColor = currentTheme == SettingsTableViewController.APP_THEME_ORIGINAL ? UIColor.white : UIColor.black
        let textColor = currentTheme == SettingsTableViewController.APP_THEME_ORIGINAL ? UIColor.black : UIColor.white
        self.view.backgroundColor = backgroundColor
        billLabel.textColor = textColor
        tipLabel.textColor = textColor
        tipField.textColor = textColor
        totalLabel.textColor = textColor
        totalField.textColor = textColor
    }

    func setupSegmentedControl() {
        for (key, _) in tipPercentages {
            if userSettings.object(forKey: key) == nil {
                userSettings.set(tipPercentages[key], forKey: key)
            } else {
                tipPercentages[key] = userSettings.double(forKey: key)
            }
        }
        self.tipControl.setTitle(String(format: "%d%%", Int(tipPercentages[SettingsTableViewController.DEFAULT_ONE_KEY]! * 100)), forSegmentAt: 0)
        self.tipControl.setTitle(String(format: "%d%%", Int(tipPercentages[SettingsTableViewController.DEFAULT_TWO_KEY]! * 100)), forSegmentAt: 1)
        self.tipControl.setTitle(String(format: "%d%%", Int(tipPercentages[SettingsTableViewController.DEFAULT_THREE_KEY]! * 100)), forSegmentAt: 2)
    }

    func refreshTip() {
        let bill = Double(billField.text!) ?? 0
        let tip = bill * tipPercentages[segmentToPercentageKey[tipControl.selectedSegmentIndex]!]!
        let total = bill + tip
            
        tipField.text = String(format: "$%@", numberFormatter.string(from: NSNumber(value: tip))!)
        totalField.text = String(format: "$%@", numberFormatter.string(from: NSNumber(value: total))!)
    }
    
    @IBAction func onTap(_ sender: AnyObject) {
        view.endEditing(true)
    }

    @IBAction func calculateTip(_ sender: AnyObject) {
        refreshTip()
    }
}
