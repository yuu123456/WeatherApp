//
//  UserNotificationUtil.swift
//  WeatherApp
//

//

import UserNotifications
import UIKit
/// ユーザー（ローカル）通知に関するクラス
final class UserNotificationUtil: NSObject {
    /// 通知機能は一つのインスタンスとして、シングルトン化する
    static let shared = UserNotificationUtil()
    /// 現在のユーザー通知センターのインスタンスを取得。Center自体はユーザー通知の作成、スケジュール、管理を行うクラス
    private var center = UNUserNotificationCenter.current()

    /// Delegateの設定。AppDelegateまたはSceneDelegateで呼び出す。
    func initialize() {
        center.delegate = UserNotificationUtil.shared
    }

    /// 通知許可ダイアログを表示するメソッド
    func requestNotificationAuthorization(completion: @escaping (Result<Bool, Error>) -> Void) {
        print("ダイアログ表示")
        // ダイアログの呼び出し。isGranted：通知の許可状態のBool値、optionで通知許可を求めるものを指定する（必須）
        center.requestAuthorization(options: [.alert, .sound]) { isGranted, error in
            if let error = error {
                // エラーメッセージをデバッグログに表示する
                debugPrint(error.localizedDescription)
                completion(.failure(error))
                return
            }
            completion(.success(isGranted))
        }
    }

    /// 毎日定時にローカル通知を設定するメソッド
    func setNotification(from: UIViewController, selectedTime: Date) {
        /// 通知内容の設定
        let content = UNMutableNotificationContent()
        content.title = "これからの天気は・・・？"
        content.body = "通知をタップして、天気を確認しよう！"
        content.sound = .default
        /// 通知したい時間をDateComponentsで指定
        var dateComponents = DateComponents()
        dateComponents.hour = selectedTime.hour
        dateComponents.minute = selectedTime.minute
        /// 通知トリガーの設定
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        /// 通知リクエスト作成
        let request = UNNotificationRequest(identifier: "DailyNotification", content: content, trigger: trigger)

        // 通知のスケジュール
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("ローカル通知スケジュール失敗")
                print(error)
                let title = "通知スケジューリング失敗"
                let message = "失敗しました・・・。"
                UIAlertController.showNotificationDialog(from, title: title, message: message)
            } else {
                print("ローカル通知スケジュール成功")
                let title = "通知スケジューリング完了"
                let message = "毎日\(selectedTime.timeString)に通知されます。"
                DispatchQueue.main.async {
                    UIAlertController.showNotificationDialog(from, title: title, message: message)
                }
            }
        }
    }

    /// スケジュールした通知を全て取り消す処理
    func cancelScheduledNotification(_ viewController: UIViewController) {
        UserNotificationUtil.shared.center.removeAllPendingNotificationRequests()
        let title = "通知スケジュール削除完了"
        let message = "スケジュールされた通知を削除しました"
        UIAlertController.showNotificationDialog(viewController, title: title, message: message)
    }
    /// スケジュールした通知があるか確認するメソッド
    func checkNotificationRequests(from: UIViewController) {
        UserNotificationUtil.shared.center.getPendingNotificationRequests {requests in
            if requests.isEmpty {
                print("スケジュールされた通知はありません")
                DispatchQueue.main.async {
                    UIAlertController.showTimePickerAlert(from)
                }
            } else {
                print("スケジュールされた通知が存在します")
                DispatchQueue.main.async {
                    UserNotificationUtil.shared.cancelScheduledNotification(from)
                }
            }
        }
    }
}

extension UserNotificationUtil: UNUserNotificationCenterDelegate {
    /// フォアグラウンドで通知を受信した場合の処理
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        // 今回は不要?
        completionHandler([.banner, .list, .sound])
    }
    /// バックグラウンドで通知を受信した場合の処理（通知をタップした際の処理）
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        completionHandler()
    }
}
