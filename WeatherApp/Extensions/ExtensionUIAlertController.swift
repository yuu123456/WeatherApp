//
//  ExtensionUIAlertController.swift
//  WeatherApp
//

//

import UIKit

extension UIAlertController {
    /// APIエラーが生じた際にダイアログを表示するメソッド
    static func showAPIClientErrorDialog(error: APIClientError, _ viewController: UIViewController) {
        let title = error.title
        let message = error.message
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            // 前画面に戻す
            viewController.dismiss(animated: true)
        }
        alert.addAction(okAction)
        viewController.present(alert, animated: true)
    }
}
