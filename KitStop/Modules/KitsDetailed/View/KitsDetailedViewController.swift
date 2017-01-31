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
    let headerView = CaruselHeader()



    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "ViewGeneralCell", bundle: nil), forCellReuseIdentifier: "GeneralCell")
        tableView.register(UINib(nibName: "ViewDescriptionCell", bundle: nil), forCellReuseIdentifier: "DescriptionCell")
        presenter.handleViewDidLoad()
        self.tableView.estimatedRowHeight = 50.0

    }

    @objc func openChatModule() {
        presenter.openChat()
    }

    @objc func sheetsView() {
      setupAlert()
    }

    func setupAlert() {
        let alertController = UIAlertController.init(title: nil, message: nil, preferredStyle: .actionSheet)
        let openEdit = UIAlertAction.init(title: "Edit", style: .default, handler: {
            result in
            if self.presenter.getSection() {
                self.presenter.openEditForSale()
            } else {
                self.presenter.openEditKit()
            }
        })

        if presenter.getSection() {

        let openListForKits = UIAlertAction.init(title: "List For Kits", style: .default, handler: {
            result in
            self.presenter.handleKit()
        })
            let cancel = UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil)
            let remove = UIAlertAction.init(title: "Remove this Post", style: .default, handler: {
                result in
                let yes = UIAlertAction.init(title: "Yes", style: .default, handler: {
                    result in
                    self.presenter.removePost()
                })
                let no = UIAlertAction.init(title: "No", style: .cancel, handler: nil)
                self.showAlertWithTitle("Delete", message: "Are you sure to delete this item?", actions: [yes, no])
            })

            alertController.addAction(openEdit)
            alertController.addAction(openListForKits)
            alertController.addAction(remove)
            alertController.addAction(cancel)
        } else {
            let openListForSale = UIAlertAction.init(title: "List For Sales", style: .default, handler: {
                result in
                self.presenter.handleKitForSale()
            })
            let remove = UIAlertAction.init(title: "Remove this Post", style: .default, handler: {
                result in
                let yes = UIAlertAction.init(title: "Yes", style: .default, handler: {
                    result in
                    self.presenter.removePost()
                })
                let no = UIAlertAction.init(title: "No", style: .cancel, handler: nil)
                self.showAlertWithTitle("Delete", message: "Are you sure to delete this item?", actions: [yes, no])
            })
            let cancel = UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil)
            alertController.addAction(openEdit)
            alertController.addAction(openListForSale)
            alertController.addAction(remove)
            alertController.addAction(cancel)
        }


        self.present(alertController, animated: true, completion: nil)
        alertController.view.tintColor = UIColor.gray
        
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

    func setSizeForCell(header: CaruselHeader) {
        let layout = header.carusel.collectionView.collectionViewLayout as? UICollectionViewFlowLayout
        let screenWidth = view.frame.width
        layout?.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout?.itemSize = CGSize(width: screenWidth, height: screenWidth)
        layout?.minimumInteritemSpacing = 0
        layout?.minimumLineSpacing = 0
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

    func reloadHeader(url: URL, userInfo: User, dateUpdate: String) {

        headerView.onTouch = {
             self.presenter.changeLike(like: self.headerView.like)
        }
        headerView.carusel.heightCell = view.frame.width
        setSizeForCell(header: headerView)
        headerView.carusel.images = presenter.getImages()
        let numberOfPages = presenter.getImages().count
        let currentNumberImage = 0
        let currentIndex = IndexPath(item: currentNumberImage, section: 0)
        if numberOfPages > 1 {
             headerView.carusel.pageControl.isHidden = false
             headerView.carusel.pageControl.numberOfPages = presenter.getImages().count
             headerView.carusel.collectionView.scrollToItem(at: currentIndex, at: .centeredHorizontally, animated: false)
             headerView.carusel.pageControl.currentPage = currentNumberImage
        } else {
            headerView.carusel.pageControl.isHidden = true
            headerView.carusel.pageControl.numberOfPages = 0
        }
        headerView.privateLabel.isHidden = presenter.isPrivatePost()
        tableView.tableHeaderView = headerView
        let height = view.frame.width + 46
        sizeHeaderToFit(height: height)
        (headerView.actualView as! UserInformationViewController).updateUser(user: userInfo)
        let footerView = TableFooterView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 50))
        footerView.dateUpdate.text = dateUpdate
        tableView.tableFooterView = footerView
        self.navigationItem.rightBarButtonItem = presenter.updateData(xib: headerView.actualView!) ?          UIBarButtonItem.init(image: UIImage.init(named: "Icons_action_sheet"), style: .done, target: self, action: #selector(sheetsView)) : UIBarButtonItem.init(image: UIImage.init(named: "Conv"), style: .done, target: self, action: #selector(openChatModule))
        headerView.carusel.onTouch = { index, arrayImages, isEdit in
            let gallery = SwiftPhotoGallery(delegate: self, dataSource: self, trashButtonStatus: isEdit, pageBeforeRotation: index, page: index)
            self.present(gallery, animated: true, completion: nil)
        }
    }

    func showSuccessAlert(title: String, message: String, action: [UIAlertAction]) {
        showAlertWithTitle(title, message: message, actions: action)
    }

    func isVisibleTableView(flag: Bool) {
        if flag {
            tableView.isHidden = false
        } else {
            tableView.isHidden = true
        }
    }

}

