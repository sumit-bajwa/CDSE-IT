//
//  EmployeesRecordVC.swift
//  CDSE-IT Project
//
//  Created by SUMIT on 17/09/23.
//

import UIKit

class EmployeesRecordVC: UIViewController {

    //MARK: IBOutlets
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var totalEmployeesLbl: UILabel!
    
    
    //MARK: Variables
    var employees = [EmployeeModel]()
    var totalRecords = 0
    private let databaseManager = DatabaseManager()

    
    //lets change it and call it code of main branch
    override func viewDidLoad() {
        super.viewDidLoad()
        datePicker.datePickerMode = .date
        datePicker.timeZone = TimeZone.current
        let date = datePicker.date.convertToString().convertToDate() ?? Date()
        fetchFirst400Records(date: date)

    }
    
    //MARK: Fetch first 400 records
    func fetchFirst400Records(date: Date) {
        let employees = self.databaseManager.fetchEmployees(selectedDate: date)
        self.employees = employees.0
        
        totalEmployeesLbl.text = "Total Employees:- \(employees.1)"
        self.tableView.reloadData()
    }
    
    //MARK: Date Picker Value Changed Button
    @IBAction func datePickerValueChanged(_ sender: UIDatePicker) {
        let selectedDate = sender.date.convertToString().convertToDate() ?? Date()
        fetchFirst400Records(date: selectedDate)
    }
    
    //MARK: Back Button Action
    @IBAction func backBtnAct(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

//MARK: UITableViewDelegate and UITableViewDataSource
extension EmployeesRecordVC: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return employees.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EmployeeRecordDetailCell") as! EmployeeRecordDetailCell

            let employeeDetail = employees[indexPath.row]
            cell.nameLbl.text = (employeeDetail.firstName ?? "") + " " + (employeeDetail.lastName ?? "")
            cell.genderLbl.text = employeeDetail.gender == "M" ? "Male" : "Female"
            cell.joingDateLbl.text = employeeDetail.hireDate ?? ""
            let joinDate = employeeDetail.hireDate ?? ""
            let dateFormatter = DateFormatter()
            dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
            dateFormatter.dateFormat = "yyyy-MM-dd"
        
        
            
        cell.salaryLbl.text = "-"
        cell.totalTimeLbl.text = "-"
        if let currentSalary = employeeDetail.salary?.max(by: { (dateFormatter.date(from: $0.toDate) ?? Date()) < (dateFormatter.date(from: $1.toDate) ?? Date()) }) {
            cell.salaryLbl.text = "Rs \(currentSalary.salary )"
        }
        
        if let employeeDepart = employeeDetail.employeeDeparts?.max(by: { (dateFormatter.date(from: $0.toDate) ?? Date()) < (dateFormatter.date(from: $1.toDate) ?? Date()) }) {
            if let joinDate = dateFormatter.date(from: joinDate),
               let lastDate = dateFormatter.date(from: employeeDepart.toDate)
            {
                let exactLastDate = lastDate > Date() ? Date() : lastDate
                let components = Calendar.current.dateComponents([.year,.month,.day], from: joinDate,to: exactLastDate)
                if let years = components.year {
                    cell.totalTimeLbl.text = "\(years)" + " \(years > 1 ? "years" : "year")"
                   }
                else {
                    print("Unable to calculate the difference.")
                }
                
            } else {

                print("Invalid date format")
            }

        }

        return cell
    }
}

//MARK: EmployeeRecordDetailCell
class EmployeeRecordDetailCell : UITableViewCell {
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var genderLbl: UILabel!
    @IBOutlet weak var joingDateLbl: UILabel!
    @IBOutlet weak var totalTimeLbl: UILabel!
    @IBOutlet weak var salaryLbl: UILabel!
}
