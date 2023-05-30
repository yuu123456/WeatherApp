//
//  ExtensionDate.swift
//  WeatherApp
//

//

import Foundation

extension Date {
    //現在の日付を変換する
    func getCurrentFormattedDate() -> String {
        let today = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy年MM月dd日"
        let date = formatter.string(from: today)
        return date
    }
}
