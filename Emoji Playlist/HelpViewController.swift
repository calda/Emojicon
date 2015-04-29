//
//  HelpViewController.swift
//  Emoji Playlist
//
//  Created by DFA Film 9: K-9 on 4/29/15.
//  Copyright (c) 2015 Cal Stephens. All rights reserved.
//

import UIKit

class HelpViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {

    @IBOutlet weak var pageCollection: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    

    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }

    override func viewWillAppear(animated: Bool) {
        pageCollection.collectionViewLayout = CellPagingLayout(pageWidth: self.view.frame.width)
        (pageCollection.collectionViewLayout as! CellPagingLayout).pageControl = pageControl
        pageCollection.decelerationRate = UIScrollViewDecelerationRateFast
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("\(indexPath.item)", forIndexPath: indexPath) as! UICollectionViewCell
        return cell
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return collectionView.frame.size
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0.0
    }
    
}
