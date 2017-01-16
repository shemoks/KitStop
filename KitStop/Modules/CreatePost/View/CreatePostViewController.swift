//
//  CreatePostViewController.swift
//  KitStop
//
//  Created by Shemshur Oksana on 03/01/2017.
//  Copyright © 2017 MoziDev. All rights reserved.
//

import Chamomile

// MARK: - CreatePostViewController

final class CreatePostViewController: UIViewController, FlowController, UINavigationControllerDelegate, Alertable, ResizeTextViewDelegate {


    @IBOutlet weak var tableView: UITableView!
    // MARK: - VIPER stack
    @IBAction func NextTap(_ sender: Any) {
        presenter.handleNextTap()
    }
    var presenter: CreatePostViewOutput!
    let imagePicker = UIImagePickerController()
    let headerView = HeaderTableView()
    var cell = DescriptionCell()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "GeneralCell", bundle: nil), forCellReuseIdentifier: "GeneralCell")
        tableView.register(UINib(nibName: "DescriptionCell", bundle: nil), forCellReuseIdentifier: "DescriptionCell")
        navigationController?.navigationBar.tintColor = .black
        imagePicker.navigationBar.tintColor = .black
        imagePicker.delegate = self
        headerView.collectionView.register(UINib(nibName: "PhotoCell", bundle: nil), forCellWithReuseIdentifier: "PhotoCell")
        headerView.collectionView.delegate = self
        headerView.collectionView.dataSource = self
        tableView.tableHeaderView = headerView
        presenter.handleViewDidLoad()
        self.tableView.estimatedRowHeight = 50.0
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.updateData()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        sizeHeaderToFit()
        setSizeForCell()
    }

    func setSizeForCell() {
        let layout = headerView.collectionView.collectionViewLayout as? UICollectionViewFlowLayout
        let width = headerView.frame.width
        let height = headerView.frame.height
        let padding: CGFloat = 5
        let numberOfItemWidth = 3
        let numberOfItemHeight = 2
        let sizeWidthCell = (width - padding * CGFloat(numberOfItemWidth))/CGFloat(numberOfItemWidth)
        let sizeHeightCell = (height - padding * CGFloat(numberOfItemHeight - 1))/CGFloat(numberOfItemHeight)
        layout?.itemSize.width = sizeWidthCell
        layout?.itemSize.height = sizeHeightCell
        layout?.minimumLineSpacing = padding
        layout?.minimumInteritemSpacing = padding
        layout?.invalidateLayout()
    }

    func sizeHeaderToFit() {
        let headerView = tableView.tableHeaderView!
        headerView.setNeedsLayout()
        headerView.layoutIfNeeded()
        var frame = headerView.frame
        frame.size.height = 250
        headerView.frame = frame
        tableView.tableHeaderView = headerView
    }

    func resizeTextView(textView: UITextView) {
        let startHeight = textView.frame.size.height
        let calcHeight = textView.sizeThatFits(textView.frame.size).height
        if startHeight != calcHeight {
            UIView.setAnimationsEnabled(false)
            self.tableView.beginUpdates()
            self.tableView.endUpdates()
            UIView.setAnimationsEnabled(true)
        }
    }
}

// MARK: - CreatePostViewInput

extension CreatePostViewController: CreatePostViewInput {

    func openGallery() {
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        imagePicker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        imagePicker.modalPresentationStyle = .popover
        present(imagePicker, animated: true, completion: nil)
    }

    func reloadData() {
        navigationItem.title = presenter.getTittle()
        tableView.reloadData()
        headerView.collectionView.reloadData()
    }

    func showError(title: String, message: String) {
        self.showAlertWithTitle(title, message: message)
    }

}

extension CreatePostViewController:UITableViewDataSource {


    func numberOfSections(in tableView: UITableView) -> Int {

        return 4
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        switch section {
        case 0:
            return presenter.numberOfGeneralProperties(inSection: section)
        case 1:
            return presenter.numberOfAdditionalProperties(inSection: section)
        default:
            return 1
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GeneralCell") as? GeneralCell
        switch indexPath.section {
        case 0:
            cell?.configure(property: presenter.generalProperty(for: indexPath))
            return cell!
        case 1:
            cell?.configure(property:  presenter.additionalProperty(for: indexPath))
            return cell!
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "DescriptionCell") as? DescriptionCell
            cell?.configure(property: presenter.descriptions(for: indexPath))
            cell?.delegate = self
            return cell!
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "DescriptionCell") as? DescriptionCell
            cell?.configure(property: presenter.notes(for: indexPath))
            cell?.delegate = self
            return cell!
        }
    }


    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }

}

extension CreatePostViewController: UITableViewDelegate {

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
        default:
            return view
        }
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.section {
        case 0:
            presenter.isSelectedCell(inSection: 0, for: indexPath)
        case 1:
            presenter.isSelectedCell(inSection: 1, for: indexPath)
        default:
            presenter.isSelectedCell(inSection: 2, for: indexPath)
        }

    }


}
extension CreatePostViewController: UICollectionViewDelegate {

    func numberOfSectionsInCollectionView(collectionViews: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionViews: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.handleCollectionCellTap(for: indexPath)
    }


}

extension CreatePostViewController: UICollectionViewDataSource {

    func collectionView(_ collectionViews: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.numberOfPhoto()
    }

    func collectionView(_ collectionViews: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = headerView.collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as? PhotoCell
        cell?.configure(image: presenter.photoProperty(for: indexPath))
        return cell!
    }

}

extension CreatePostViewController: UIImagePickerControllerDelegate {

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        dismiss(animated: true, completion: nil)
        var originalImage:UIImage?, editedImage:UIImage?, imageToSave:UIImage?
        editedImage = info[UIImagePickerControllerEditedImage] as! UIImage?
        originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage?
        if ( editedImage != nil ) {
            imageToSave = editedImage
        } else {
            imageToSave = originalImage
        }
        presenter.setPhoto(photo: imageToSave!)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}







