//
//  APIClientError.swift
//  WeatherApp
//

//

import Foundation
import UIKit
/// APIクライアント内部で発生するエラーを表す型
public enum APIClientError: Error {
    // 通信に失敗
    case connectionError
//    case connectionError(Error)
    // レスポンスの解釈に失敗
    case responseParseError
//    case responseParseError(Error)
    // APIからエラーレスポンスを受け取った
    case apiError
//    case apiError(APIError)
    /// ダイアログのタイトル
    var title: String {
        switch self {
        case .connectionError:
            return "通信エラー"
        case .responseParseError:
            return "デコードエラー"
        case .apiError:
            return "APIエラー"
        }
    }
    /// ダイアログのメッセージ
    var message: String {
        switch self {
        case .connectionError:
            return "通信環境を確認してください。"
        case .responseParseError:
            return "デコードエラーです。開発者にお問い合わせください。"
        case .apiError:
            return "APIエラーです。開発者にお問い合わせください。"
        }
    }
    /// ダイアログを表示するメソッド
    func showAlert(from: UIViewController) {
        UIAlertController.showAPIClientErrorDialog(error: self, from)
    }
}
