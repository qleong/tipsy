//
//  ViewController.swift
//  tipsy
//
//  Created by Quintin Leong on 2/10/17.
//  Copyright © 2017 Quintin Leong. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var tipControl: UISegmentedControl!
    private let userSettings = UserDefaults.standard
    private let segmentToPercentageKey = [0: SettingsTableViewController.DEFAULT_ONE_KEY,
                                          1: SettingsTableViewController.DEFAULT_TWO_KEY,
                                          2: SettingsTableViewController.DEFAULT_THREE_KEY]
    private var tipPercentages = [SettingsTableViewController.DEFAULT_ONE_KEY: 0.18,
                                  SettingsTableViewController.DEFAULT_TWO_KEY: 0.2,
                                  SettingsTableViewController.DEFAULT_THREE_KEY: 0.25]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Retrieve segmented control values from user settings.
        setupSegmentedControl()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if (self.isMovingToParentViewController == false) {
            setupSegmentedControl()
            refreshTip()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        
        tipLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
    }
    
    @IBAction func onTap(_ sender: AnyObject) {
        view.endEditing(true)
    }

    @IBAction func calculateTip(_ sender: AnyObject) {
        refreshTip()
    }
}
