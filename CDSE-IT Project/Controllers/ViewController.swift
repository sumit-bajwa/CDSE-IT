//
//  ViewController.swift
//  CDSE-IT Project
//
//  Created by SUMIT on 14/09/23.
//

import UIKit
import Firebase
import FirebaseStorage
import CoreData

//This is the new line that i have added in the viewcontroller
class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: Fetch and Store Firebase Data Button
    @IBAction func fetchAndStoreBtnAct(_ sender: UIButton) {
        FirebaseManager.shared.retrieveFileFromFirebaseStorage()
    }
    
    
    //MARK: Show Record of Employee Button
    @IBAction func showStoredEmployeeRecordBtnAct(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "EmployeesRecordVC") as! EmployeesRecordVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
}


