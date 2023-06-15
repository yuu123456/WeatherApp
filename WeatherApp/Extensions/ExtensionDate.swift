//
//  ExtensionDate.swift
//  WeatherApp
//

//

import Foundation

extension Date {
    // 日付を"yyyy年MM月dd日"形式に変換する
    var japaneseDateStyle: String {
        return DateFormatter.formatJapaneseDate.string(from: self)
    }
}
