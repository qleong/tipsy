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
    var tipPercentages: [Double] = []
    
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
        let defaults = UserDefaults.standard
        tipPercentages.removeAll()
        
        // Gets the user tip percentages, or uses default values if they do not exist.
        tipPercentages.append(defaults.object(forKey: SettingsTableViewController.DEFAULT_ONE_KEY) != nil ?
            defaults.object(forKey: SettingsTableViewController.DEFAULT_ONE_KEY)! as! Double : 0.18)
        tipPercentages.append(defaults.object(forKey: SettingsTableViewController.DEFAULT_TWO_KEY) != nil ?
            defaults.object(forKey: SettingsTableViewController.DEFAULT_TWO_KEY)! as! Double : 0.2)
        tipPercentages.append(defaults.object(forKey: SettingsTableViewController.DEFAULT_THREE_KEY) != nil ?
            defaults.object(forKey: SettingsTableViewController.DEFAULT_THREE_KEY)! as! Double : 0.25)
        
        self.tipControl.setTitle(String(format: "%d%%", Int(tipPercentages[0] * 100)), forSegmentAt: 0)
        self.tipControl.setTitle(String(format: "%d%%", Int(tipPercentages[1] * 100)), forSegmentAt: 1)
        self.tipControl.setTitle(String(format: "%d%%", Int(tipPercentages[2] * 100)), forSegmentAt: 2)
        print(tipPercentages)
    }
    
    @IBAction func onTap(_ sender: AnyObject) {
        view.endEditing(true)
    }

    @IBAction func calculateTip(_ sender: AnyObject) {
        refreshTip()
    }
    
    func refreshTip() {
        let bill = Double(billField.text!) ?? 0
        let tip = bill * tipPercentages[tipControl.selectedSegmentIndex]
        let total = bill + tip
        
        tipLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
    }
}

