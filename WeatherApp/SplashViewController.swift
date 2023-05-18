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


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
