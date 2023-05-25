//
//  ExtensionUIButton.swift
//  WeatherApp
//

//

import UIKit

extension UIButton {

    func setup(image: UIImage) {
        
        backgroundColor = UIColor.orange
        tintColor = UIColor.white
        layer.cornerRadius = 8
        titleLabel?.adjustsFontSizeToFitWidth = true
        translatesAutoresizingMaskIntoConstraints = false
        setImage(image, for: .normal)
    }
}
