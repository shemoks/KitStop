//
//  KitsDetailedViewController.swift
//  KitStop
//
//  Created by Shemshur Oksana on 18/01/2017.
//  Copyright © 2017 MoziDev. All rights reserved.
//

import Chamomile

// MARK: - KitsDetailedViewController

final class KitsDetailedViewController: UIViewController, FlowController, Alertable {

    // MARK: - VIPER stack

    @IBOutlet weak var tableView: UITableView!
    var presenter: KitsDetailedViewOutput!

    

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "ViewGeneralCell", bundle: nil), forCellReuseIdentifier: "GeneralCell")
        tableView.register(UINib(nibName: "ViewDescriptionCell", bundle: nil), forCellReuseIdentifier: "DescriptionCell")
        navigationController?.navigationBar.tintColor = .black
        presenter.handleViewDidLoad()
        self.tableView.estimatedRowHeight = 50.0

    }

    func sizeHeaderToFit(height: CGFloat) {
        let headerView = tableView.tableHeaderView!
        headerView.setNeedsLayout()
        headerView.layoutIfNeeded()
        var frame = headerView.frame
        frame.size.height = height
        headerView.frame = frame
        tableView.tableHeaderView = headerView
    }

}

// MARK: - KitsDetailedViewInput

extension KitsDetailedViewController: KitsDetailedViewInput {

    func reloadData() {
        navigationItem.title = presenter.getTittle()
        tableView.reloadData()
    }

    func showError(title: String, message: String) {
        self.showAlertWithTitle(title, message: message)
    }

    func reloadHeader(url: URL) {
        let headerView = HeaderKitsDetailed()
        tableView.tableHeaderView = headerView
        let height = view.frame.width + 46
        sizeHeaderToFit(height: height)
        headerView.imageView.sd_setImage(with: url)
    }

    func isVisibleTable(isVisible: Bool) {
        tableView.isHidden = isVisible

    }

}

extension KitsDetailedViewController: BottomBarTransitionProtocol {

    func openModule(identifier: Int) {
        presenter.openModule(identifier: identifier)
    }
    
}

extension KitsDetailedViewController: UITableViewDataSource {


    func numberOfSections(in tableView: UITableView) -> Int {

        return 5
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        switch section {
        case 0:
            return presenter.numberOfGeneralProperties(inSection: section)
        case 1:
            return presenter.numberOfAdditionalProperties(inSection: section)
        case 2:
            return presenter.numberOfSaleProperties(inSection: section)
        default:
            return 1
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GeneralCell") as? GeneralViewCell
        switch indexPath.section {
        case 0:
            cell?.configure(property: presenter.generalProperty(for: indexPath))
            return cell!
        case 1:
            cell?.configure(property:  presenter.additionalProperty(for: indexPath))
            return cell!
        case 2:
            cell?.configure(property:  presenter.saleProperty(for: indexPath))
            return cell!
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "DescriptionCell") as? DescriptionViewCell
            cell?.configure(property: presenter.descriptions(for: indexPath))
            return cell!
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "DescriptionCell") as? DescriptionViewCell
            cell?.configure(property: presenter.notes(for: indexPath))
            return cell!
        }
    }


    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }

}

extension KitsDetailedViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = HeaderViewCreatePost()
        switch section {
        case 0:
            if presenter.numberOfGeneralProperties(inSection: section) > 0 {
                return view
            } else {
                return nil
            }
        case 1:
            if presenter.numberOfAdditionalProperties(inSection: section) > 0 {
                return view
            } else {
                return nil
            }
        case 2:
            if presenter.numberOfSaleProperties(inSection: section) > 0 {
                return view
            } else {
                return nil
            }
        default:
            return view
        }
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            if presenter.numberOfGeneralProperties(inSection: section) > 0 {
             return 10
            } else {
                return 0
            }
        case 1:
            if presenter.numberOfAdditionalProperties(inSection: section) > 0 {
                return 10
            } else {
                return 0
            }
        case 2:
            if presenter.numberOfSaleProperties(inSection: section) > 0 {
                return 10
            } else {
                return 0
            }
        default:
             return 10
        }
    }
    
}
