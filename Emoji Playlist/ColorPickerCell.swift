//
//  ColorPickerCell.swift
//  Emoji Playlist
//
//  Created by Cal on 6/20/15.
//  Copyright (c) 2015 Cal Stephens. All rights reserved.
//

import Foundation
import UIKit

class ColorPickerCell : UITableViewCell, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    var saturation: CGFloat = 0.7
    var brightness: CGFloat = 0.9
    var cellMap = ["plus", "minus"]
    var currentColor: UIColor?
    @IBOutlet weak var clearLeading: NSLayoutConstraint!
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20 + cellMap.count
    }
    
    func colorForIndex(indexPath: NSIndexPath) -> UIColor {
        let hue = CGFloat(Double(indexPath.item - cellMap.count) * 0.0473)
        let color = UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: 1.0)
        return color
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        if indexPath.item < cellMap.count {
            return collectionView.dequeueReusableCellWithReuseIdentifier(cellMap[indexPath.item], forIndexPath: indexPath) as! UICollectionViewCell
        }
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("color", forIndexPath: indexPath) as! UICollectionViewCell
        cell.backgroundColor = colorForIndex(indexPath)
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let height = collectionView.frame.height
        return CGSizeMake(height, height)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsZero
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0.0
    }
    
    //pragma MARK: - User Interaction
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let index = indexPath.item
        
        if index >= cellMap.count {
            colorTap(collectionView, indexPath: indexPath)
            return
        }
        
        let cell = cellMap[index]
        
        if cell == "plus" {
            plusTap(collectionView)
        }
        else if cell == "minus" {
            minusTap(collectionView)
        }
    }
    
    func plusTap(collectionView: UICollectionView) {
        saturation += 0.1
        //brightness += 0.1
        saturation = min(saturation, 0.8)
        brightness = min(brightness, 1.0)
        collectionView.reloadData()
        updateSelectedColor()
    }
    
    func minusTap(collectionView: UICollectionView) {
        saturation -= 0.1
        //brightness -= 0.1
        saturation = max(saturation, 0.0)
        brightness = max(brightness, 0.2)
        collectionView.reloadData()
        updateSelectedColor()
    }
    
    @IBAction func clearTap(sender: AnyObject) {
        //send notification
        currentColor = nil
        NSNotificationCenter.defaultCenter().postNotificationName(EIChangeColorNotification, object: UIColor.whiteColor(), userInfo: nil)
        
        //animate
        clearLeading.constant = -self.frame.height
        UIView.animateWithDuration(0.5, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.0, options: nil, animations: {
            self.layoutIfNeeded()
            }, completion: nil)
    }
    
    func updateSelectedColor() {
        if let currentColor = currentColor {
            var hue: CGFloat = 0.0
            currentColor.getHue(&hue, saturation: nil, brightness: nil, alpha: nil)
            
            let newColor = UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: 1.0)
            self.currentColor = newColor
            NSNotificationCenter.defaultCenter().postNotificationName(EIChangeColorNotification, object: newColor, userInfo: nil)
        }
    }
    
    func colorTap(collectionView: UICollectionView, indexPath: NSIndexPath) {
        //send notification
        let newColor = colorForIndex(indexPath)
        NSNotificationCenter.defaultCenter().postNotificationName(EIChangeColorNotification, object: newColor, userInfo: nil)
        
        //animate
        if currentColor == nil {
            clearLeading.constant = 0
            UIView.animateWithDuration(0.3, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.0, options: nil, animations: {
                    self.layoutIfNeeded()
                }, completion: nil)
        }
        
        currentColor = newColor
    }
    
}