//
//  OpenWeatherMapAPI.swift
//  WeatherApp
//

//

import Foundation

public final class OpenWeatherMapAPI {
    private let apiKey: String = "5dfc577c1d7d94e9e23a00431582f1ac"
    // 摂氏度にするオプション
    private let units: String = "metric"
    // 日本語にするオプション
    private let lang: String = "ja"
    // 取得するデータ数を制限するオプション（３時間＊８個　＝　２４時間分）
    private let cnt: String = "8"

    /// 緯度経度を元に、天気情報を取得するAPI
    public struct SearchWeatherData: APIRequest {
        public let latitude: Double
        public let longitude: Double
        // APIRequestが要求する連想型？
        public typealias Response = WeatherData

        public var queryItems: [URLQueryItem] {
            return [URLQueryItem(name: "lat", value: String(latitude)),
                    URLQueryItem(name: "lon", value: String(longitude)),
                    URLQueryItem(name: "appid", value: OpenWeatherMapAPI().apiKey),
                    URLQueryItem(name: "units", value: OpenWeatherMapAPI().units),
                    URLQueryItem(name: "lang", value: OpenWeatherMapAPI().lang),
                    URLQueryItem(name: "cnt", value: OpenWeatherMapAPI().cnt)]
        }
    }
    /// 都市名を元に、天気情報を取得するAPI
    public struct SearchWeatherDataFromCityName: APIRequest {
        public let cityName: String
        // APIRequestが要求する連想型？
        public typealias Response = WeatherData

        public var queryItems: [URLQueryItem] {
            return [URLQueryItem(name: "q", value: cityName),
                    URLQueryItem(name: "appid", value: OpenWeatherMapAPI().apiKey),
                    URLQueryItem(name: "units", value: OpenWeatherMapAPI().units),
                    URLQueryItem(name: "lang", value: OpenWeatherMapAPI().lang),
                    URLQueryItem(name: "cnt", value: OpenWeatherMapAPI().cnt)]
        }
    }
}
