//
//  DatabaseManager.swift
//  CDSE-IT Project
//
//  Created by SUMIT on 14/09/23.
//

import UIKit
import CoreData

//MARK: Database Manager
class DatabaseManager {
    
    // This managed object context is used for Core Data operations.
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    //MARK: Save employee
    func saveEmployee(employee: EmployeeModel) {
        let fetchRequest: NSFetchRequest<EmployeeEntity> = EmployeeEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "empNo == %d", Int32(employee.empNo))
        
        var salaries = [SalaryEntity]()
        var titles = [TitleEntity]()
        var empDeparts = [EmployeeDepartmentEntity]()
        let salaryFetchRequest = NSFetchRequest<NSManagedObject>(entityName: "SalaryEntity")
        salaryFetchRequest.predicate = NSPredicate(format: "empNo == %d", Int32(employee.empNo))
        let titleFetchRequest = NSFetchRequest<NSManagedObject>(entityName: "TitleEntity")
        titleFetchRequest.predicate = NSPredicate(format: "empNo == %d", Int32(employee.empNo))
        let empDepartRequest = NSFetchRequest<NSManagedObject>(entityName: "EmployeeDepartmentEntity")
        empDepartRequest.predicate = NSPredicate(format: "empNo == %d", Int32(employee.empNo))


