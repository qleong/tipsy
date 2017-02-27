//
//  SettingsTableViewController.swift
//  tipsy
//
//  Created by Quintin Leong on 2/26/17.
//  Copyright © 2017 Quintin Leong. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

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
            print("Cell 1 picked")
            tableView.deselectRow(at: indexPath, animated: true)
        } else if indexPath.section == 0 && indexPath.row == 1 {
            print("Cell 2 picked")
            tableView.deselectRow(at: indexPath, animated: true)
        } else if indexPath.section == 0 && indexPath.row == 2 {
            print("Cell 3 picked")
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }

}
