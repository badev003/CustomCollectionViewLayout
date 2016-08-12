//
//  CollectionViewController.swift
//  CustomCollectionLayout
//
//  Created by JOSE MARTINEZ on 15/12/2014.
//  Copyright (c) 2014 brightec. All rights reserved.
//

import UIKit

class CollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    let dateCellIdentifier = "DateCellIdentifier"
    let contentCellIdentifier = "ContentCellIdentifier"
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var leftCollectionView: UICollectionView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView.registerNib(UINib(nibName: "DateCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: dateCellIdentifier)
        self.collectionView.registerNib(UINib(nibName: "ContentCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: contentCellIdentifier)
        self.leftCollectionView.registerNib(UINib(nibName: "ContentCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: contentCellIdentifier)
        
        self.collectionView.showsVerticalScrollIndicator = false
        self.leftCollectionView.showsVerticalScrollIndicator = false
        
        self.collectionView.showsHorizontalScrollIndicator = false
        self.leftCollectionView.showsHorizontalScrollIndicator = false
        
        //Now set Tag to identify the collectionViews
        self.collectionView.tag = 1000
        self.leftCollectionView.tag = 1001
    }
    
    
    // MARK - UICollectionViewDataSource
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 50
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionView.tag == 1000 ?  6 : 5
    }
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 0 {
            if indexPath.row == 0 && collectionView.tag == 1000 {
                let dateCell : DateCollectionViewCell = collectionView .dequeueReusableCellWithReuseIdentifier(dateCellIdentifier, forIndexPath: indexPath) as! DateCollectionViewCell
                dateCell.backgroundColor = UIColor.whiteColor()
                dateCell.dateLabel.font = UIFont.systemFontOfSize(13)
                dateCell.dateLabel.textColor = UIColor.blackColor()
                dateCell.dateLabel.text = "Date"
                
                return dateCell
            } else {
                let contentCell : ContentCollectionViewCell = collectionView .dequeueReusableCellWithReuseIdentifier(contentCellIdentifier, forIndexPath: indexPath) as! ContentCollectionViewCell
                contentCell.contentLabel.font = UIFont.systemFontOfSize(13)
                contentCell.contentLabel.textColor = UIColor.blackColor()
                contentCell.contentLabel.text = "Section"
                
                if indexPath.section % 2 != 0 {
                    contentCell.backgroundColor = UIColor(white: 242/255.0, alpha: 1.0)
                } else {
                    contentCell.backgroundColor = UIColor.whiteColor()
                }
                
                return contentCell
            }
        } else {
            if indexPath.row == 0  && collectionView.tag == 1000 {
                let dateCell : DateCollectionViewCell = collectionView .dequeueReusableCellWithReuseIdentifier(dateCellIdentifier, forIndexPath: indexPath) as! DateCollectionViewCell
                dateCell.dateLabel.font = UIFont.systemFontOfSize(13)
                dateCell.dateLabel.textColor = UIColor.blackColor()
                dateCell.dateLabel.text = String(indexPath.section)
                if indexPath.section % 2 != 0 {
                    dateCell.backgroundColor = UIColor(white: 242/255.0, alpha: 1.0)
                } else {
                    dateCell.backgroundColor = UIColor.whiteColor()
                }
                
                return dateCell
            } else {
                let contentCell : ContentCollectionViewCell = collectionView .dequeueReusableCellWithReuseIdentifier(contentCellIdentifier, forIndexPath: indexPath) as! ContentCollectionViewCell
                contentCell.contentLabel.font = UIFont.systemFontOfSize(13)
                contentCell.contentLabel.textColor = UIColor.blackColor()
                contentCell.contentLabel.text = "Content"
                if indexPath.section % 2 != 0 {
                    contentCell.backgroundColor = UIColor(white: 242/255.0, alpha: 1.0)
                } else {
                    contentCell.backgroundColor = UIColor.whiteColor()
                }
                
                return contentCell
            }
        }
    }
    
    private func scrollViewScrollToPoint(point: CGPoint, scrollView: UIScrollView) {
        if scrollView.isEqual(self.collectionView) {
            let leftCollectionViewOffSetX = self.leftCollectionView.contentSize.width - self.leftCollectionView.bounds.size.width - point.x
            self.leftCollectionView.contentOffset.y = point.y
            self.leftCollectionView.contentOffset.x = leftCollectionViewOffSetX
        } else {
            self.collectionView.contentOffset.y = point.y
            let leftCollectionViewOffSetX = self.leftCollectionView.contentSize.width - self.leftCollectionView.bounds.size.width - point.x
            self.collectionView.contentOffset.x = leftCollectionViewOffSetX
        }
        scrollView.contentOffset = point
    }
    
    private func enableScrolling(time: Float, scrollView: UIScrollView) {
        let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(time * Float(NSEC_PER_SEC)))
        dispatch_after(delayTime, dispatch_get_main_queue()) {
            scrollView.scrollEnabled = true
        }
    }

}

extension CollectionViewController : UIScrollViewDelegate {
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let offSet = scrollView.contentOffset
        guard offSet.x < scrollView.contentSize.width - scrollView.bounds.size.width && offSet.x >= 0 else {
            scrollView.scrollEnabled = false
            self.enableScrolling(0.01, scrollView: scrollView)
            return
        }
        self.scrollViewScrollToPoint(scrollView.contentOffset, scrollView: scrollView)
    }
    
    func scrollViewShouldScrollToTop(scrollView: UIScrollView) -> Bool {
        return false
    }
}

