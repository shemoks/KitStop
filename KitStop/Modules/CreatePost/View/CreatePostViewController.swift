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
        self.navigationItem.title = presenter.getTittle()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if (self.navigationItem.title?.isEmpty)! {
            self.navigationItem.title = presenter.getTittle()
        } else {
            self.navigationItem.title = ""
        }
//        self.navigationItem.title = ""
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let height = setSizeForCell()
        sizeHeaderToFit(height: height)

    }

    //    func setSizeForCell() {
    //        let layout = headerView.collectionView.collectionViewLayout as? UICollectionViewFlowLayout
    //        let width = headerView.frame.width
    //        let height = headerView.frame.height
    //        let padding: CGFloat = 5
    //        let numberOfItemWidth = 3
    //        let numberOfItemHeight = 2
    //        let sizeWidthCell = (width - padding * CGFloat(numberOfItemWidth))/CGFloat(numberOfItemWidth)
    //        let sizeHeightCell = (height - padding * CGFloat(numberOfItemHeight - 1))/CGFloat(numberOfItemHeight)
    //        layout?.itemSize.width = sizeWidthCell
    //        layout?.itemSize.height = sizeHeightCell
    //        layout?.minimumLineSpacing = padding
    //        layout?.minimumInteritemSpacing = padding
    //        layout?.invalidateLayout()
    //    }

    func setSizeForCell() -> CGFloat {
        let padding: CGFloat = 10
        let numberOfItemWidth = 3
        let numberOfItemHeight = 2
        let layout = headerView.collectionView.collectionViewLayout as? UICollectionViewFlowLayout
        let screenWidth = view.frame.width
        layout?.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout?.itemSize = CGSize(width: (screenWidth - 4 * padding - 2)/CGFloat(numberOfItemWidth), height: (screenWidth - 4 * padding - 2)/CGFloat(numberOfItemWidth))
        let headerHeight = (layout?.itemSize.height)! * CGFloat(numberOfItemHeight) + 3 * padding
        layout?.minimumInteritemSpacing = 10
        layout?.minimumLineSpacing = (layout?.minimumInteritemSpacing)!
        return headerHeight
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
        if presenter.setIsNotMainImage() {
            imagePicker.allowsEditing = false
        } else {
            imagePicker.allowsEditing = true
        }
        imagePicker.sourceType = .photoLibrary
        imagePicker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        imagePicker.modalPresentationStyle = .popover
        present(imagePicker, animated: true, completion: nil)
    }

    func openCamera() {
        if UIImagePickerController.availableCaptureModes(for: .rear) != nil {
            imagePicker.allowsEditing = true
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera
            imagePicker.cameraCaptureMode = .photo
            present(imagePicker, animated: true, completion: nil)
        } else {
            noCamera()
        }
    }

    func noCamera(){
        let alertVC = UIAlertController(
            title: "No Camera",
            message: "Sorry, this device has no camera",
            preferredStyle: .alert)
        let okAction = UIAlertAction(
            title: "OK",
            style:.default,
            handler: nil)
        alertVC.addAction(okAction)
        present(alertVC,
                animated: true,
                completion: nil)
    }


    func reloadData() {
        navigationItem.title = presenter.getTittle()
        tableView.reloadData()
        headerView.collectionView.reloadData()
    }

    func showError(title: String, message: String) {
        self.showAlertWithTitle(title, message: message)
    }

    func setupAlert() {
        let alertController = UIAlertController.init(title: nil, message: nil, preferredStyle: .actionSheet)
        let openCamera = UIAlertAction.init(title: "Take a Photo", style: .default, handler: {
            result in
            self.openCamera()
        })

        let openGallery = UIAlertAction.init(title: "Choose from Gallery", style: .default, handler: {
            result in
            self.openGallery()
        })

        let cancel = UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(openCamera)
        alertController.addAction(openGallery)
        alertController.addAction(cancel)
        self.present(alertController, animated: true, completion: nil)
        alertController.view.tintColor = UIColor.gray

    }

    func returnImages(images: [AnyObject], index: Int) {
        let gallery = SwiftPhotoGallery(delegate: self, dataSource: self, trashButtonStatus: true, pageBeforeRotation: index, page: index)
        present(gallery, animated: true, completion: nil)

    }

}
extension CreatePostViewController: SwiftPhotoGalleryDelegate {

    func galleryDidTapToClose(gallery: SwiftPhotoGallery, index: Int) {

    }

    func deletePhoto(index: Int) {
        presenter.anyObject.remove(at: index)
        presenter.deletePhoto(index: index)
    }


}

extension CreatePostViewController: SwiftPhotoGalleryDataSource {
    func numberOfImagesInGallery(gallery: SwiftPhotoGallery) -> Int {
        return presenter.anyObject.count
    }

    func imageInGallery(gallery: SwiftPhotoGallery, forIndex: Int) -> AnyObject? {
        return presenter.anyObject[forIndex]
    }

}
extension CreatePostViewController: UITableViewDataSource {


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
        default:
            return 10
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.section {
        case 0:
            presenter.isSelectedCell(inSection: 0, for: indexPath)
            let cell = tableView.cellForRow(at: indexPath) as? GeneralCell
            cell?.data.becomeFirstResponder()
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
        let type = presenter.getModelItem(index: indexPath.row)
        switch type {
        case .Required:
            self.setupAlert()
        case .Add:
            self.setupAlert()
        case .Blank:
            self.setupAlert()
        default:
            presenter.handleFullScreenOpen(index: indexPath.row)

        }
    }


}

extension CreatePostViewController: UICollectionViewDataSource {

    func collectionView(_ collectionViews: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.numberOfPhoto()
    }

    func collectionView(_ collectionViews: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = headerView.collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as? PhotoCellNew
        cell?.configure(typeImage:presenter.getModelItem(index: indexPath.row))
        return cell!
    }

}

extension CreatePostViewController: UIImagePickerControllerDelegate {

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        dismiss(animated: true, completion: nil)
        var originalImage:UIImage?, editedImage:UIImage?, imageToSave:UIImage?
        editedImage = info[UIImagePickerControllerEditedImage] as! UIImage?
        originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage?
        imageToSave = originalImage
        if presenter.setIsNotMainImage() == false {
            self.presenter.setMainPhoto(photo: editedImage!)
        }
        presenter.addPhoto(image: imageToSave!)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}







