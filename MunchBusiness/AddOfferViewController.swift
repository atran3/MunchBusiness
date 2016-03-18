//
//  AddOfferViewController.swift
//  MunchBusiness
//
//  Created by Alexander Tran on 3/17/16.
//  Copyright © 2016 Alexander Tran. All rights reserved.
//

import UIKit

class AddOfferViewController: UIViewController {

    @IBOutlet weak var nameLabel: UITextField!
    @IBOutlet weak var repetitionLabel: UITextField!
    @IBOutlet weak var retailLabel: UITextField!
    @IBOutlet weak var expiresLabel: UITextField!
    @IBOutlet weak var createButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the vi
        self.navigationController?.navigationBar.topItem?.titleView = nil
        self.navigationItem.title = "New Offer"
        createButton.layer.cornerRadius = 5
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
