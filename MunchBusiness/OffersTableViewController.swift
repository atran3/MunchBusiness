//
//  OffersTableViewController.swift
//  MunchBusiness
//
//  Created by Alexander Tran on 3/17/16.
//  Copyright © 2016 Alexander Tran. All rights reserved.
//

import UIKit
import CoreData
import SwiftyJSON

class OffersTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "addOffer")
        tableView.allowsSelection = false
        
        //Cuz my shit aint no bitch
        let _ = NSTimer.scheduledTimerWithTimeInterval(5.0, target: self, selector: Selector("fetchPromotions"), userInfo: nil, repeats: true)
        
        fetchPromotions()
    }

    private var managedObjectContext: NSManagedObjectContext? = AppDelegate.managedObjectContext
    
    func addOffer() {
        performSegueWithIdentifier("AddOfferSegue", sender: nil)
    }
    
    @IBAction func cancelAdd(segue: UIStoryboardSegue) {
        
    }
    
    @IBAction func finishAdd(segue: UIStoryboardSegue) {
        if let vc = segue.sourceViewController as? AddOfferViewController {
            let date = NSDate()
            let expiryDate = date.dateByAddingTimeInterval(60.0*Double(vc.expiresLabel.text!)!)
            
            let promo = vc.nameLabel.text!
            let repetition = vc.repetitionLabel.text!
            let retail = vc.retailLabel.text!
            savePromotion(promo, expiry: expiryDate, repetition: repetition, retail: retail)
//            Promotion.createPromotion(inManagedObjectContext: self.managedObjectContext, id: <#T##Int#>, promo: <#T##String#>, repetition: <#T##Int#>, retail_value: <#T##Float#>, expiry: <#T##NSDate#>, restaurant: <#T##Restaurant#>)
        }
    }
    
    var promotions = [Promotion]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    private func processResponse(response: JSON) {
        var currentPromotions = [Promotion]()
        
        for tuple in response {
            let promo = tuple.1
            
            let promotionRequest = NSFetchRequest(entityName: "Promotion")
            promotionRequest.predicate = NSPredicate(format: "id==%d", promo["id"].int!)
            let promotions = (try? self.managedObjectContext!.executeFetchRequest(promotionRequest)) as! [Promotion]
            

            if promotions.count > 0 {
                let promotion = promotions[0]
                let claimed = promo["claimed"].int!
                let redeemed = promo["redeemed"].int!
                promotion.setValue(claimed, forKey: "number_claimed")
                promotion.setValue(redeemed, forKey: "number_redeemed")
                currentPromotions.append(promotion)
            }
        }
        
        promotions = currentPromotions
    }
    
    private func savePromotion(promo: String, expiry: NSDate, repetition: String, retail: String) {
        let dateFormatter: NSDateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        let expiryString = dateFormatter.stringFromDate(expiry)
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            let data = ["text": promo, "expiration": expiryString, "repetition": repetition, "retail_value": retail]
            let (response, status) = HttpService.doRequest("/api/promotion/", method: "POST", data: data, flag: true, synchronous: true)
            dispatch_async(dispatch_get_main_queue()) {
                if status {
                    // TODO: don't assign restaurant to nil
                    Promotion.createPromotion(inManagedObjectContext: self.managedObjectContext!, id: response!["id"].int!, promo: promo, repetition: Int(repetition)!, retail_value: Float(retail)!, expiry: expiry, number_claimed: 0, number_redeemed: 0)
                    self.fetchPromotions()
                    
                    do {
                        try self.managedObjectContext!.save()
                    } catch {
    
                    }
                }
            }
        }
        
    }
    
    func fetchPromotions() {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            let (listResponse, listStatus) = HttpService.doRequest("/api/promotion/details/", method: "GET", data: nil, flag: true, synchronous: true)
            dispatch_async(dispatch_get_main_queue()) {
                
                if listStatus {
                    self.processResponse(listResponse!)
                }
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return promotions.count
    }

    private let cellIdentifier = "PromotionCell"
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath)
        
        if let promotionCell = cell as? PromotionTableViewCell {
            promotionCell.data = promotions[indexPath.row]
        }
        
        // Configure the cell...
        
        return cell
    }


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
