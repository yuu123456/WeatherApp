//
//  SelectDataModel.swift
//  WeatherApp
//

//

import Foundation

struct DataModel {
    var location: String?

    func getCurrentFormattedDate() -> String {
        let today = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy年MM月dd日"
        let date = formatter.string(from: today)
        return date
    }
}
