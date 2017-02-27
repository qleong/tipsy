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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
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
            tableView.deselectRow(at: indexPath, animated: true)
        } else if indexPath.section == 0 && indexPath.row == 1 {
            tipSelectView.viewWithTag(0)?.isHidden = false
            tableView.deselectRow(at: indexPath, animated: true)
        } else if indexPath.section == 0 && indexPath.row == 2 {
            tipSelectView.viewWithTag(0)?.isHidden = false
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 100
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return String(format: "%d%%", userTipPercentages[row])
    }

}
