//
//  DateExtension.swift
//  CDSE-IT Project
//
//  Created by SUMIT on 18/09/23.
//

import UIKit

//Date to String
extension Date {
    func convertToString(withFormat format: String = "yyyy-MM-dd") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
//        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        return dateFormatter.string(from: self)
    }
}

// String to Date
extension String {
    func convertToDate(withFormat format: String = "yyyy-MM-dd") -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        return dateFormatter.date(from: self)
    }
}
