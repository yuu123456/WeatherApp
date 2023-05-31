//
//  MainViewController.swift
//  WeatherApp
//

//

import UIKit
import CoreLocation

class MainViewController: UIViewController {
    @IBOutlet weak var selectButton: UIButton!
    @IBOutlet weak var getLocationButton: UIButton!

    let buttonLayoutX: CGFloat = 100
    let buttonLayoutY: CGFloat = 40

    let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()

        locationManager.delegate = self

        self.navigationController?.navigationBar.backgroundColor = .orange
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.navigationItem.title = "Home"
        //navigationBarの戻るボタンを隠す（スプラッシュ画面に戻らないように）
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
        //レイアウトの制約を適用後に、selectButtonのサイズを取得し、getLocationButtonに反映する。
        view.layoutIfNeeded()
        //先に制約を適用しない場合、下記の制約が適用されない。
        NSLayoutConstraint.activate([getLocationButton.widthAnchor.constraint(equalToConstant: selectButton.frame.width),
                                     getLocationButton.heightAnchor.constraint(equalToConstant: selectButton.frame.height)])

    }

    @IBAction func tapLocationSelectButton(_ sender: Any) {
        let nextVC = SelectViewController() as UIViewController
        self.navigationController?.pushViewController(nextVC, animated: true)
    }

    @IBAction func tapLocationGetButton(_ sender: Any) {
        let nextVC = DetailViewController() as UIViewController
        self.present(nextVC, animated: true)
    }
}

extension MainViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            print("位置情報の取得成功")
            print("緯度：\(location.coordinate.latitude)")
            print("経度：\(location.coordinate.longitude)")
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("位置情報の取得に失敗：\(error)")
    }

    // 位置情報の許可のステータス変更で呼ばれる
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print("didChangeAuthorization status=\(status.description)")
        switch status {
        case .authorizedAlways:
            manager.requestLocation()
            break
        case .authorizedWhenInUse:
            manager.requestLocation()
            break
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
            break
        case .restricted:
            break
        case .denied:
            break
        default:
            break
        }
    }
}

//位置情報取得に関するステータスを文字列で返す
extension CLAuthorizationStatus {
    var description: String {
        switch self {
        case .notDetermined:
            return "未選択"
        case .restricted:
            return "ペアレンタルコントロールなどの影響で制限中"
        case .denied:
            return "利用拒否"
        case .authorizedAlways:
            return "常に利用許可"
        case .authorizedWhenInUse:
            return "使用中のみ利用許可"
        default:
            return ""
        }
    }
}
