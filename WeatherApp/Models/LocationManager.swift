//
//  LocationManager.swift
//  WeatherApp
//

//

import CoreLocation

protocol LocationManagerDelegate: AnyObject {
    func didUpdateLocation(_ location: CLLocation)
    func didFailWithError(_ error: Error)
}
/// シングルトン
final class LocationManager: NSObject {
    private let locationManager = CLLocationManager()
    weak var delegate: LocationManagerDelegate?

    public static let shared = LocationManager()

    private override init() {
        super.init()
        locationManager.delegate = self
    }
    /// 位置情報取得許諾状態を表すプロパティ。許可されていればTrue
    var isAuthorized: Bool {
        let status = locationManager.authorizationStatus
        return status == .authorizedAlways || status == .authorizedWhenInUse
    }

    func requestLocationPermission() {
        locationManager.requestWhenInUseAuthorization()
    }

    func startUpdatingLocation() {
        if isAuthorized {
            print("アプリの位置情報取得が許可されています")
            locationManager.startUpdatingLocation()
        } else {
            print("アプリの位置情報取得が許可されていません")
        }
    }

    func stopUpdatingLocation() {
        locationManager.stopUpdatingLocation()
    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            print("位置情報の取得成功")
            print("緯度：\(location.coordinate.latitude)")
            print("経度：\(location.coordinate.longitude)")
            delegate?.didUpdateLocation(location)
            manager.stopUpdatingLocation()
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("位置情報の取得に失敗：\(error)")
        delegate?.didFailWithError(error)
        manager.stopUpdatingLocation()
    }

    // 位置情報の許可のステータス変更で呼ばれる
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print("didChangeAuthorization status=\(status.description)")
        switch status {
        case .authorizedAlways:
            break
        case .authorizedWhenInUse:
            break
        case .notDetermined:
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
