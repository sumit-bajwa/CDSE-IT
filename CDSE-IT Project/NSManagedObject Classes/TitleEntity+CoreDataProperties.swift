//
//  TitleEntity+CoreDataProperties.swift
//  CDSE-IT Project
//
//  Created by SUMIT on 17/09/23.
//
//

import Foundation
import CoreData


extension TitleEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TitleEntity> {
        return NSFetchRequest<TitleEntity>(entityName: "TitleEntity")
    }

    @NSManaged public var empNo: Int32
    @NSManaged public var fromDate: Date
    @NSManaged public var title: String
    @NSManaged public var toDate: Date
    @NSManaged public var toEmployee: EmployeeEntity?

}

extension TitleEntity : Identifiable {

}
