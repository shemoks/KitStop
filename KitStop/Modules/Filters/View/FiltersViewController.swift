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
        presenter.handleCancelTap()
    }

    @IBAction func clearAllButtonTap(_ sender: Any) {
        presenter.handleClearAllTap()
        reloadData()
    }

    @IBAction func applyButtonTap(_ sender: Any) {
        presenter.handleApplyTap(price: Price(minValue: Int(rangeSlider.lowerValue), maxValue: Int(rangeSlider.upperValue)))
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "TypeCell", bundle: nil), forCellReuseIdentifier: "Cell")
        rangeSlider.addTarget(self, action: #selector(rangeSliderValueChanged), for: .valueChanged)
        presenter.handleViewDidLoad()
        rangeSlider.lowerValue = Double(presenter.priceList().minValue)
        rangeSlider.upperValue = Double(presenter.priceList().maxValue)
        minValueLabel.text = "$" + String(presenter.priceList().minValue)
        maxValueLabel.text = "$" + String(presenter.priceList().maxValue)
        reloadData()
    }

    func reloadData() {
        tableView?.reloadData()
    }

}

// MARK: - FiltersViewInput

extension FiltersViewController: FiltersViewInput {

    func showError(title: String, message: String) {
        let alert = UIAlertView(title: title, message: message, delegate: nil, cancelButtonTitle: "OK")
        alert.show()
    }

    func setBrandsInCategory(brands: [FilterItems]) {
         presenter.changeBrands(brands: brands)
    //     presenter.changePrice(price: price)
         reloadData()
    }

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
        self.minValueLabel.text = "$" + String(Int(rangeSlider.lowerValue))
        self.maxValueLabel.text = "$" + String(Int(rangeSlider.upperValue))
    }

}

// MARK: - UITableViewDelegate

extension FiltersViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = HeaderView()
        switch section {
        case 0:
            view.headLabel.text = "CATEGORY"
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

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        switch indexPath.section {
        case 0:
            presenter.handleTypeTap()
        default:
            presenter.handleBrandTap()

        }

    }

    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        let bool = presenter.isTypesExist()
        if bool && indexPath.section == 1 {
            return indexPath
        } else {
            return nil
        }
    }

}
