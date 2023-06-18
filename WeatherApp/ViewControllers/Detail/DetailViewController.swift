//
//  DetailViewController.swift
//  WeatherApp
//

//

import Charts
import UIKit

class DetailViewController: UIViewController {

    var location: String?
    var latitude: Double?
    var longitude: Double?
    let apiKey = "5dfc577c1d7d94e9e23a00431582f1ac"

    private var kariData: KariData? = KariData()

    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var detailTableView: UITableView!
    @IBOutlet weak var chartView: LineChartView!

    private var chartDataSet: LineChartDataSet!

    @IBAction func tapCloseButton(_ sender: Any) {
        self.dismiss(animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let client = APIClient(httpClient: URLSession.shared)
        let request = OpenWeatherMapAPI.SearchWeatherData(latitude: latitude!, longitude: longitude!)
        client.send(request: request) { result in
            switch result {
            case .success(let response):
                print(response)

            case .failure(let error):
                print(error)

            }

        }

        kariData?.setTimeArray()
        displayChart(data: kariData!.rainyPercentArray)

        dateLabel.text = Date().japaneseDateStyle

        if let location = location {
            locationLabel.text = location
        } else {
            locationLabel.text = "取得した現在地（仮）"
            print("Locationは選択されていません（Main画面から遷移しました）")
        }

        detailTableView.delegate = self
        detailTableView.dataSource = self

        detailTableView.register(UINib(nibName: "DetailTableViewCell", bundle: nil), forCellReuseIdentifier: "DetailTableViewCell")

        detailTableView.rowHeight = 100
    }

    private func displayChart(data: [Double]) {
        // プロットデータ(y軸)を保持する配列
        var dataEntries = [ChartDataEntry]()

        for (xValue, yValue) in data.enumerated() {
            let dataEntry = ChartDataEntry(x: Double(xValue), y: yValue)
            dataEntries.append(dataEntry)
        }
        // グラフにデータを適用
        chartDataSet = LineChartDataSet(entries: dataEntries, label: "SampleDataChart")

        chartDataSet.lineWidth = 5.0 // グラフの線の太さを変更
        chartDataSet.mode = .linear // 折れ線グラフにする

        chartView.data = LineChartData(dataSet: chartDataSet)

        // X軸(xAxis)
        chartView.xAxis.labelPosition = .bottom // x軸ラベルをグラフの下に表示する
        chartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: kariData!.timeArray) // 文字列のラベルを表示する
        chartView.xAxis.granularity = 1 // ラベルが１単位になる

        // Y軸(leftAxis/rightAxis)
        chartView.leftAxis.axisMaximum = 100 // y左軸最大値
        chartView.leftAxis.axisMinimum = 0 // y左軸最小値
        chartView.leftAxis.labelCount = 6 // y軸ラベルの数
        chartView.rightAxis.enabled = false // 右側の縦軸ラベルを非表示

        // その他の変更
        chartView.highlightPerTapEnabled = false // プロットをタップして選択不可
        chartView.legend.enabled = false // グラフ名（凡例）を非表示
        chartView.pinchZoomEnabled = false // ピンチズーム不可
        chartView.doubleTapToZoomEnabled = false // ダブルタップズーム不可
        // 見切れ防止のためのオフセット
        chartView.extraTopOffset = 20
        chartView.extraRightOffset = 20

        chartView.animate(xAxisDuration: 1) // 2秒かけて左から右にグラフをアニメーションで表示する
    }
}

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailTableViewCell", for: indexPath) as! DetailTableViewCell

        if let data = kariData {
            cell.timeLabel.text = data.timeArray[indexPath.row]
            cell.weatherImage.image = data.weatherArray[indexPath.row].getWeatherImage()
            cell.maxTempLabel.text = "最高気温：" + String(data.maxTempArray[indexPath.row]) + "℃"
            cell.minTempLabel.text = "最低気温：" + String(data.minTempArray[indexPath.row]) + "℃"
            cell.humidLabel.text = "湿度：" + String(data.humidArray[indexPath.row]) + "％"
        }

        return cell
    }
}
