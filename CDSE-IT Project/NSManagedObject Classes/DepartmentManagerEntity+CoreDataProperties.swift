//
//  DepartmentManagerEntity+CoreDataProperties.swift
//  CDSE-IT Project
//
//  Created by SUMIT on 17/09/23.
//
//

import Foundation
import CoreData


extension DepartmentManagerEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DepartmentManagerEntity> {
        return NSFetchRequest<DepartmentManagerEntity>(entityName: "DepartmentManagerEntity")
    }

    @NSManaged public var deptNo: String?
    @NSManaged public var empNo: Int32
    @NSManaged public var fromDate: Date?
    @NSManaged public var toDate: Date?
    @NSManaged public var toDepartment: DepartmentEntity?
    @NSManaged public var toEmployee: EmployeeEntity?

}

extension DepartmentManagerEntity : Identifiable {

}
