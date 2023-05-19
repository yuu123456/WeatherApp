//
//  SplashViewController.swift
//  WeatherApp
//

//

import UIKit

class SplashViewController: UIViewController {
    @IBOutlet weak var cloudImage: UIImageView!
    @IBOutlet weak var sunImage: UIImageView!
    @IBOutlet weak var rainImage: UIImageView!
    @IBOutlet weak var boltImage: UIImageView!
    @IBOutlet weak var snowImage: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        UIView.animate(withDuration: 0.5, delay: 0, options: .repeat, animations: {
            self.boltImage.alpha = 0
            self.snowImage.frame.origin.x -= 20
            self.sunImage.alpha = 0.5
        })

        UIView.animate(withDuration: 2, delay: 0, options: .repeat, animations: {
            self.sunImage.transform = CGAffineTransformRotate(self.sunImage.transform, CGFloat.pi)
        })

        UIView.animate(withDuration: 0.5, delay: 0, options: [.autoreverse, .repeat], animations: {
            self.rainImage.center.y -= 20
        }) {_ in
            self.rainImage.center.y += 20
        }

        UIView.animate(withDuration: 1.0, delay: 0.8, animations: {
            self.cloudImage.transform = CGAffineTransform(scaleX: 10, y: 10)
        }) {_ in
            let nextVC = MainViewController() as UIViewController
            self.navigationController?.pushViewController(nextVC, animated: true)
            print("OK")
        }
    }
}
