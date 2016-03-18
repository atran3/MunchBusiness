//
//  Promotion.swift
//  MunchBusiness
//
//  Created by Alexander Tran on 3/17/16.
//  Copyright © 2016 Alexander Tran. All rights reserved.
//

import Foundation
import CoreData


class Promotion: NSManagedObject {

    class func createPromotion(inManagedObjectContext context: NSManagedObjectContext, id: Int, promo: String, repetition: Int, retail_value: Float, expiry: NSDate, number_claimed: Int, number_redeemed: Int) -> Promotion? {
        
        let promotionRequest = NSFetchRequest(entityName: "Promotion")
        promotionRequest.predicate = NSPredicate(format: "id==%d", id)
        let promotions = (try? context.executeFetchRequest(promotionRequest)) as! [Promotion]
        
        if promotions.count == 1 {
            return updatePromotion(inManagedObjectContext: context, promo: promo, repetition: repetition, retail_value: retail_value, expiry: expiry, promotion: promotions[0], number_claimed: number_claimed, number_redeemed: number_redeemed)
        }
        
        if let newPromotion = NSEntityDescription.insertNewObjectForEntityForName("Promotion", inManagedObjectContext: context) as? Promotion {
            newPromotion.id = id
            newPromotion.promo = promo
            newPromotion.repetition = repetition
            newPromotion.retail_value = retail_value
            newPromotion.expiry = expiry
            newPromotion.number_claimed = number_claimed
            newPromotion.number_redeemed = number_redeemed
            return newPromotion
        }
        return nil
    }
    
    class func updatePromotion(inManagedObjectContext context: NSManagedObjectContext, promo: String, repetition: Int, retail_value: Float, expiry: NSDate, promotion: Promotion, number_claimed: Int, number_redeemed: Int) -> Promotion? {
        promotion.setValue(promo, forKey: "promo")
        promotion.setValue(repetition, forKey: "repetition")
        promotion.setValue(retail_value, forKey: "retail_value")
        promotion.setValue(expiry, forKey: "expiry")
        promotion.setValue(number_claimed, forKey: "number_claimed")
        promotion.setValue(number_redeemed, forKey: "number_redeemed")
        return promotion
    }
}
