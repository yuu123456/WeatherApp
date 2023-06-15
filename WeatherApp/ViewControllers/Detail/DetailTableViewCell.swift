//
//  DetailTableViewCell.swift
//  WeatherApp
//

//

import UIKit

class DetailTableViewCell: UITableViewCell {

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var maxTempLabel: UILabel!
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var humidLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()

        maxTempLabel.textColor = .red
        minTempLabel.textColor = .blue
        humidLabel.textColor = .green

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
