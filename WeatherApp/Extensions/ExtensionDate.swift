//
//  ExtensionDate.swift
//  WeatherApp
//

//

import Foundation

extension Date {
    //日付を"yyyy年MM月dd日"形式に変換する
    func getCurrentFormattedDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy年MM月dd日"
        let date = formatter.string(from: self)
        return date
    }
}
