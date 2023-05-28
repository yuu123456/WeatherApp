//
//  DetailViewController.swift
//  WeatherApp
//

//

import UIKit

class DetailViewController: UIViewController {

    var dataModel: DataModel?
    var kariData: KariData? = KariData()

    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var detailTableView: UITableView!

    @IBAction func tapCloseButton(_ sender: Any) {
        self.dismiss(animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        if let model = dataModel {
            locationLabel.text = model.location
            dateLabel.text = model.getCurrentFormattedDate()
        } else {
            print("値渡し失敗です")
        }

        detailTableView.delegate = self
        detailTableView.dataSource = self

        detailTableView.register(UINib(nibName: "DetailTableViewCell", bundle: nil), forCellReuseIdentifier: "customCell")

        detailTableView.rowHeight = 100
    }
}

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! DetailTableViewCell

        if let model = dataModel,
           let data = kariData{
            cell.timeLabel.text = data.timeArray[indexPath.row]
            cell.weatherImage.image = model.getWeatherImage(weather: data.weatherArray[indexPath.row])
            cell.maxTempLabel.text = "最高気温：" + String(data.maxTempArray[indexPath.row]) + "℃"
            cell.minTempLabel.text = "最低気温：" + String(data.minTempArray[indexPath.row]) + "℃"
            cell.humidLabel.text = "湿度：" + String(data.humidArray[indexPath.row]) + "％"
        }
        
        return cell
    }


}
