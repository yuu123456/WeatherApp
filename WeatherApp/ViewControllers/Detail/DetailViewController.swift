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
    // Icon画像取得前にtableViewがクラッシュしないように仮処置
    private var weatherIconArray: [UIImage] = [UIImage.add, UIImage.add, UIImage.add, UIImage.add]

    private var maxTempArray: [Double] = [0, 0, 0, 0]
    private var minTempArray: [Double] = [0, 0, 0, 0]
    private var humidityArray: [Int] = [0, 0, 0, 0]
    private var rainyPercentArray: [Double] = [0, 0, 0, 0]
    private var dateStringArray: [String] = ["", "", "", ""]

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

        getWeatherDataFromLocation(latitude: latitude, longitude: longitude)

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

    /// 位置情報をもとに天気データを取得しViewを更新するメソッド
    private func getWeatherDataFromLocation(latitude: Double?, longitude: Double?) {
        guard let latitude = latitude,
              let longitude = longitude else {
                  print("緯度及び軽度が不正です")
                  return
              }
        let client = APIClient(httpClient: URLSession.shared)
        let request = OpenWeatherMapAPI.SearchWeatherData(latitude: latitude, longitude: longitude)

        client.send(request: request) { result in
            switch result {
            case .success(let response):
                // 複数の非同期処理完了時に処理を行いたいときに用いるDispatchGroup
                let dispatchGroup = DispatchGroup()
                // 仮画像の削除
                self.weatherIconArray = []
                self.maxTempArray = []
                self.minTempArray = []
                self.humidityArray = []
                self.rainyPercentArray = []
                self.dateStringArray = []

                for weatherData in response.list {
                    self.maxTempArray.append(weatherData.main.maxTemp)
                    self.minTempArray.append(weatherData.main.minTemp)
                    self.humidityArray.append(weatherData.main.humidity)
                    self.rainyPercentArray.append(weatherData.rainyPercent)
                    self.dateStringArray.append(weatherData.dateString)

                    guard let iconId = weatherData.weather.first?.weatherIconId else {
                        print("iconIdが取得できていません")
                        continue
                    }
                    // 複数の非同期処理に入る
                    dispatchGroup.enter()
                    // 非同期処理①：取得したアイコンIdから画像を取得
                    GetWeatherIcon.getWeatherIcon(iconId: iconId) { weatherIcon in
                        if let weatherIcon = weatherIcon {
                            self.weatherIconArray.append(weatherIcon)
                        }
                        // 複数の非同期処理の完了
                        dispatchGroup.leave()
                    }
                }
                // 複数の非同期処理完了後に行う処理（取得の都度リロードすると、Index不足でエラーになる）
                dispatchGroup.notify(queue: .main) {
                    self.detailTableView.reloadData()
                }

            case .failure(let error):
                print(error)
            }
        }
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

        cell.weatherImage.image = weatherIconArray[indexPath.row]

        cell.maxTempLabel.text = "最高気温：" + String(maxTempArray[indexPath.row]) + "℃"
        cell.minTempLabel.text = "最低気温：" + String(minTempArray[indexPath.row]) + "℃"
        cell.humidLabel.text = "湿度：" + String(humidityArray[indexPath.row]) + "％"

        if let data = kariData {
            cell.timeLabel.text = data.timeArray[indexPath.row]
        }

        return cell
    }
}
