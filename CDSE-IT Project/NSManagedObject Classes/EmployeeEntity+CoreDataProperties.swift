//
//  EmployeeEntity+CoreDataProperties.swift
//  CDSE-IT Project
//
//  Created by SUMIT on 17/09/23.
//
//

import Foundation
import CoreData


extension EmployeeEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<EmployeeEntity> {
        return NSFetchRequest<EmployeeEntity>(entityName: "EmployeeEntity")
    }

    @NSManaged public var birthDate: String
    @NSManaged public var empNo: Int32
    @NSManaged public var firstName: String?
    @NSManaged public var gender: String?
    @NSManaged public var hireDate: Date?
    @NSManaged public var lastName: String?
    @NSManaged public var toDepartManger: Set<DepartmentManagerEntity>?
    @NSManaged public var toEmployeeDepart: Set<EmployeeDepartmentEntity>?
    @NSManaged public var toSalary: Set<SalaryEntity>?
    @NSManaged public var toTitle: Set<TitleEntity>?

}

// MARK: Generated accessors for toDepartManger
extension EmployeeEntity {

    @objc(addToDepartMangerObject:)
    @NSManaged public func addToToDepartManger(_ value: DepartmentManagerEntity)

    @objc(removeToDepartMangerObject:)
    @NSManaged public func removeFromToDepartManger(_ value: DepartmentManagerEntity)

    @objc(addToDepartManger:)
    @NSManaged public func addToToDepartManger(_ values: Set<DepartmentManagerEntity>)

    @objc(removeToDepartManger:)
    @NSManaged public func removeFromToDepartManger(_ values: Set<DepartmentManagerEntity>)

}

// MARK: Generated accessors for toEmployeeDepart
extension EmployeeEntity {

    @objc(addToEmployeeDepartObject:)
    @NSManaged public func addToToEmployeeDepart(_ value: EmployeeDepartmentEntity)

    @objc(removeToEmployeeDepartObject:)
    @NSManaged public func removeFromToEmployeeDepart(_ value: EmployeeDepartmentEntity)

    @objc(addToEmployeeDepart:)
    @NSManaged public func addToToEmployeeDepart(_ values: Set<EmployeeDepartmentEntity>)

    @objc(removeToEmployeeDepart:)
    @NSManaged public func removeFromToEmployeeDepart(_ values: Set<EmployeeDepartmentEntity>)

}

// MARK: Generated accessors for toSalary
extension EmployeeEntity {

    @objc(addToSalaryObject:)
    @NSManaged public func addToToSalary(_ value: SalaryEntity)

    @objc(removeToSalaryObject:)
    @NSManaged public func removeFromToSalary(_ value: SalaryEntity)

    @objc(addToSalary:)
    @NSManaged public func addToToSalary(_ values: Set<SalaryEntity>)

    @objc(removeToSalary:)
    @NSManaged public func removeFromToSalary(_ values: Set<SalaryEntity>)

}

// MARK: Generated accessors for toTitle
extension EmployeeEntity {

    @objc(addToTitleObject:)
    @NSManaged public func addToToTitle(_ value: TitleEntity)

    @objc(removeToTitleObject:)
    @NSManaged public func removeFromToTitle(_ value: TitleEntity)

    @objc(addToTitle:)
    @NSManaged public func addToToTitle(_ values: Set<TitleEntity>)

    @objc(removeToTitle:)
    @NSManaged public func removeFromToTitle(_ values: Set<TitleEntity>)

}

extension EmployeeEntity : Identifiable {

}
