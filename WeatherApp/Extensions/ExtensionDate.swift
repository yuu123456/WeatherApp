//
//  ExtensionDate.swift
//  WeatherApp
//

//

import Foundation

extension Date {
    /// Labelに表示する漢字表記yyyy年MM月dd日に変換する
    var formatJapaneseDateStyle: String {
        return DateFormatter.formatterJapaneseDate.string(from: self)
    }

    /// グラフに表示する日本時間HH:mmに変換する
    var formatJapaneseDateStyleForChartsAndTableView: String {
        return DateFormatter.formatterJapaneseDateForChartsAndTableView.string(from: self)
    }

    /// セクションに表示する日付"MM月dd日"に変換する
    var formatJapaneseDateStyleForTableViewSection: String {
        return DateFormatter.formatterJapaneseDateForTableViewSection.string(from: self)
    }
}
