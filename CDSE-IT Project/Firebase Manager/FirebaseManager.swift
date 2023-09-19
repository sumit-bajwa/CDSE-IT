//
//  FirebaseManager.swift
//  CDSE-IT Project
//
//  Created by SUMIT on 14/09/23.
//

import Foundation

import FirebaseStorage
import UIKit

//MARK: Firebase Manager
class FirebaseManager {
    static let shared = FirebaseManager()
    private let databaseManager = DatabaseManager()
    var salaries = [SalaryModel]()
    var employeesDepartments = [EmployeeDepartmentModel]()
    var titles = [TitleModel]()
    var employees = [EmployeeModel]()
    var departments = [DepartmentModel]()
    var departmentManagers = [DepartmentManagerModel]()
    var fileReferences = [StorageReference]()

    //download json files from firebase storage
    func retrieveFileFromFirebaseStorage() {
        guard  Reachability.isConnectedToNetwork() else {
            AlertHelper.showAlert(in: UIApplication.topViewController(),title: "", message: "Internet Connection unavailable!", okActionHandler: nil)
            return
        }

        UIApplication.topViewController().showActivityIndicator()
        let storage = Storage.storage()
        fileReferences = [
                                  storage.reference().child("salaries.json"),
                                  storage.reference().child("titles.json"),
                                  storage.reference().child("department_manager.json"),
                                  storage.reference().child("departments.json"),
                                  storage.reference().child("emp_departments.json"),
        ]
        let downloadGroup = DispatchGroup()
        
        for fileReference in fileReferences {
            downloadGroup.enter()
            
            let localFileURL = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(fileReference.name)
            
            // Download the file to the local file URL
            fileReference.write(toFile: localFileURL) { [self] url, error in
                if let error = error {
                    print("Error downloading file \(fileReference.name): \(error.localizedDescription)")
                } else if let url = url {
                    // The file was successfully downloaded to the local URL
                    print("File downloaded to: \(url.path)")
                    
                    if let data = try? Data(contentsOf: url) {
                        if  let salaries = try? JSONDecoder().decode([SalaryModel].self, from: data) {
                            self.salaries = salaries
                            print("Total salaries :-- \(self.salaries.count)")
                            for (_,salary) in self.salaries.enumerated() {
                                self.databaseManager.saveSalary(salary: salary)
                            }
                        }
                        else if let titles = try? JSONDecoder().decode([TitleModel].self, from: data) {
                            self.titles = titles
                            print("Total titles :-- \(self.titles.count)")
                            for (_,title) in self.titles.enumerated() {
                                self.databaseManager.saveTitle(title: title)
                            }
                        }
                        else if let departmentManagers = try? JSONDecoder().decode([DepartmentManagerModel].self, from: data),
                                departmentManagers.count < 100
                        {
                            self.departmentManagers = departmentManagers
                            print("Total Department Managers :-- \(self.departmentManagers.count)")
                            for (_,departmentManager) in self.departmentManagers.enumerated() {
                                self.databaseManager.saveDepartmentManager(departmentManager: departmentManager)
                            }
                        }
                        else if let departments = try? JSONDecoder().decode([DepartmentModel].self, from: data) {
                            self.departments = departments
                            print("Total departments :-- \(self.departments.count)")
                            for (_,department) in self.departments.enumerated() {
                                self.databaseManager.saveDepartment(department: department)
                            }
                        }
                        else if let employeeDepartments = try? JSONDecoder().decode([EmployeeDepartmentModel].self, from: data) {
                            self.employeesDepartments = employeeDepartments
                            print("Total Employee Departments :-- \(self.employeesDepartments.count)")
                            for (_,employeeDepartment) in self.employeesDepartments.enumerated() {
                                self.databaseManager.saveEmployeeDepartment(employeeDepartment: employeeDepartment)
                            }
                        }
                        downloadGroup.leave()
                    }
                }
            }
        }
        downloadGroup.notify(queue: .main) {
            print("All downloads completed. Proceeding to download employees.json.")
            let storage = Storage.storage()
            let ref = storage.reference().child("employees.json")
            let localFileURL = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(ref.name)
            
            ref.write(toFile: localFileURL) { [self] url, error in
                if let error = error {
                    print("Error downloading file \(ref.name): \(error.localizedDescription)")
                } else if let url = url {
                    print("File downloaded to: \(url.path)")
                    if let data = try? Data(contentsOf: url),
                       let employees = try? JSONDecoder().decode([EmployeeModel].self, from: data){
                        self.employees = employees
                        print("Total Employees :-- \(self.employees.count)")
                        for (_,employee) in self.employees.enumerated() {
                            self.databaseManager.saveEmployee(employee: employee)
                        }
                    }
                    UIApplication.topViewController().hideActivityIndicator()
                    AlertHelper.showAlert(in: UIApplication.topViewController(), message: "Employees record fetched and stored successfully ")
                }
            }
        }
    }
}
