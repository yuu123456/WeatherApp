//
//  DetailViewController.swift
//  WeatherApp
//

//

import UIKit

class DetailViewController: UIViewController {

    var selectDataModel: SelectDataModel?

    @IBOutlet weak var detailTableView: UITableView!

    @IBAction func tapCloseButton(_ sender: Any) {
        self.dismiss(animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        if let model = selectDataModel {
            print("渡された値は：\(model.location!)")
        } else {
            print("nilです")
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath)
        return cell
    }


}
