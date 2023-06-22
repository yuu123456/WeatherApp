//
//  OpenWeatherMapAPI.swift
//  WeatherApp
//

//

import Foundation

public final class OpenWeatherMapAPI {
    /// 緯度経度を元に、天気情報を取得するAPI
    public struct SearchWeatherData: APIRequest {
        public let latitude: Double
        public let longitude: Double
        private let apiKey: String = "5dfc577c1d7d94e9e23a00431582f1ac"
        // 摂氏度にするオプション
        private let units: String = "metric"
        // 日本語にするオプション
        private let lang: String = "ja"

        // APIRequestが要求する連想型？
        public typealias Response = WeatherData

        public var method: HTTPMethod {
            return .get
        }

        public var path: String {
            return "/data/2.5/forecast"
        }

        public var queryItems: [URLQueryItem] {
            return [URLQueryItem(name: "lat", value: String(latitude)),
                    URLQueryItem(name: "lon", value: String(longitude)),
                    URLQueryItem(name: "appid", value: apiKey),
                    URLQueryItem(name: "units", value: units),
                    URLQueryItem(name: "lang", value: lang)]
        }
    }
}
