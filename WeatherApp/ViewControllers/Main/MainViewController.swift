//
//  MainViewController.swift
//  WeatherApp
//

//

import CoreLocation
import UIKit

class MainViewController: UIViewController {
    @IBOutlet weak var selectButton: UIButton!
    @IBOutlet weak var getLocationButton: UIButton!

    private let buttonLayoutX: CGFloat = 100
    private let buttonLayoutY: CGFloat = 40

    override func viewDidLoad() {
        super.viewDidLoad()

        LocationManager.shared.delegate = self
        LocationManager.shared.requestLocationPermission()

        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .orange
        appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        appearance.backButtonAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.scrollEdgeAppearance = appearance
        self.navigationController?.navigationBar.standardAppearance = appearance

        self.navigationController?.navigationBar.tintColor = .white
        self.navigationItem.title = "Home"
        // navigationBarの戻るボタンを隠す（スプラッシュ画面に戻らないように）
        self.navigationItem.hidesBackButton = true

        selectButton.setup(image: UIImage(systemName: "list.bullet")!)
        getLocationButton.setup(image: UIImage(systemName: "location")!)

        selectButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([selectButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     selectButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -buttonLayoutY),
                                     selectButton.heightAnchor.constraint(equalTo: selectButton.widthAnchor, multiplier: 0.3)])
        getLocationButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([getLocationButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     getLocationButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: buttonLayoutY)])
        // レイアウトの制約を適用後に、selectButtonのサイズを取得し、getLocationButtonに反映する。
        view.layoutIfNeeded()
        // 先に制約を適用しない場合、下記の制約が適用されない。
        NSLayoutConstraint.activate([getLocationButton.widthAnchor.constraint(equalToConstant: selectButton.frame.width),
                                     getLocationButton.heightAnchor.constraint(equalToConstant: selectButton.frame.height)])

    }

    @IBAction func tapLocationSelectButton(_ sender: Any) {
        let selectView = SelectViewController() as UIViewController
        self.navigationController?.pushViewController(selectView, animated: true)
    }

    @IBAction func tapLocationGetButton(_ sender: Any) {
        // アプリへの位置情報許諾状況を確認し、許可されていなければダイアログ表示
        guard LocationManager.shared.isAuthorized else {
            displayNotGetLocationDialog()
            return
        }
        if CLLocationManager.locationServicesEnabled() {
            print("デバイスの位置情報が取得可能です")
            LocationManager.shared.startUpdatingLocation()
        } else {
            print("デバイスの位置情報が取得できません")
        }

    }
    /// 位置情報を取得できない場合のダイアログを表示するメソッド
    func displayNotGetLocationDialog() {
        let title = "位置情報取得失敗"
        let message = "このアプリの位置情報取得が許可されていません。アプリの設定を見直してください。"
        let dialog = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let closeAction = UIAlertAction(title: "閉じる", style: .default)
        let settingAction = UIAlertAction(title: "設定", style: .default) {_ in
            guard let url = URL(string: UIApplication.openSettingsURLString), UIApplication.shared.canOpenURL(url) else { return }
            UIApplication.shared.open(url, options: [:], completionHandler: nil)

        }
        dialog.addAction(closeAction)
        dialog.addAction(settingAction)
        self.present(dialog, animated: true, completion: nil)
    }
}

extension MainViewController: LocationManagerDelegate {
    func didUpdateLocation(_ location: CLLocation) {
        let detailView = DetailViewController(nibName: "DetailView", bundle: nil)
        detailView.latitude = location.coordinate.latitude
        detailView.longitude = location.coordinate.longitude
        self.present(detailView, animated: true)
    }

    func didFailWithError(_ error: Error) {
        print("位置情報が取得できないため、遷移しません")
    }
}
