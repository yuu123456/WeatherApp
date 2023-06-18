//
//  HTTPMethod.swift
//  WeatherApp
//

//

import Foundation
/// Web上のリソース操作を指定するメソッド（決まり文句？）
public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case head = "HEAD"
    case delete = "DELETE"
    case patch = "PATCH"
    case trace = "TRACE"
    case options = "OPTIONS"
    case connect = "CONNECT"
}
