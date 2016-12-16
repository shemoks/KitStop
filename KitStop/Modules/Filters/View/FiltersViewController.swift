//
//  FiltersViewController.swift
//  KitStop
//
//  Created by Shemshur Oksana on 15/12/2016.
//  Copyright © 2016 MoziDev. All rights reserved.
//

import Chamomile

// MARK: - FiltersViewController

final class FiltersViewController: UIViewController, FlowController {

    // MARK: - VIPER stack

    @IBOutlet weak var minValueLabel: UILabel!
    var presenter: FiltersViewOutput!

    @IBOutlet weak var maxValueLabel: UILabel!
    @IBOutlet weak var rangeSlider: RangeSlider!
    @IBOutlet weak var tableView: UITableView!

    @IBAction func cancelButtonTap(_ sender: Any) {

    }

    @IBAction func clearAllButtonTap(_ sender: Any) {

    }

    @IBAction func applyButtonTap(_ sender: Any) {
//        var filter = Filter()
//        filter.brandFilter = []
//        (typeFilter: [], brandFilter: [], priceFilter: Price(minValue: 0, maxValue: 0))
//        presenter.handelViewDidLoad(filter: filter)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "TypeCell", bundle: nil), forCellReuseIdentifier: "Cell")
        rangeSlider.addTarget(self, action: #selector(rangeSliderValueChanged), for: .valueChanged)
        rangeSlider.lowerValue = presenter.priceList().minValue
        rangeSlider.upperValue = presenter.priceList().maxValue
        minValueLabel.text = String(presenter.priceList().minValue)
        maxValueLabel.text = String(presenter.priceList().maxValue)
        reloadData()
    }

    func reloadData() {
        tableView?.reloadData()
    }

}

// MARK: - FiltersViewInput

extension FiltersViewController: FiltersViewInput {

}

// MARK: - UITableViewDataSource

extension FiltersViewController: UITableViewDataSource {


    func numberOfSections(in tableView: UITableView) -> Int {

        return 3
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        switch section {
        case 0:
            return 1
        case 1:
            return 1
        default:
            return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? TypeCell
            cell?.configure(filter: presenter.typesList())
            return cell!
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? TypeCell
            cell?.configure(filter: presenter.brandsList())
            return cell!
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 2:
            return 0
        default:
            return 46
        }
    }

    func rangeSliderValueChanged(_ rangeSlider: RangeSlider) {
        self.minValueLabel.text = String(rangeSlider.lowerValue)
        self.maxValueLabel.text = String(rangeSlider.upperValue)
        print("Range slider value changed: (\(rangeSlider.lowerValue) , \(rangeSlider.upperValue))")
    }
}

// MARK: - UITableViewDelegate

extension FiltersViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = HeaderView()
        switch section {
        case 0:
            view.headLabel.text = "TYPE"
            return view
        case 1:
            view.headLabel.text = "BRAND"
            return view
        default:
            view.headLabel.text = "PRICE"
            return view
        }
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 54
    }
    
}
