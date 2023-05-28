//
//  KariData.swift
//  WeatherApp
//

//

import Foundation
//API通信を行うまでの仮のデータ（後ほど削除）
struct KariData {
    var timeArray: [String] = []

    mutating func setTimeArray() -> [String] {
        let formatter = DateFormatter()
        formatter.dateFormat = "H:mm"
        // データ開始時刻（天気確認時の直近の時間のみ）
        let startTime = Calendar.current.date(bySettingHour: Calendar.current.component(.hour, from: Date()), minute: 0, second: 0, of: Date())!

        // データ数
        let dataCount = 9
        // 時間データを生成して配列に追加
        //Labelに使用するため、String型配列とする
        for i in 0..<dataCount {
            let time = Calendar.current.date(byAdding: .hour, value: 3*i, to: startTime)!
            let formattedTime = formatter.string(from: time)
            timeArray.append(formattedTime)
        }
        return timeArray
    }

    var weatherArray: [WeatherType] = [.thunderstorm, .snowy, .sunny, .rainy]
    var maxTempArray = [25.5, 24.5, 26.7, 36.6]
    var minTempArray = [15.0, 17.0, 20.8, 19.9]
    var humidArray = [30, 85, 50, 70]
    var rainyPercentArray: [Double] = [30, 85, 20, 50]
}
