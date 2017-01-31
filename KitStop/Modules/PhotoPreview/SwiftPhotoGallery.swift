//
//  SwiftPhotoGallery.swift
//  FullScreenPreview
//
//  Created by sasha ataman on 24.01.17.
//  Copyright © 2017 sasha ataman. All rights reserved.
//

import Foundation
import UIKit

@objc public protocol SwiftPhotoGalleryDataSource {
    func numberOfImagesInGallery(gallery:SwiftPhotoGallery) -> Int
    func imageInGallery(gallery:SwiftPhotoGallery, forIndex:Int) -> AnyObject?
}

@objc public protocol SwiftPhotoGalleryDelegate {
    func galleryDidTapToClose(gallery:SwiftPhotoGallery, index: Int)
    func deletePhoto(index: Int)
}

public class SwiftPhotoGallery: UIViewController {

    public weak var dataSource: SwiftPhotoGalleryDataSource?
    public weak var delegate: SwiftPhotoGalleryDelegate?

    public lazy var imageCollectionView: UICollectionView = self.setupCollectionView()

    public var numberOfImages: Int {
        return collectionView(imageCollectionView, numberOfItemsInSection: 0)
    }

    public var backgroundColor: UIColor {
        get {
            return view.backgroundColor!
        }
        set(newBackgroundColor) {
            view.backgroundColor = newBackgroundColor
        }
    }

    public var currentPageIndicatorTintColor: UIColor {
        get {
            return pageControl.currentPageIndicatorTintColor!
        }

        set(newCurrentPageIndicatorTintColor) {
            pageControl.currentPageIndicatorTintColor = newCurrentPageIndicatorTintColor
        }
    }

    public var pageIndicatorTintColor: UIColor {
        get {
            return pageControl.pageIndicatorTintColor!
        }

        set(newPageIndicatorTintColor) {
            pageControl.pageIndicatorTintColor = newPageIndicatorTintColor
        }
    }

    public var currentPage: Int {
        set(page) {
            if page < numberOfImages {
                scrollToImage(withIndex: page, animated: false)
            } else {
                scrollToImage(withIndex: numberOfImages - 1, animated: false)
            }
            updatePageControl()
        }
        get {
            pageBeforeRotation = Int(imageCollectionView.contentOffset.x / imageCollectionView.frame.size.width)
            return Int(imageCollectionView.contentOffset.x / imageCollectionView.frame.size.width)
        }
    }

    public var hidePageControl: Bool = false {
        didSet {
            pageControl.isHidden = hidePageControl
        }
    }

    private var pageBeforeRotation: Int = 0
    private var currentIndexPath: IndexPath = IndexPath(item: 0, section: 0)
    private var flowLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    fileprivate var pageControl: UIPageControl = UIPageControl()
    private var pageControlBottomConstraint: NSLayoutConstraint?
    private var pageControlCenterXConstraint: NSLayoutConstraint?
    private var needsLayout = true
    fileprivate var navBar: UINavigationBar?
    fileprivate var trashButtonStatus: Bool = false
    fileprivate var page: Int = 0

    public init(delegate: SwiftPhotoGalleryDelegate, dataSource: SwiftPhotoGalleryDataSource, trashButtonStatus: Bool, pageBeforeRotation: Int, page: Int) {
        super.init(nibName: nil, bundle: nil)

        self.dataSource = dataSource
        self.delegate = delegate
        self.trashButtonStatus = trashButtonStatus
        self.pageBeforeRotation = pageBeforeRotation
        self.page = page
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    public func reload(imageIndexes:Int...) {

        if imageIndexes.isEmpty {
            imageCollectionView.reloadData()

        } else {
            let indexPaths: [IndexPath] = imageIndexes.map({IndexPath(item: $0, section: 0)})
            imageCollectionView.reloadItems(at: indexPaths)
        }
    }

    public override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        flowLayout.itemSize = view.bounds.size
    }

    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if needsLayout {
            let desiredIndexPath = IndexPath(item: pageBeforeRotation, section: 0)

            if pageBeforeRotation > 0 {
                scrollToImage(withIndex: pageBeforeRotation, animated: false)
            }

            imageCollectionView.reloadItems(at: [desiredIndexPath])

            for cell in imageCollectionView.visibleCells {
                if let cell = cell as? SwiftPhotoGalleryCell {
                    cell.configureForNewImage()
                }

            }

            needsLayout = false
        }
    }

    public override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.black
