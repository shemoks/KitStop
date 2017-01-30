//
//  Carusel.swift
//  KitStop
//
//  Created by Mac on 1/25/17.
//  Copyright © 2017 MOZI Development. All rights reserved.
//


import UIKit

class Carusel: UIView {
    typealias ButtonAction = (Int, [String], Bool) -> ()
    var onTouch: ButtonAction?
    var view: UIView!
    var nibName: String = "Carusel"
    var images = [String]()
    var isPrivatePost: Bool = true
    var heightCell: CGFloat = 0
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    override func awakeFromNib() {
        super.awakeFromNib()

    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        setup()
    }

    func setup() {
        view = loadViewFromNib()
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(view)
      //  let swipe = UIPanGestureRecognizer(target: self,action: #selector(handleSwipe))
     //   collectionView.addGestureRecognizer(swipe)
        collectionView.register(UINib(nibName: "CaruselCell",bundle: nil), forCellWithReuseIdentifier: "CaruselCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.reloadData()

    }

//    func handleSwipe(recognizer:UIPanGestureRecognizer) {
//        let translation = recognizer.translation(in: self.view)
//        recognizer.setTranslation(CGPoint.zero, in: self.view)
//       switch(recognizer.state) {
//        case UIGestureRecognizerState.changed:
//            if translation.x > 0 {
//                print(translation.x)
//                let add = collectionView.contentOffset.x
//                let index = lroundf(Float(add/heightCell))
//                if index < images.count && index > 0 {
//                   collectionView.scrollToItem(at: IndexPath.init(row: index - 1, section: 0), at: UICollectionViewScrollPosition.centeredHorizontally, animated: true)
//                    pageControl.currentPage = index - 1
//                }
//                if index == 0 {
//                    collectionView.scrollToItem(at: IndexPath.init(row: index, section: 0), at: UICollectionViewScrollPosition.centeredHorizontally, animated: true)
//                    pageControl.currentPage = 0
//                }
//            }
//                else {
//                let add = collectionView.contentOffset.x
//                let index = lroundf(Float(add/heightCell))
//                if index >= 0 && index < images.count - 1 {
//                collectionView.scrollToItem(at: IndexPath.init(row: index + 1, section: 0), at: UICollectionViewScrollPosition.centeredHorizontally, animated: true)
//                    pageControl.currentPage = index + 1
//                }
//        }
//        case UIGestureRecognizerState.ended:
//            let velocity = recognizer.velocity(in: self.view)
//            let magnitude = sqrt((velocity.x * velocity.x) + (velocity.y * velocity.y))
//            let slideMultiplier = magnitude / 200
//
//            let slideFactor = 0.1 * slideMultiplier
//            var finalPoint = CGPoint(x:view.center.x ,
//                                     y:recognizer.view!.center.y + (velocity.y * slideFactor))
//            finalPoint.x = view.center.x + translation.x
//            finalPoint.y = view.center.y
//
//            UIView.animate(withDuration: Double(slideFactor * 2),
//                           delay: 0,
//                           options: UIViewAnimationOptions.curveEaseOut,
//                           animations: {recognizer.view!.center = finalPoint },
//                           completion: nil)
//
//        default:
//            collectionView.cancelInteractiveMovement()
//    }
//    }

    func loadViewFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        return view
    }

}

extension Carusel: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        onTouch?(indexPath.row, images, false)
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//        collectionView.contentSize.width
        let add = collectionView.contentOffset.x
        let index = lroundf(Float(add/heightCell))
        pageControl.currentPage = index
    }

}

extension Carusel: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CaruselCell", for: indexPath) as! CaruselCell
        let urlValue = URL(string: images[indexPath.row])
        if urlValue != nil {
            cell.photo.sd_setImage(with: urlValue)
        }
        return cell
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
}


