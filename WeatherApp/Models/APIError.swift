//
//  APIError.swift
//  WeatherApp
//

//

import Foundation

public struct APIError: Decodable, Error {
    public var message: String
}
