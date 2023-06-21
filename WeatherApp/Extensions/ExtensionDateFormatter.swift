//
//  ExtensionDateFormatter.swift
//  WeatherApp
//

//

import Foundation

extension DateFormatter {
    /// Labelに表示する漢字表記yyyy年MM月dd日に変換するフォーマッター
    static var formatterJapaneseDate: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy年MM月dd日"
        dateFormatter.timeZone = TimeZone.current
        return dateFormatter
    }

    /// グラフに表示する日本時間HH:mmに変換するフォーマッター
    static var formatterJapaneseDateForChartsAndTableView: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale.current
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter
    }
}