<<<<<<< HEAD
        
=======

>>>>>>> 4bfc0aa003243c1687815bba2389ed1d0d1515c5
        if numberOfImages > 1 {
            self.hidePageControl = false
        } else {
            self.hidePageControl = true
        }

        pageControl.currentPageIndicatorTintColor = UIColor.white
        pageControl.pageIndicatorTintColor = UIColor(white: 0.75, alpha: 0.35) //Dim Grey
        setupPageControl()
        setupGestureRecognizer()
        addNavigationBar()
    }

    public func addNavigationBar() {
        navBar = UINavigationBar(frame: CGRect(x: 0, y: UIApplication.shared.statusBarFrame.height, width: self.view.frame.width, height: 44))
        navBar?.setBackgroundImage(UIImage(), for: .default)
        navBar?.shadowImage = UIImage()
        navBar?.isTranslucent = true
        self.view.addSubview(navBar!)
        let navItem = UINavigationItem(title: "")
        if self.trashButtonStatus {
            let trash = UIBarButtonItem.init(image: UIImage(named: "trash"), style: .done, target: self, action: #selector(deleteImages))
            trash.tintColor = .white
            navItem.rightBarButtonItem = trash
        }
        let close = UIBarButtonItem.init(image: UIImage(named: "back_arrow"), style: .done, target: self, action: #selector(close(recognizer:)))
        close.tintColor = .white
        navItem.leftBarButtonItem = close
        navBar?.setItems([navItem], animated: false)
    }

    func deleteImages() {
        if self.numberOfImages != 0 {
            let alertController = UIAlertController(title: "Delete", message: "Are you want delete photo", preferredStyle: .alert)
            let yes = UIAlertAction(title: "Yes", style: .default, handler: {
                result in
                self.delegate?.deletePhoto(index: self.pageControl.currentPage)
                self.imageCollectionView.reloadData()
                self.pageControl.numberOfPages = self.numberOfImages
            })
            let no = UIAlertAction(title: "No", style: .default, handler: nil)
            alertController.addAction(no)
            alertController.addAction(yes)

            present(alertController, animated: true, completion: nil)
        } else {
            delegate?.galleryDidTapToClose(gallery: self, index: 0)
            dismiss(animated: true, completion: nil)
        }

    }


    public override var prefersStatusBarHidden: Bool {
        get {
            return false
        }
    }

    public override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }


    public override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        needsLayout = true
    }

    public override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        get {
            return .allButUpsideDown
        }
    }

    public override var shouldAutorotate: Bool {
        get {
            return true
        }
    }


    func updatePageControl() {
        pageControl.currentPage = currentPage
    }


    private func setupGestureRecognizer() {
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(tapPhoto))
        singleTap.numberOfTapsRequired = 1
        singleTap.delegate = self
        imageCollectionView.addGestureRecognizer(singleTap)
    }

    public func tapPhoto() {

        UIView.animate(withDuration: 0.5, delay: 0.0, options: UIViewAnimationOptions.curveEaseInOut, animations: { () -> Void in
            if self.navBar?.alpha == 1.0 {
                self.pageControl.alpha = 0.0
                self.navBar?.alpha = 0.0
            } else {
                self.pageControl.alpha = 1.0
                self.navBar?.alpha = 1.0
            }
        }, completion: nil)
    }

    public func close(recognizer: UITapGestureRecognizer) {
        dismiss(animated: true, completion: {
            self.delegate?.galleryDidTapToClose(gallery: self, index: self.currentPage)
        })
    }


    // MARK: Private Methods
    private func setupCollectionView() -> UICollectionView {
        // Set up flow layout
        flowLayout.scrollDirection = UICollectionViewScrollDirection.horizontal
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.minimumLineSpacing = 0

        // Set up collection view
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(SwiftPhotoGalleryCell.self, forCellWithReuseIdentifier: "SwiftPhotoGalleryCell")
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isPagingEnabled = true
        collectionView.backgroundColor = UIColor.clear

        // Set up collection view constraints
        var imageCollectionViewConstraints: [NSLayoutConstraint] = []
        imageCollectionViewConstraints.append(NSLayoutConstraint(item: collectionView,
                                                                 attribute: .leading,
                                                                 relatedBy: .equal,
                                                                 toItem: view,
                                                                 attribute: .leading,
                                                                 multiplier: 1,
                                                                 constant: 0))

        imageCollectionViewConstraints.append(NSLayoutConstraint(item: collectionView,
                                                                 attribute: .top,
                                                                 relatedBy: .equal,
                                                                 toItem: view,
                                                                 attribute: .top,
                                                                 multiplier: 1,
                                                                 constant: 0))

        imageCollectionViewConstraints.append(NSLayoutConstraint(item: collectionView,
                                                                 attribute: .trailing,
                                                                 relatedBy: .equal,
                                                                 toItem: view,
                                                                 attribute: .trailing,
                                                                 multiplier: 1,
                                                                 constant: 0))

        imageCollectionViewConstraints.append(NSLayoutConstraint(item: collectionView,
                                                                 attribute: .bottom,
                                                                 relatedBy: .equal,
                                                                 toItem: view,
                                                                 attribute: .bottom,
                                                                 multiplier: 1,
                                                                 constant: 0))

        view.addSubview(collectionView)
        view.addConstraints(imageCollectionViewConstraints)

        collectionView.contentSize = CGSize(width: 1000.0, height: 1.0)

        return collectionView
    }

    private func setupPageControl() {

        pageControl.translatesAutoresizingMaskIntoConstraints = false

        pageControl.numberOfPages = numberOfImages
        pageControl.currentPage = self.page

        pageControl.currentPageIndicatorTintColor = currentPageIndicatorTintColor
        pageControl.pageIndicatorTintColor = pageIndicatorTintColor

        pageControl.alpha = 1
        pageControl.isHidden = hidePageControl

        view.addSubview(pageControl)

        pageControlCenterXConstraint = NSLayoutConstraint(item: pageControl,
                                                          attribute: NSLayoutAttribute.centerX,
                                                          relatedBy: NSLayoutRelation.equal,
                                                          toItem: view,
                                                          attribute: NSLayoutAttribute.centerX,
                                                          multiplier: 1.0,
                                                          constant: 0)

        pageControlBottomConstraint = NSLayoutConstraint(item: view,
                                                         attribute: NSLayoutAttribute.bottom,
                                                         relatedBy: NSLayoutRelation.equal,
                                                         toItem: pageControl,
                                                         attribute: NSLayoutAttribute.bottom,
                                                         multiplier: 1.0,
                                                         constant: 15)

        view.addConstraints([pageControlCenterXConstraint!, pageControlBottomConstraint!])
    }

    private func scrollToImage(withIndex: Int, animated: Bool = false) {
        imageCollectionView.scrollToItem(at: IndexPath(item: withIndex, section: 0), at: .centeredHorizontally, animated: animated)
    }

    fileprivate func getImage(currentPage: Int) -> AnyObject {
        let imageForPage = dataSource?.imageInGallery(gallery: self, forIndex: currentPage)
        return imageForPage!
    }

}

