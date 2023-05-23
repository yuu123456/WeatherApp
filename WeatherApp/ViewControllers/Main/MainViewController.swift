//
//  MainViewController.swift
//  WeatherApp
//

//

import UIKit

class MainViewController: UIViewController {
    @IBOutlet weak var selectButton: UIButton!
    @IBOutlet weak var getLocationButton: UIButton!

    let selectButtonImage = UIImage(systemName: "list.bullet")
    let getLocationButtonImage = UIImage(systemName: "location")

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

    //Buttonの外観プロパティを設定
    func buttonSetting(button: UIButton) {
        button.backgroundColor = buttonBGColor
        button.tintColor = buttonTintColor

        button.layer.cornerRadius = buttonCornerRadius
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.translatesAutoresizingMaskIntoConstraints = false

        if button == selectButton {
            button.setImage(selectButtonImage, for: .normal)
        } else if button == getLocationButton {
            button.setImage(getLocationButtonImage, for: .normal)
        }

    }

    override func viewDidLoad() {
        super.viewDidLoad()

        buttonSetting(button: selectButton)
        buttonSetting(button: getLocationButton)
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
