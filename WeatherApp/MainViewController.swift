//
//  MainViewController.swift
//  WeatherApp
//

//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func tapLocationSelectButton(_ sender: Any) {
        let nextVC = SelectViewController() as UIViewController
        self.navigationController?.pushViewController(nextVC, animated: true)
    }

    @IBAction func tapLocationGetButton(_ sender: Any) {
        let nextVC = DetailViewController() as UIViewController
        self.present(nextVC, animated: true)
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