// MARK: UICollectionViewDataSource Methods
extension SwiftPhotoGallery: UICollectionViewDataSource {

    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    public func collectionView(_ imageCollectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource?.numberOfImagesInGallery(gallery: self) ?? 0
    }

    public func collectionView(_ imageCollectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = imageCollectionView.dequeueReusableCell(withReuseIdentifier: "SwiftPhotoGalleryCell", for: indexPath) as! SwiftPhotoGalleryCell
        cell.image = getImage(currentPage: indexPath.row)
        return cell
    }
}

// MARK: UICollectionViewDelegate Methods
extension SwiftPhotoGallery: UICollectionViewDelegate {

    public func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.pageControl.alpha = 1.0
    }

    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {

        updatePageControl()

        //        UIView.animate(withDuration: 1.0, delay: 2.0, options: UIViewAnimationOptions.curveEaseInOut, animations: { () -> Void in
        //            self.pageControl.alpha = 0.0
        //            self.navBar?.alpha = 0.0
        //        }, completion: nil)
    }

    public func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let cell = cell as? SwiftPhotoGalleryCell {
            cell.configureForNewImage()
        }
    }
}

// MARK: UIGestureRecognizerDelegate Methods
extension SwiftPhotoGallery: UIGestureRecognizerDelegate {
    
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRequireFailureOf otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        
        return try! otherGestureRecognizer is UITapGestureRecognizer &&
            gestureRecognizer is UITapGestureRecognizer &&
            otherGestureRecognizer.view is SwiftPhotoGalleryCell &&
            gestureRecognizer.view == imageCollectionView
    }
}
