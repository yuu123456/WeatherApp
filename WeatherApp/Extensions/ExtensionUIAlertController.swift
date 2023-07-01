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
    /// 通知をスケジューリングした際にダイアログを表示するメソッド
    static func showNotificationDialog(_ viewController: UIViewController, title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in

        }
        alert.addAction(okAction)
        viewController.present(alert, animated: true)
    }
    /// 通知希望時間選択ダイアログの表示
    static func showTimePickerAlert(_ viewController: UIViewController) {
        let title = "通知したい時間を選択"
        let message: String? = nil
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

        // 時間を選択するピッカービューを作成し、ダイアログに追加する
        let pickerView = UIDatePicker()
        pickerView.datePickerMode = .time
        pickerView.locale = Locale.current
        pickerView.timeZone = TimeZone.current
        alert.view.addSubview(pickerView)

        // ピッカービューの制約を設定
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            // tirleとactionButtoに被らないように５０ポイントを指定（
            pickerView.topAnchor.constraint(equalTo: alert.view.topAnchor, constant: 50),
            pickerView.bottomAnchor.constraint(equalTo: alert.view.bottomAnchor, constant: -50),
            // ダイアログのセンターに指定
            pickerView.centerXAnchor.constraint(equalTo: alert.view.centerXAnchor)
        ])

        let cancelAction = UIAlertAction(title: "キャンセル", style: .cancel) { _ in
            print("通知時間の設定をキャンセルしました")
        }
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            let selectedTime = pickerView.date
            // 選択された時間に通知を設定する
            UserNotificationUtil.shared.setNotification(from: viewController, selectedTime: selectedTime)
        }
        alert.addAction(cancelAction)
        alert.addAction(okAction)
        viewController.present(alert, animated: true, completion: nil)
    }

}
