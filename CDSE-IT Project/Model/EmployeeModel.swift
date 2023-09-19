//
//  EmployeeModel.swift
//  CDSE-IT Project
//
//  Created by SUMIT on 14/09/23.
//

import Foundation

// MARK: - EmployeeModel
struct EmployeeModel: Decodable {
    var empNo: Int
    var birthDate: String
    var firstName, lastName, gender: String?
    var hireDate: String?
    var salary: [SalaryModel]?
    var titles: [TitleModel]?
    var employeeDeparts: [EmployeeDepartmentModel]?

    enum CodingKeys: String, CodingKey {
        case empNo = "emp_no"
        case birthDate = "birth_date"
        case firstName = "first_name"
        case lastName = "last_name"
        case gender
        case hireDate = "hire_date"
    }
}

// MARK: - SalaryModel
struct SalaryModel: Decodable {
    var empNo: Int
    var salary: Int
    var fromDate, toDate: String

    enum CodingKeys: String, CodingKey {
        case empNo = "emp_no"
        case salary
        case fromDate = "from_date"
        case toDate = "to_date"
    }
}


// MARK: - TitleModel
struct TitleModel: Decodable {
    var empNo: Int
    var title: String
    var fromDate, toDate: String

    enum CodingKeys: String, CodingKey {
        case empNo = "emp_no"
        case title
        case fromDate = "from_date"
        case toDate = "to_date"
    }
}

// MARK: - EmployeeDepartmentModel
struct EmployeeDepartmentModel: Codable {
    var empNo: Int
    var deptNo: String
    var fromDate, toDate: String

    enum CodingKeys: String, CodingKey {
        case empNo = "emp_no"
        case deptNo = "dept_no"
        case fromDate = "from_date"
        case toDate = "to_date"
    }
}

// MARK: - DepartmentModel
struct DepartmentModel: Decodable {
    var deptNo: String
    var deptName: String

    enum CodingKeys: String, CodingKey {
        case deptNo = "dept_no"
        case deptName = "dept_name"
    }
}

// MARK: - DepartmentManagerModel
struct DepartmentManagerModel: Decodable {
    var empNo: Int
    var deptNo: String
    var fromDate, toDate: String?

    enum CodingKeys: String, CodingKey {
        case empNo = "emp_no"
        case deptNo = "dept_no"
        case fromDate = "from_date"
        case toDate = "to_date"
    }
}