        do {
            salaries = try context.fetch(salaryFetchRequest) as! [SalaryEntity]
            titles = try context.fetch(titleFetchRequest) as! [TitleEntity]
            empDeparts = try context.fetch(empDepartRequest) as! [EmployeeDepartmentEntity]
            
            let existingEmployee = try context.fetch(fetchRequest).first
            if let _ = existingEmployee {
                // A record with the same employeeNumber already exists.
                // Handle the duplicate or display an error message.
            } else {
                let employeeEntity =  EmployeeEntity(context: context)
                employeeEntity.empNo = Int32(employee.empNo)
                employeeEntity.birthDate = employee.birthDate
                employeeEntity.firstName = employee.firstName
                employeeEntity.lastName = employee.lastName
                employeeEntity.gender = employee.gender
                employeeEntity.hireDate = employee.hireDate?.convertToDate()
                employeeEntity.toSalary = Set(salaries)
                employeeEntity.toTitle = Set(titles)
                employeeEntity.toEmployeeDepart = Set(empDeparts)

                try context.save()
            }
        }
        catch {
           print("employee saving error")
        }

    }
    
    //MARK: Fetch employees
    func fetchEmployees(selectedDate: Date) -> ([EmployeeModel],Int) {
        var employees = [EmployeeModel]()
        var totalEmployeesCount = 0
        
        let fetchRequestForSort: NSFetchRequest<EmployeeEntity> = EmployeeEntity.fetchRequest()
        let fetchRequestForCount: NSFetchRequest<EmployeeEntity> = EmployeeEntity.fetchRequest()

        let sortDescriptor = NSSortDescriptor(key: "hireDate", ascending: true)
        fetchRequestForSort.sortDescriptors = [sortDescriptor]
        let predicate = NSPredicate(format: "hireDate >= %@", selectedDate as NSDate)
        fetchRequestForSort.predicate = predicate
        fetchRequestForSort.fetchLimit = 400

        do {
            let employeeFetchRequest = try context.fetch(fetchRequestForSort)
            totalEmployeesCount = try context.fetch(fetchRequestForCount).count
            
            for emp in employeeFetchRequest {
                var salaryArray = [SalaryModel]()
                var titleArray = [TitleModel]()
                var employeeDepartArray = [EmployeeDepartmentModel]()
                if let salaries = emp.toSalary {
                    for salary in salaries {
                        let salaryModel = SalaryModel(empNo: Int(salary.empNo),salary: Int(salary.salary),fromDate: salary.fromDate.convertToString(),toDate: salary.toDate.convertToString())
                        salaryArray.append(salaryModel)
                    }
                }
                if let titles = emp.toTitle {
                    for title in titles {
                        let titleModel = TitleModel(empNo: Int(title.empNo), title: title.title,fromDate: title.fromDate.convertToString(),toDate: title.toDate.convertToString())
                        titleArray.append(titleModel)
                    }
                }
                if let empDeparts = emp.toEmployeeDepart {
                    for empDepart in empDeparts {
                        let employeeDepartModel = EmployeeDepartmentModel(empNo: Int(empDepart.empNo), deptNo: empDepart.deptNo,fromDate: empDepart.fromDate.convertToString(),toDate: empDepart.toDate.convertToString())
                        employeeDepartArray.append(employeeDepartModel)
                    }
                }
                let employee = EmployeeModel(empNo: Int(emp.empNo), birthDate: emp.birthDate, firstName: emp.firstName, lastName: emp.lastName, gender: emp.gender, hireDate: emp.hireDate?.convertToString(),salary: salaryArray,titles: titleArray,employeeDeparts: employeeDepartArray)
                employees.append(employee)
            }
            
        }
        catch {
            print("can not get data")
        }
        return (employees,totalEmployeesCount)
    }
    
    //MARK: Save Salary
    func saveSalary(salary: SalaryModel) {
        let fetchRequest: NSFetchRequest<SalaryEntity> = SalaryEntity.fetchRequest()
        

        let empNoPredicate = NSPredicate(format: "empNo == %d", Int32(salary.empNo))
        let titlePredicate = NSPredicate(format: "salary == %d", Int32(salary.salary))
        let compoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [empNoPredicate, titlePredicate])
        fetchRequest.predicate = compoundPredicate
        
        do {
            let existingSalary = try context.fetch(fetchRequest).first
            if let _ = existingSalary {
                // A record with the same employeeNumber already exists.
                // Handle the duplicate or display an error message.
            } else {
                let salaryEntity = SalaryEntity(context: context)
                salaryEntity.empNo = Int32(salary.empNo)
                salaryEntity.salary = Int32(salary.salary)
                salaryEntity.fromDate = salary.fromDate.convertToDate() ?? Date()
                salaryEntity.toDate = salary.toDate.convertToDate() ?? Date()

                try context.save()
            }
        }
        catch {
           print("salary saving error")
        }
    }
    
    //MARK: Fetch Salary
    func fetchSalaries() -> [SalaryModel] {
        var salaries = [SalaryModel]()
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "SalaryEntity")
        do {
            salaries = try context.fetch(fetchRequest) as! [SalaryModel]
        }
        catch {
            print("can not get data")
        }
        return salaries
    }

    //MARK: Save Salary
    func saveTitle(title: TitleModel) {
        let fetchRequest: NSFetchRequest<TitleEntity> = TitleEntity.fetchRequest()
        let empNoPredicate = NSPredicate(format: "empNo == %d", Int32(title.empNo))
        let titlePredicate = NSPredicate(format: "title == %@", title.title)
        let compoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [empNoPredicate, titlePredicate])

        fetchRequest.predicate = compoundPredicate

        do {
            let existingTitle = try context.fetch(fetchRequest).first
            if let _ = existingTitle {
                // A record with the same employeeNumber already exists.
                // Handle the duplicate or display an error message.
            } else {
                let titleEntity = TitleEntity(context: context)
                titleEntity.empNo = Int32(title.empNo)
                titleEntity.title = title.title
                titleEntity.fromDate = title.fromDate.convertToDate() ?? Date()
                titleEntity.toDate = title.toDate.convertToDate() ?? Date()
                try context.save()
            }
        }
        catch {
           print("title saving error")
        }
    }
    
    //MARK: Fetch Salary
    func fetchTitles() -> [TitleModel] {
        var titles = [TitleModel]()
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "TitleEntity")
        do {
            titles = try context.fetch(fetchRequest) as! [TitleModel]
        }
        catch {
            print("can not get data")
        }
        return titles
    }
    
    
    //MARK: Save Employee Department
    func saveEmployeeDepartment(employeeDepartment: EmployeeDepartmentModel) {
        let fetchRequest: NSFetchRequest<EmployeeDepartmentEntity> = EmployeeDepartmentEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "empNo == %d", Int32(employeeDepartment.empNo))

        do {
            let existingEmployeeDepartment = try context.fetch(fetchRequest).first
            if let _ = existingEmployeeDepartment {
                // A record with the same employeeNumber already exists.
                // Handle the duplicate or display an error message.
            } else {
                let employeeDepartmentEntity = EmployeeDepartmentEntity(context: context)
                employeeDepartmentEntity.empNo = Int32(employeeDepartment.empNo)
                employeeDepartmentEntity.deptNo = employeeDepartment.deptNo
                employeeDepartmentEntity.fromDate = employeeDepartment.fromDate.convertToDate() ?? Date()
                employeeDepartmentEntity.toDate = employeeDepartment.toDate.convertToDate() ?? Date()
                try context.save()
            }
        }
        catch {
           print("employee department saving error")
        }
    }
    
    //MARK: Fetch Employee Department
    func fetchEmployeeDepartments() -> [EmployeeDepartmentModel] {
        var employeeDepartments = [EmployeeDepartmentModel]()
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "EmployeeDepartmentEntity")
        do {
            employeeDepartments = try context.fetch(fetchRequest) as! [EmployeeDepartmentModel]
        }
        catch {
            print("can not get data")
        }
        return employeeDepartments
    }
    
    //MARK: Save Department
    func saveDepartment(department: DepartmentModel) {
        let fetchRequest: NSFetchRequest<DepartmentEntity> = DepartmentEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "deptNo == %d", department.deptNo)

        do {
            let existingDepartment = try context.fetch(fetchRequest).first
            if let _ = existingDepartment {
                // A record with the same employeeNumber already exists.
                // Handle the duplicate or display an error message.
            } else {
                let departmentEntity = DepartmentEntity(context: context)
                departmentEntity.deptNo = department.deptNo
                departmentEntity.deptName = department.deptName
                try context.save()
            }
        }
        catch {
           print("department saving error")
        }
    }
    
    //MARK: Fetch Departments
    func fetchDepartments() -> [DepartmentModel] {
        var departments = [DepartmentModel]()
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "DepartmentEntity")
        do {
            departments = try context.fetch(fetchRequest) as! [DepartmentModel]
        }
        catch {
            print("can not get data")
        }
        return departments
    }

    
    //MARK: Save Departments
    func saveDepartmentManager(departmentManager: DepartmentManagerModel) {
        let fetchRequest: NSFetchRequest<DepartmentManagerEntity> = DepartmentManagerEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "empNo == %d", departmentManager.empNo)

        do {
            let existingDepartmentManager = try context.fetch(fetchRequest).first
            if let _ = existingDepartmentManager {
                // A record with the same employeeNumber already exists.
                // Handle the duplicate or display an error message.
            } else {
                let departmentManagerEntity = DepartmentManagerEntity(context: context)
                departmentManagerEntity.empNo = Int32(departmentManager.empNo)
                departmentManagerEntity.deptNo = departmentManager.deptNo
                departmentManagerEntity.fromDate = departmentManager.fromDate?.convertToDate()
                departmentManagerEntity.toDate = departmentManager.toDate?.convertToDate()
                try context.save()
            }
        }
        catch {
           print("department manager saving error")
        }
    }
    
    //MARK: Fetch Departments
    func fetchDepartmentManagers() -> [DepartmentManagerModel] {
        var departmentManagers = [DepartmentManagerModel]()
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "DepartmentManagerEntity")
        do {
            departmentManagers = try context.fetch(fetchRequest) as! [DepartmentManagerModel]
        }
        catch {
            print("can not get data")
        }
        return departmentManagers
    }

}
