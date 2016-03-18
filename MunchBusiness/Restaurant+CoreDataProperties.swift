//
//  Restaurant+CoreDataProperties.swift
//  MunchBusiness
//
//  Created by Alexander Tran on 3/18/16.
//  Copyright © 2016 Alexander Tran. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Restaurant {

    @NSManaged var address: String?
    @NSManaged var distance: NSNumber?
    @NSManaged var hours: String?
    @NSManaged var id: NSNumber?
    @NSManaged var latitude: NSNumber?
    @NSManaged var longitude: NSNumber?
    @NSManaged var name: String?
    @NSManaged var phone_number: String?

}
