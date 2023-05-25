//
//  MainViewController.swift
//  WeatherApp
//

//

import UIKit

class MainViewController: UIViewController {
    @IBOutlet weak var selectButton: UIButton!
    @IBOutlet weak var getLocationButton: UIButton!

    let buttonCornerRadius: CGFloat = 8
    let buttonBGColor = UIColor.orange
    let buttonTintColor = UIColor.white
    let buttonLayoutX: CGFloat = 100
    let buttonLayoutY: CGFloat = 100

    //Buttonのレイアウトを設定
    func buttonLayout(button: UIButton) {
        // ボタンの制約を設定
        button.translatesAutoresizingMaskIntoConstraints = false

        //各プロパティを宣言
        let centerXConstraint = button.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        var centerYConstraint: NSLayoutConstraint = NSLayoutConstraint()

        let leading = button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: buttonLayoutX)
        let trailing = button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -buttonLayoutX)

        if button == selectButton {
            centerYConstraint = button.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -buttonLayoutY)
        } else if button == getLocationButton {
            centerYConstraint = button.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: buttonLayoutY)
        }
        // 制約を有効にする
        NSLayoutConstraint.activate([centerXConstraint, centerYConstraint, leading, trailing])
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        selectButton.setup(image: UIImage(systemName: "list.bullet")!)
        getLocationButton.setup(image: UIImage(systemName: "location")!)

        buttonLayout(button: selectButton)
        buttonLayout(button: getLocationButton)

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
