//
//  AddOfferViewController.swift
//  MunchBusiness
//
//  Created by Alexander Tran on 3/17/16.
//  Copyright © 2016 Alexander Tran. All rights reserved.
//

import UIKit

class AddOfferViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the vi
        self.navigationController?.navigationBar.topItem?.titleView = nil
        self.navigationItem.title = "New Offer"
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
