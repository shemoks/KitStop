//
//  FiltersViewController.swift
//  KitStop
//
//  Created by Shemshur Oksana on 15/12/2016.
//  Copyright © 2016 MoziDev. All rights reserved.
//

import Chamomile

// MARK: - FiltersViewController

final class FiltersViewController: UIViewController, FlowController, Alertable {

    // MARK: - VIPER stack

    @IBOutlet weak var clearAll: UIBarButtonItem!
    @IBOutlet weak var minValue: UILabel!
    var presenter: FiltersViewOutput!

    @IBOutlet weak var withoutPrice: UIView!
    @IBOutlet weak var applyConstraintForSale: NSLayoutConstraint!
    @IBOutlet weak var maxValue: UILabel!
    @IBOutlet weak var applyConstraintForKits: NSLayoutConstraint!
    @IBOutlet weak var rangeSlider: RangeSlider!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var rangeSliderView: UIView!

    @IBAction func cancelButtonTap(_ sender: Any) {
        presenter.handleCancelTap()
    }

    @IBAction func clearAllButtonTap(_ sender: Any) {
        presenter.handleClearAllTap()
        clearAll.isEnabled = false
    }

    @IBAction func applyButtonTap(_ sender: Any) {
        presenter.handleApplyTap(price: Price(minValue: Int(rangeSlider.lowerValue), maxValue: Int(rangeSlider.upperValue)))
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "TypeCell", bundle: nil), forCellReuseIdentifier: "Cell")
        rangeSlider.addTarget(self, action: #selector(rangeSliderValueChanged), for: .valueChanged)
        navigationController?.navigationBar.tintColor = .black
        presenter.handleViewDidLoad()
    }

}

// MARK: - FiltersViewInput

extension FiltersViewController: FiltersViewInput {

    func showError(title: String, message: String) {
        self.showAlertWithTitle(title, message: message)
    }

    func reloadPrice() {
        let result = presenter.isVisiblePriceSlider()
        if result {
            rangeSliderView.isHidden = false
            withoutPrice.isHidden = true
            rangeSlider.minimumValue = Double(presenter.priceList().price.minValue)
            rangeSlider.maximumValue = Double(presenter.priceList().price.maxValue)
            rangeSlider.lowerValue = Double(presenter.priceList().price.minValue)
            rangeSlider.upperValue = Double(presenter.priceList().price.maxValue)
            minValue.text = presenter.priceList().minValue
            maxValue.text = presenter.priceList().maxValue
        } else {
            rangeSliderView.isHidden = true
            withoutPrice.isHidden = false
        }
    }

    func reloadData() {
        tableView?.reloadData()
    }

    func priceVisible(visible: Bool) {
        if visible {
            rangeSliderView.isHidden = visible
            applyConstraintForSale.constant -= 55
            self.view.layoutIfNeeded()
        }
    }

    func activeClearAll(isActive: Bool) {
        clearAll.isEnabled = isActive
    }

    func isVisiblePrice(result: Bool) {
        if result {
            rangeSliderView.isHidden = false
            withoutPrice.isHidden = true
        } else {
            rangeSliderView.isHidden = true
            withoutPrice.isHidden = false
        }

    }

}

// MARK: - UITableViewDataSource

extension FiltersViewController: UITableViewDataSource {


    func numberOfSections(in tableView: UITableView) -> Int {

        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        switch section {
        case 0:
            return 1
        default:
            return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? TypeCell
        cell?.configure(filter: presenter.typesList())
        return cell!
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 1:
            return 0
        default:
            return 46
        }
    }

    func rangeSliderValueChanged(_ rangeSlider: RangeSlider) {
        presenter.changePrice(price: Price(minValue: Int(rangeSlider.lowerValue), maxValue: Int(rangeSlider.upperValue)))
        self.minValue.text = presenter.priceList().minValue
        self.maxValue.text = presenter.priceList().maxValue
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
        default:
            view.headLabel.text = "PRICE"
            view.headLabel.isHidden = presenter.visible()
            return view
        }
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 54
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter.handleTypeTap()
    }
    
    
}
