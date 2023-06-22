//
//  GETWeatherIcon.swift
//  WeatherApp
//

//

import UIKit

final class GetWeatherIcon {
    //唯一のインスタンスを持つ必要性がないため、シングルトンでなくて良い
    /// 取得した天気アイコンIdから、天気アイコン画像を取得するメソッド。取得した画像をクロージャに渡す。
    static func getWeatherIcon(iconId: String, completion: @escaping (UIImage?) -> Void) {
        // アイコン画像を取得するURLの生成
        let weatherIconURL = URL(string: "https://openweathermap.org/img/w/\(iconId).png")
        // URLリクエストして、レスポンスを受け取る
        if let weatherIconURL = weatherIconURL {
            URLSession.shared.dataTask(with: weatherIconURL) { (data, _, error) in
                if let error = error {
                    print("アイコンダウンロードエラー：\(error)" )
                    completion(nil)
                    return
                }

                if let data = data, let weatherIcon = UIImage(data: data) {
                    completion(weatherIcon)
                } else {
                    completion(nil)
                }
            }.resume()
        } else {
            print("URLが不正です")
        }
    }
}
