//
//  ExtensionDateFormatter.swift
//  WeatherApp
//

//

import Foundation

extension DateFormatter {
    //漢字表記yyyy年MM月dd日に変換
    static var formattJananiseDate: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy年MM月dd日"
        dateFormatter.timeZone = TimeZone.current
        return dateFormatter
    }
}
