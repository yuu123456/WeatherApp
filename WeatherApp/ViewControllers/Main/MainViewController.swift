//
//  MainViewController.swift
//  WeatherApp
//

//

import UIKit

class MainViewController: UIViewController {
    @IBOutlet weak var selectButton: UIButton!
    @IBOutlet weak var getLocationButton: UIButton!

    let buttonLayoutX: CGFloat = 100
    let buttonLayoutY: CGFloat = 40

    override func viewDidLoad() {
        super.viewDidLoad()

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
