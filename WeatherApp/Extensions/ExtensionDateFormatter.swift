//
//  ExtensionDateFormatter.swift
//  WeatherApp
//

//

import Foundation

extension DateFormatter {
    /// 漢字表記yyyy年MM月dd日に変換
    static var formatJapaneseDate: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy年MM月dd日"
        dateFormatter.timeZone = TimeZone.current
        return dateFormatter
    }

    /// グラフに表示する日本時間に変換
    static var formatJapaneseDateForDisplay: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale.current
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter
    }
}
