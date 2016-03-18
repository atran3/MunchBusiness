//
//  MainNavigationController.swift
//  MunchBusiness
//
//  Created by Alexander Tran on 3/17/16.
//  Copyright © 2016 Alexander Tran. All rights reserved.
//

import UIKit

class MainNavigationController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        self.navigationBar.topItem?.title = ""
        self.navigationBar.topItem?.titleView = Util.getLogoTitle()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
