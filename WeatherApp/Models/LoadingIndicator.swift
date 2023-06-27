//
//  LoadingIndicator.swift
//  WeatherApp
//

//

import UIKit
/// 読み込み中のインジケータに関するクラス
final class LoadingIndicator {
    static var loadingIndicatorView: UIView?
    static var activityIndicatorView = UIActivityIndicatorView()

    /// 通信中（読み込み中）インジケータを表示するメソッド
    static func display() {
        guard let loadingIndicatorView = loadingIndicatorView else { return }
        // タップの無効化。ただしスワイプは可能（詳細画面閉じれる）
        loadingIndicatorView.isUserInteractionEnabled = false

        // 読み込み中画面の設定
        activityIndicatorView.center = loadingIndicatorView.center
        activityIndicatorView.style = .large
        activityIndicatorView.color = .darkGray
        // 読込み中画面の追加
        loadingIndicatorView.addSubview(activityIndicatorView)
        // インジケータの表示及びアニメーションスタート
        activityIndicatorView.startAnimating()
    }
    /// 通信中（読み込み中）インジケータの表示を止めるメソッド
    static func stop() {
        guard let loadingIndicatorView = loadingIndicatorView else { return }
        // インジケータ非表示
        activityIndicatorView.stopAnimating()
        // タップの有効化
        loadingIndicatorView.isUserInteractionEnabled = true
    }

}
