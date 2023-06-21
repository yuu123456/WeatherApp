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

    // 表示するデータ数（表示するデータ数も指定しているが、そもそもAPIにて取得データ数に制限も可能）
    private let displayDataCount = 8

    private var weatherIconArray: [UIImage] = []
    private var maxTempArray: [Double] = []
    private var minTempArray: [Double] = []
    private var humidityArray: [Int] = []
    private var rainyPercentArray: [Double] = []
    private var timeArray: [String] = []

    private var kariData: KariData? = KariData()

    private var activityIndicatorView = UIActivityIndicatorView()

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

        displayActivityIndicatorView()

        getWeatherDataFromLocationInfoAndUpdateView(latitude: latitude, longitude: longitude)

        kariData?.setTimeArray()

        dateLabel.text = Date().japaneseDateStyle

        if let location = location {
            locationLabel.text = location
        } else {
            locationLabel.text = "取得した現在地（仮）"
            print("Locationは選択されていません（Main画面から遷移しました）")
        }

        detailTableView.delegate = self

        detailTableView.register(UINib(nibName: "DetailTableViewCell", bundle: nil), forCellReuseIdentifier: "DetailTableViewCell")

        detailTableView.rowHeight = 100
    }
    /// 通信中（読み込み中）インジケータを表示するメソッド
    private func displayActivityIndicatorView() {
        // タップの無効化。ただしスワイプは可能（詳細画面閉じれる）
        view.isUserInteractionEnabled = false

        // 読み込み中画面の設定
        activityIndicatorView.center = view.center
        activityIndicatorView.style = .large
        activityIndicatorView.color = .darkGray
        // 読込み中画面の追加
        view.addSubview(activityIndicatorView)
        // インジケータの表示及びアニメーションスタート
        activityIndicatorView.startAnimating()
    }

    /// 位置情報をもとに天気データを取得しViewを更新するメソッド
    private func getWeatherDataFromLocationInfoAndUpdateView(latitude: Double?, longitude: Double?) {
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
                self.timeArray = []

                for weatherData in response.list {
                    self.maxTempArray.append(weatherData.main.maxTemp)
                    self.minTempArray.append(weatherData.main.minTemp)
                    self.humidityArray.append(weatherData.main.humidity)
                    self.rainyPercentArray.append(weatherData.rainyPercent * 100) // 0~1の値で取得され、1 が 100％ に近いため
                    // タイムスタンプをDate型にし、変換、格納する
                    self.timeArray.append(Date(timeIntervalSince1970: weatherData.dateStamp).japaneseDateStyleFromTimeStamp)

                    guard let iconId = weatherData.weather.first?.weatherIconId else {
                        print("iconIdが取得できていません")
                        return
                    }
                    // 複数の非同期処理に入る
                    dispatchGroup.enter()
                    // 非同期処理①：取得したアイコンIdから画像を取得
                    GetWeatherIcon.shared.getWeatherIcon(iconId: iconId) { weatherIcon in
                        // 非同期処理②：取得した画像を都度配列に格納　※この処理は①に含めば不要ではないか・・・？
                        DispatchQueue.main.async {
                            if let weatherIcon = weatherIcon {
                                self.weatherIconArray.append(weatherIcon)
                            }
                            // 複数の非同期処理の完了
                            dispatchGroup.leave()
                        }
                    }
                }
                // 複数の非同期処理完了後に行う処理（取得の都度リロードすると、Index不足でエラーになる）
                dispatchGroup.notify(queue: .main) {
                    self.detailTableView.reloadData()
                    // インジケータ非表示
                    self.activityIndicatorView.stopAnimating()
                    // タップの有効化
                    self.view.isUserInteractionEnabled = true

                    // グラフの表示
                    self.displayChart(data: self.rainyPercentArray)
                    // テーブルビューの表示
                    self.detailTableView.dataSource = self
                }

            case .failure(let error):
                print(error)
            }
        }
    }

    private func displayChart(data: [Double]) {
        // プロットデータ(y軸)を保持する配列
        var dataEntries = [ChartDataEntry]()

        // グラフに表示するデータの保管
        for i in 0..<displayDataCount {
            let dataEntry = ChartDataEntry(x: Double(i), y: data[i])
            dataEntries.append(dataEntry)
        }
        // グラフにデータを適用
        chartDataSet = LineChartDataSet(entries: dataEntries, label: "SampleDataChart")

        chartDataSet.lineWidth = 5.0 // グラフの線の太さを変更
        chartDataSet.mode = .linear // 折れ線グラフにする

        chartView.data = LineChartData(dataSet: chartDataSet)

        // X軸(xAxis)
        chartView.xAxis.labelPosition = .bottom // x軸ラベルをグラフの下に表示する
        chartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: timeArray) // 文字列のラベルを表示する
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
        return displayDataCount
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailTableViewCell", for: indexPath) as! DetailTableViewCell

        cell.weatherImage.image = weatherIconArray[indexPath.row]

        cell.maxTempLabel.text = "最高気温：" + String(maxTempArray[indexPath.row]) + "℃"
        cell.minTempLabel.text = "最低気温：" + String(minTempArray[indexPath.row]) + "℃"
        cell.humidLabel.text = "湿度：" + String(humidityArray[indexPath.row]) + "％"
        cell.timeLabel.text = timeArray[indexPath.row]

        return cell
    }
}
