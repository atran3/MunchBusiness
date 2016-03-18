//
//  DashboardTableViewController.swift
//  MunchBusiness
//
//  Created by Alexander Tran on 3/17/16.
//  Copyright © 2016 Alexander Tran. All rights reserved.
//

import UIKit
import CoreData
import SwiftyJSON

class DashboardTableViewController: UITableViewController {

    private var currName = ""
    private var currAddress = ""
    private var currPhone = ""
    private var currHours = ""
    
    private let restaurant_id = NSUserDefaults.standardUserDefaults().integerForKey("restaurantId")
    
    private var managedObjectContext: NSManagedObjectContext? = AppDelegate.managedObjectContext
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var addressField: UITextField!
    @IBOutlet weak var phoneField: UITextField!
    @IBOutlet weak var hoursField: UITextField!
    @IBOutlet weak var discardButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.allowsSelection = false
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        toggleButtons(false)
        nameField.addTarget(self, action: "textFieldDidChange:", forControlEvents: UIControlEvents.EditingChanged)
        addressField.addTarget(self, action: "textFieldDidChange:", forControlEvents: UIControlEvents.EditingChanged)
        phoneField.addTarget(self, action: "textFieldDidChange:", forControlEvents: UIControlEvents.EditingChanged)
        hoursField.addTarget(self, action: "textFieldDidChange:", forControlEvents: UIControlEvents.EditingChanged)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        fetchInfo()
    }
    
    func textFieldDidChange(textField: UITextField) {
        let changed = nameField.text! != currName || addressField.text! != currAddress ||
            phoneField.text! != currPhone || hoursField.text! != currHours
        toggleButtons(changed)
    }
    
    @IBAction func discardChanges(sender: AnyObject) {
        toggleButtons(false)
    }
    
    private func fillFields() {
        nameField.text = currName
        addressField.text = currAddress
        phoneField.text = currPhone
        hoursField.text = currHours
    }
    
    @IBAction func saveChanges(sender: AnyObject) {
        currName = nameField.text!
        currAddress = addressField.text!
        currPhone = phoneField.text!
        currHours = hoursField.text!
        
        Restaurant.createRestaurant(inManagedObjectContext: self.managedObjectContext!, hours: currHours, phone_number: currPhone, name: currName, address: currAddress, latitude: 0, longitude: 0, distance: 0, id: restaurant_id)
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            let data = ["address": self.currAddress, "hours": self.currHours, "name": self.currName, "phone_number": self.currPhone]
            HttpService.doRequest("/api/restaurant/" + String(self.restaurant_id) + "/", method: "PUT", data: data, flag: true, synchronous: true)
        }
        toggleButtons(false)
    }
    
    private func processResponse(response: JSON) {
        currName = response["name"].string!
        currAddress = response["address"].string!
        currPhone = response["phone_number"].string!
        currHours = response["hours"].string!
        
        fillFields()
        
        Restaurant.createRestaurant(inManagedObjectContext: self.managedObjectContext!, hours: currHours, phone_number: currPhone, name: currName, address: currAddress, latitude: 0, longitude: 0, distance: 0, id: restaurant_id)
    }
    
    private func fetchInfo() {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            let (listResponse, listStatus) = HttpService.doRequest("/api/restaurant/" + String(self.restaurant_id) + "/", method: "GET", data: nil, flag: true, synchronous: true)
            dispatch_async(dispatch_get_main_queue()) {
                if listStatus {
                    self.processResponse(listResponse!)
                }
            }
        }
    }
    
    private func toggleButtons(enable: Bool) {
        if enable {
            discardButton.backgroundColor = Util.Colors.ErrorRed
            saveButton.backgroundColor = Util.Colors.SaveGreen
            discardButton.tintColor = UIColor.whiteColor()
            saveButton.tintColor = UIColor.whiteColor()
        } else {
            discardButton.backgroundColor = Util.Colors.SelectedTabGray
            saveButton.backgroundColor = Util.Colors.LightGray
            discardButton.tintColor = Util.Colors.DarkGray
            saveButton.tintColor = Util.Colors.DarkGray
        }
        
        discardButton.enabled = enable
        saveButton.enabled = enable
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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
