//
//  PromotionTableViewCell.swift
//  MunchBusiness
//
//  Created by Alexander Tran on 3/17/16.
//  Copyright © 2016 Alexander Tran. All rights reserved.
//

import UIKit

class PromotionTableViewCell: UITableViewCell {
    
    var data: Promotion? {
        didSet {
            updateUI()
        }
    }
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var retailLabel: UILabel!
    @IBOutlet weak var expiryLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var claimedLabel: UILabel!
    @IBOutlet weak var redeemedLabel: UILabel!
    
    private func updateUI() {
        if let data = data {
            let numberFormatter = NSNumberFormatter()
            numberFormatter.minimumFractionDigits = 2
            numberFormatter.maximumFractionDigits = 2
            
            nameLabel.text = data.promo!
            retailLabel.text = "Worth $" + numberFormatter.stringFromNumber(data.retail_value!)!
            let date = data.expiry!
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateStyle = .NoStyle
            dateFormatter.timeStyle = .ShortStyle
            
            expiryLabel.text = "Expires at " + dateFormatter.stringFromDate(date)
            totalLabel.text = String(data.repetition!) + " Total"
            claimedLabel.text = String(data.number_claimed!) + " Claimed"
            redeemedLabel.text = String(data.number_redeemed!) + " Redeemed"
        }
    }
}
