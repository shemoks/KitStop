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
        let alert = UIAlertView(title: title, message: message, delegate: nil, cancelButtonTitle: "OK")
        alert.show()
    }

    func reloadPrice() {
        rangeSlider.minimumValue = Double(presenter.priceList().price.minValue)
        rangeSlider.maximumValue = Double(presenter.priceList().price.maxValue)
        rangeSlider.lowerValue = Double(presenter.priceList().price.minValue)
        rangeSlider.upperValue = Double(presenter.priceList().price.maxValue)
        minValueLabel.text = presenter.priceList().minValue
        maxValueLabel.text = presenter.priceList().maxValue
    }

    func reloadData() {
        tableView?.reloadData()
    }

    func priceVisible(visible: Bool) {
        rangeSlider.isHidden = visible 
        minValueLabel.isHidden = visible
        maxValueLabel.isHidden = visible
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
        self.minValueLabel.text = presenter.priceList().minValue
        self.maxValueLabel.text = presenter.priceList().maxValue
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
