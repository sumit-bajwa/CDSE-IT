//
//  EmployeeDepartmentEntity+CoreDataProperties.swift
//  CDSE-IT Project
//
//  Created by SUMIT on 17/09/23.
//
//

import Foundation
import CoreData


extension EmployeeDepartmentEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<EmployeeDepartmentEntity> {
        return NSFetchRequest<EmployeeDepartmentEntity>(entityName: "EmployeeDepartmentEntity")
    }

    @NSManaged public var deptNo: String
    @NSManaged public var empNo: Int32
    @NSManaged public var fromDate: Date
    @NSManaged public var toDate: Date
    @NSManaged public var toDepartment: DepartmentEntity?
    @NSManaged public var toEmployee: EmployeeEntity?

}

extension EmployeeDepartmentEntity : Identifiable {

}