extension KitsDetailedViewController: SwiftPhotoGalleryDelegate {

    func galleryDidTapToClose(gallery: SwiftPhotoGallery, index: Int) {
         let index = IndexPath(item: index, section: 0)
        headerView.carusel.collectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: false)
    }

    func deletePhoto(index: Int) {

    }

}

extension KitsDetailedViewController: SwiftPhotoGalleryDataSource {

    func imageInGallery(gallery: SwiftPhotoGallery, forIndex: Int) -> AnyObject? {
        return presenter.imageFromUrl()[forIndex] as AnyObject?
    }

    func numberOfImagesInGallery(gallery: SwiftPhotoGallery) -> Int {
        return presenter.imageFromUrl().count
    }
}

extension KitsDetailedViewController: BottomBarTransitionProtocol {

    func openModule(identifier: Int) {
        presenter.openModule(identifier: identifier)
    }

}

extension KitsDetailedViewController: UITableViewDataSource {


    func numberOfSections(in tableView: UITableView) -> Int {

        return presenter.numberOfSections()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if presenter.numberOfSections() == 5 {
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

        if presenter.numberOfSections() == 4 {
            switch section {
            case 0:
                return presenter.numberOfGeneralProperties(inSection: section)
            case 1:
                return presenter.numberOfAdditionalProperties(inSection: section)
            default:
                return 1
            }
        }
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GeneralCell") as? GeneralViewCell
        if presenter.numberOfSections() == 5 {
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

        if presenter.numberOfSections() == 4 {
            switch indexPath.section {
            case 0:
                cell?.configure(property: presenter.generalProperty(for: indexPath))
                return cell!
            case 1:
                cell?.configure(property:  presenter.additionalProperty(for: indexPath))
                return cell!
            case 2:
                let cell = tableView.dequeueReusableCell(withIdentifier: "DescriptionCell") as? DescriptionViewCell
                cell?.configure(property: presenter.descriptions(for: indexPath))
                return cell!
            default:
                let cell = tableView.dequeueReusableCell(withIdentifier: "DescriptionCell") as? DescriptionViewCell
                cell?.configure(property: presenter.notes(for: indexPath))
                return cell!
            }
        }
        let newCell = tableView.dequeueReusableCell(withIdentifier: "DescriptionCell") as? DescriptionViewCell
        newCell?.configure(property: presenter.notes(for: indexPath))
        return newCell!
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }

}

extension KitsDetailedViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = HeaderViewCreatePost()
        let viewRorSale = HeaderForSale()
        viewRorSale.price.text = presenter.getPrice()
        switch section {
        case 0:
            if presenter.numberOfSections() == 5 {
                if presenter.numberOfGeneralProperties(inSection: section) > 0 {
                    return view
                } else {
                    return nil
                }
            }
            if presenter.numberOfSections() == 4 {
                if presenter.numberOfGeneralProperties(inSection: section) > 0 {
                    return viewRorSale
                } else {
                    return nil
                }
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
        return nil
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            if presenter.numberOfSections() == 5 {
                if presenter.numberOfGeneralProperties(inSection: section) > 0 {
                    return 10
                } else {
                    return 0
                }
            }
            if presenter.numberOfSections() == 4 {
                if presenter.numberOfGeneralProperties(inSection: section) > 0 {
                    return 90
                } else {
                    return 0
                }
            }
        case 1:
            if presenter.numberOfAdditionalProperties(inSection: section) > 0 {
                return 10
            } else {
                return 0
            }
        case 2:
            return 10
        default:
            return 10
        }
        return 10
    }
    
}
