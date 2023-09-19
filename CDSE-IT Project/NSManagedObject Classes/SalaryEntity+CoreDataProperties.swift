//
//  SalaryEntity+CoreDataProperties.swift
//  CDSE-IT Project
//
//  Created by SUMIT on 17/09/23.
//
//

import Foundation
import CoreData


extension SalaryEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SalaryEntity> {
        return NSFetchRequest<SalaryEntity>(entityName: "SalaryEntity")
    }

    @NSManaged public var empNo: Int32
    @NSManaged public var fromDate: Date
    @NSManaged public var salary: Int32
    @NSManaged public var toDate: Date
    @NSManaged public var toEmployee: EmployeeEntity?

}

extension SalaryEntity : Identifiable {

}
