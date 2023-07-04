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

    private var weatherIdArray: [[String]] = []
    private var weatherIconArray: [[UIImage]] = []
    private var maxTempArray: [[Double]] = []
    private var minTempArray: [[Double]] = []
    private var humidityArray: [[Int]] = []
    private var rainyPercentArray: [Double] = []
    /// グラフのX軸ラベル用
    private var timeArray: [String] = []
    /// tableViewでセクション分けしやすい型（タプル。日付毎に時間配列を持たせる）
    private var dateTimeArray: [(date: String, time: [String])] = []

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
        // 読込み中インジケータ表示
        LoadingIndicator.display(loadingIndicatorView: self.view)

        dateLabel.text = Date().formatJapaneseDateStyle

        if let location = location {
            locationLabel.text = location
            getWeatherDataFromCityName(location: location)
        } else {
            locationLabel.text = "読込み中・・・"
            print("Locationは選択されていません（Main画面から遷移しました）")
            getWeatherDataFromLocation(latitude: latitude, longitude: longitude)
        }
        detailTableView.dataSource = self
        detailTableView.delegate = self
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

        // 非同期処理のクロージャ内でselfを参照する場合、弱参照とする（循環参照回避のため）→　selfがオプショナル型になる
        client.send(request: request) { [weak self] result in
            // selfがオプショナル型のため
            guard let self = self else { return }
            switch result {
            case .success(let response):
                self.saveAPIResponse(response: response)

            case .failure(let error):
                print(error)
                // エラー内容をダイアログで表示する
                error.showAlert(from: self)
            }
        }
    }
    /// 都市名をもとに天気データを取得しViewを更新するメソッド
    private func getWeatherDataFromCityName(location: String?) {
        guard let location = location else {
                  print("都市名が不正です")
                  return
              }
        let client = APIClient(httpClient: URLSession.shared)
        let request = OpenWeatherMapAPI.SearchWeatherDataFromCityName(cityName: location)
        // 非同期処理のクロージャ内でselfを参照する場合、弱参照とする（循環参照回避のため）→　selfがオプショナル型になる
        client.send(request: request) { [weak self] result in
            // selfがオプショナル型のため
            guard let self = self else { return }
            switch result {
            case .success(let response):
                self.saveAPIResponse(response: response)

            case .failure(let error):
                print(error)
                // エラー内容をダイアログで表示する
                error.showAlert(from: self)
            }
        }
    }
    /// APIから受け取ったレスポンスを配列に格納するメソッド
    private func saveAPIResponse(response: WeatherData) {
        self.location = response.city.name

        for weatherData in response.list {
            self.rainyPercentArray.append(weatherData.rainyPercent * 100) // 0~1の値で取得され、1 が 100％ に近いため
            // タイムスタンプをDate型にし、各表示形式に変換、格納する
            let date = Date(timeIntervalSince1970: weatherData.timeStamp).formatJapaneseDateStyleForTableViewSection
            let time = Date(timeIntervalSince1970: weatherData.timeStamp).formatJapaneseDateStyleForChartsAndTableView
            // グラフX軸用の配列に追加
            self.timeArray.append(time)

            // 同じ日付を含む要素のインデックス番号を取得する。
            if let index = self.dateTimeArray.firstIndex(where: { $0.date == date }) {
                // dateに同じ日付がある場合、そのインデックス番号のtime配列に時間を追加
                self.dateTimeArray[index].time.append(time)
                self.maxTempArray[index].append(weatherData.main.maxTemp.roundToSecondDecimalPlace())
                self.minTempArray[index].append(weatherData.main.minTemp.roundToSecondDecimalPlace())
                self.humidityArray[index].append(weatherData.main.humidity)

                guard let iconId = weatherData.weather.first?.weatherIconId else {
                    print("iconIdが取得できていません")
                    continue
                }
                // 一旦、iconIdを格納して、後ほどアイコン画像を取得する
                self.weatherIdArray[index].append(iconId)
            } else {
                // dateに同じ日付がない場合、新たな要素として、日付と時間を追加する
                self.dateTimeArray.append((date: date, time: [time]))
                self.maxTempArray.append([weatherData.main.maxTemp.roundToSecondDecimalPlace()])
                self.minTempArray.append([weatherData.main.minTemp.roundToSecondDecimalPlace()])
                self.humidityArray.append([weatherData.main.humidity])

                guard let iconId = weatherData.weather.first?.weatherIconId else {
                    print("iconIdが取得できていません")
                    continue
                }
                self.weatherIdArray.append([iconId])
            }
        }
        saveWeatherIcon()
    }
    /// 天気アイコンを配列に格納するメソッド
    private func saveWeatherIcon() {
        // 外側の配列の要素数をセクション数と見なし、セクションの数分、繰り返す
        for sectionCount in 0..<weatherIdArray.count {
            // 内側の配列の要素数分、繰り返す
            for idCount in 0..<weatherIdArray[sectionCount].count {
                GetWeatherIcon.getWeatherIcon(iconId: weatherIdArray[sectionCount][idCount]) { [weak self] weatherIcon in
                    guard let self = self else { return }
                    if let weatherIcon = weatherIcon {
                        // セクションカウントがアイコンを格納する配列の要素数と等しい時、新たな配列追加
                        // そうでない場合は、既存の配列に要素を追加
                        if sectionCount == weatherIconArray.count {
                            print("新たな配列を追加")
                            self.weatherIconArray.append([weatherIcon])
                        } else {
                            print("既存の配列に要素を追加")
                            self.weatherIconArray[sectionCount].append(weatherIcon)
                        }
                    }
                    checkWeatherIconArray()
                }
            }
        }
    }
    /// 配列内の要素を確認し、view更新可否の判定をするメソッド
    private func checkWeatherIconArray() {
        // 外側の配列の要素数が等しく、且つ内側の要素数も等しい場合、非同期処理完了とみなす
        if weatherIconArray.count == weatherIdArray.count {
            if weatherIconArray[weatherIconArray.count - 1].count == weatherIdArray[weatherIdArray.count - 1].count {
                updateView()
            }
        }
    }
    /// viewを更新するメソッド
    private func updateView() {
        // メインスレッドで実行
        DispatchQueue.main.sync {
            // インジケータ表示停止
            LoadingIndicator.stop(loadingIndicatorView: self.view)
            // 取得した地名を表示
            self.locationLabel.text = self.location
            // グラフの表示
            self.displayChart(data: self.rainyPercentArray)
            // テーブルビューの表示更新
            self.detailTableView.reloadData()
        }
    }
    /// グラフを表示するメソッド
    private func displayChart(data: [Double]) {
        // プロットデータ(y軸)を保持する配列
        var dataEntries = [ChartDataEntry]()

        // グラフに表示するデータの保管(
        for i in 0..<timeArray.count {
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
    // １セクションにおけるセルの数の定義
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dateTimeArray[section].time.count
    }
    // セルの値の定義
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailTableViewCell", for: indexPath) as! DetailTableViewCell
        cell.weatherImage.image = weatherIconArray[indexPath.section][indexPath.row]
        cell.maxTempLabel.text = "最高気温：" + String(maxTempArray[indexPath.section][indexPath.row]) + "℃"
        cell.minTempLabel.text = "最低気温：" + String(minTempArray[indexPath.section][indexPath.row]) + "℃"
        cell.humidLabel.text = "湿度：" + String(humidityArray[indexPath.section][indexPath.row]) + "％"
        cell.timeLabel.text = dateTimeArray[indexPath.section].time[indexPath.row]

        return cell
    }
    // セクション数の定義
    func numberOfSections(in tableView: UITableView) -> Int {
        return dateTimeArray.count
    }
    // セクションの値の定義
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return dateTimeArray[section].date
    }
}
