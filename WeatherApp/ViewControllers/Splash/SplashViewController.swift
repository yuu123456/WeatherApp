//
//  SplashViewController.swift
//  WeatherApp
//

//

import UIKit

class SplashViewController: UIViewController {
    @IBOutlet weak var splashImage: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIView.animate(withDuration: 1.0, delay: 0.5, animations: {
            self.splashImage.transform = CGAffineTransform(scaleX: 20, y: 20)
        }) {_ in
            let nextVC = MainViewController() as UIViewController
            self.navigationController?.pushViewController(nextVC, animated: true)
            print("OK")
        }
    }
}
