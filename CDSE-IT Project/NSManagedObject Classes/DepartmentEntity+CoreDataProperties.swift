//
//  DepartmentEntity+CoreDataProperties.swift
//  CDSE-IT Project
//
//  Created by SUMIT on 17/09/23.
//
//

import Foundation
import CoreData


extension DepartmentEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DepartmentEntity> {
        return NSFetchRequest<DepartmentEntity>(entityName: "DepartmentEntity")
    }

    @NSManaged public var deptName: String?
    @NSManaged public var deptNo: String?
    @NSManaged public var toDepartManager: NSSet?
    @NSManaged public var toEmployeeDepart: NSSet?

}

// MARK: Generated accessors for toDepartManager
extension DepartmentEntity {

    @objc(addToDepartManagerObject:)
    @NSManaged public func addToToDepartManager(_ value: DepartmentManagerEntity)

    @objc(removeToDepartManagerObject:)
    @NSManaged public func removeFromToDepartManager(_ value: DepartmentManagerEntity)

    @objc(addToDepartManager:)
    @NSManaged public func addToToDepartManager(_ values: NSSet)

    @objc(removeToDepartManager:)
    @NSManaged public func removeFromToDepartManager(_ values: NSSet)

}

// MARK: Generated accessors for toEmployeeDepart
extension DepartmentEntity {

    @objc(addToEmployeeDepartObject:)
    @NSManaged public func addToToEmployeeDepart(_ value: EmployeeDepartmentEntity)

    @objc(removeToEmployeeDepartObject:)
    @NSManaged public func removeFromToEmployeeDepart(_ value: EmployeeDepartmentEntity)

    @objc(addToEmployeeDepart:)
    @NSManaged public func addToToEmployeeDepart(_ values: NSSet)

    @objc(removeToEmployeeDepart:)
    @NSManaged public func removeFromToEmployeeDepart(_ values: NSSet)

}

extension DepartmentEntity : Identifiable {

}
