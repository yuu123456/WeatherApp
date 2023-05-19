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

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        UIView.animate(withDuration: 0.5, delay: 0, options: .repeat, animations: {
            self.boltImage.alpha = 0
            self.snowImage.frame.origin.x -= 20
//            self.sunImage.
        })

        UIView.animate(withDuration: 3.0, delay: 0.5, animations: {
            
            self.cloudImage.transform = CGAffineTransform(scaleX: 10, y: 10)
        }) {_ in
            let nextVC = MainViewController() as UIViewController
//            let nextVC = UINavigationController(rootViewController: MainViewController())
            self.navigationController?.pushViewController(nextVC, animated: true)
//            self.present(nextVC, animated: true)
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
