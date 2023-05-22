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

    func buttonLayout(button: UIButton) {
        // ボタンの制約を設定
        button.translatesAutoresizingMaskIntoConstraints = false

        // ボタンのサイズを画像と文字に合わせる制約
        let imageWidthConstraint = button.widthAnchor.constraint(equalTo: button.imageView!.widthAnchor)
        let textWidthConstraint = button.widthAnchor.constraint(equalTo: button.titleLabel!.widthAnchor)


        let centerXConstraint = button.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        let centerYConstraint = button.centerYAnchor.constraint(equalTo: view.centerYAnchor)

        // 制約を有効にする
        NSLayoutConstraint.activate([imageWidthConstraint, textWidthConstraint, centerXConstraint, centerYConstraint])

//        let leading = button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 100)
//        let trailing = button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -100)
//        let top = button.topAnchor.constraint(equalTo:  view.topAnchor, constant: 100)
//        let bottom = button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100)
//        NSLayoutConstraint.activate([leading, trailing, top, bottom])
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        //Buttonのプロパティを設定。（同じ設定の箇所は、まとめられないか要検討。
        selectButton.backgroundColor = buttonBGColor
        selectButton.tintColor = buttonTintColor
        selectButton.setImage(selectButtonImage, for: .normal)
        selectButton.layer.cornerRadius = buttonCornerRadius
        selectButton.titleLabel?.adjustsFontSizeToFitWidth = true
        selectButton.translatesAutoresizingMaskIntoConstraints = false

        getLocationButton.backgroundColor = buttonBGColor
        getLocationButton.tintColor = buttonTintColor
        getLocationButton.setImage(getLocationButtonImage, for: .normal)
        getLocationButton.layer.cornerRadius = buttonCornerRadius
        getLocationButton.titleLabel?.adjustsFontSizeToFitWidth = true
        getLocationButton.translatesAutoresizingMaskIntoConstraints = false

        buttonLayout(button: selectButton)
//        buttonLayout(button: getLocationButton)

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
