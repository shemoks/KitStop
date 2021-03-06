//
//  SwiftPhotoGalleryCell.swift
//  FullScreenPreview
//
//  Created by sasha ataman on 24.01.17.
//  Copyright © 2017 sasha ataman. All rights reserved.
//

import UIKit

class SwiftPhotoGalleryCell: UICollectionViewCell {
    var image:AnyObject? {
        didSet {
            configureForNewImage()
        }
    }

    private var scrollView: UIScrollView
    fileprivate let imageView: UIImageView

    override init(frame: CGRect) {
        imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        scrollView = UIScrollView(frame: frame)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        super.init(frame: frame)
        var scrollViewConstraints: [NSLayoutConstraint] = []
        var imageViewConstraints: [NSLayoutConstraint] = []
        scrollViewConstraints.append(NSLayoutConstraint(item: scrollView,
                                                        attribute: .leading,
                                                        relatedBy: .equal,
                                                        toItem: contentView,
                                                        attribute: .leading,
                                                        multiplier: 1,
                                                        constant: 0))

        scrollViewConstraints.append(NSLayoutConstraint(item: scrollView,
                                                        attribute: .top,
                                                        relatedBy: .equal,
                                                        toItem: contentView,
                                                        attribute: .top,
                                                        multiplier: 1,
                                                        constant: 0))

        scrollViewConstraints.append(NSLayoutConstraint(item: scrollView,
                                                        attribute: .trailing,
                                                        relatedBy: .equal,
                                                        toItem: contentView,
                                                        attribute: .trailing,
                                                        multiplier: 1,
                                                        constant: 0))

        scrollViewConstraints.append(NSLayoutConstraint(item: scrollView,
                                                        attribute: .bottom,
                                                        relatedBy: .equal,
                                                        toItem: contentView,
                                                        attribute: .bottom,
                                                        multiplier: 1,
                                                        constant: 0))

        contentView.addSubview(scrollView)
        contentView.addConstraints(scrollViewConstraints)

        imageViewConstraints.append(NSLayoutConstraint(item: imageView,
                                                       attribute: .leading,
                                                       relatedBy: .equal,
                                                       toItem: scrollView,
                                                       attribute: .leading,
                                                       multiplier: 1,
                                                       constant: 0))

        imageViewConstraints.append(NSLayoutConstraint(item: imageView,
                                                       attribute: .top,
                                                       relatedBy: .equal,
                                                       toItem: scrollView,
                                                       attribute: .top,
                                                       multiplier: 1,
                                                       constant: 0))

        imageViewConstraints.append(NSLayoutConstraint(item: imageView,
                                                       attribute: .trailing,
                                                       relatedBy: .equal,
                                                       toItem: scrollView,
                                                       attribute: .trailing,
                                                       multiplier: 1,
                                                       constant: 0))

        imageViewConstraints.append(NSLayoutConstraint(item: imageView,
                                                       attribute: .bottom,
                                                       relatedBy: .equal,
                                                       toItem: scrollView,
                                                       attribute: .bottom,
                                                       multiplier: 1,
                                                       constant: 0))

        scrollView.addSubview(imageView)
        scrollView.addConstraints(imageViewConstraints)

        scrollView.delegate = self

        setupGestureRecognizer()
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func doubleTapAction(recognizer: UITapGestureRecognizer) {

        if (scrollView.zoomScale > scrollView.minimumZoomScale) {
            scrollView.setZoomScale(scrollView.minimumZoomScale, animated: true)
        } else {
            scrollView.setZoomScale(scrollView.maximumZoomScale, animated: true)
        }
    }

    func configureForNewImage() {
        if let img = image as? UIImage {
            imageView.image = img
            setup()
        } else {
            self.setup()
            imageView.sd_setImage(with: image as! URL, placeholderImage: UIImage(named: "placeholder1080x1080"), options: [], completed: {
                completed in
                self.setup()
            })
        }
    }

    func setup() {
        imageView.sizeToFit()
        imageView.alpha = 0.0
        setZoomScale()
        scrollViewDidZoom(scrollView)
        UIView.animate(withDuration: 0.5) {
            self.imageView.alpha = 1.0
        }

    }

    // MARK: Private Methods
    private func setupGestureRecognizer() {

        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(doubleTapAction(recognizer:)))
        doubleTap.numberOfTapsRequired = 2
        self.addGestureRecognizer(doubleTap)
    }

    private func setZoomScale() {
        let imageViewSize = imageView.bounds.size
        let scrollViewSize = scrollView.bounds.size
        let widthScale = scrollViewSize.width / imageViewSize.width
        let heightScale = scrollViewSize.height / imageViewSize.height

        scrollView.minimumZoomScale = min(widthScale, heightScale)
        scrollView.setZoomScale(scrollView.minimumZoomScale, animated: false)
    }

}
// MARK: UIScrollViewphotoDelegate Methods
extension SwiftPhotoGalleryCell: UIScrollViewDelegate {

    public func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }

    public func scrollViewDidZoom(_ scrollView: UIScrollView) {

        let imageViewSize = imageView.frame.size
        let scrollViewSize = scrollView.bounds.size

        let verticalPadding = imageViewSize.height < scrollViewSize.height ? (scrollViewSize.height - imageViewSize.height) / 2 : 0
        let horizontalPadding = imageViewSize.width < scrollViewSize.width ? (scrollViewSize.width - imageViewSize.width) / 2 : 0

        if verticalPadding >= 0 {
            scrollView.contentInset = UIEdgeInsets(top: verticalPadding, left: horizontalPadding, bottom: verticalPadding, right: horizontalPadding)
        } else {
            scrollView.contentSize = imageViewSize
        }
    }
}


