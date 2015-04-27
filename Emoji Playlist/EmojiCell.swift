//
//  EmojiCell.swift
//  Emoji Playlist
//
//  Created by DFA Film 9: K-9 on 4/16/15.
//  Copyright (c) 2015 Cal Stephens. All rights reserved.
//

import UIKit
import CoreFoundation

class EmojiCell : UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emojiDisplay: UILabel!
    @IBOutlet weak var labelContainer: UIView!
    @IBOutlet weak var saveButton: UIButton!
    
    @IBOutlet weak var savedDisplay: UIView!
    @IBOutlet weak var savedLeading: NSLayoutConstraint!
    
    @IBOutlet weak var whatsNext: UIButton!
    @IBOutlet weak var whatsNextWidth: NSLayoutConstraint!

    
    @IBAction func saveButton(sender: AnyObject) {
        savedLeading.constant = 0
        UIView.animateWithDuration(0.3, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.0, options: nil, animations: {
                self.layoutIfNeeded()
            }, completion: { success in
                
                self.saveButton.hidden = true
                self.whatsNext.hidden = false
                self.whatsNextWidth.constant = 103
                self.layoutIfNeeded()
                
                self.savedLeading.constant = -375
                UIView.animateWithDuration(1.0, delay: 1.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.0, options: nil, animations: {
                        self.layoutIfNeeded()
                    self.savedDisplay.alpha = 0.0
                    }, completion: { success in
                        self.savedLeading.constant = 375
                        self.layoutIfNeeded()
                        self.savedDisplay.alpha = 1.0
                })
        })
    }
    
    @IBAction func showHelpPopup(sender: AnyObject) {
        NSNotificationCenter.defaultCenter().postNotificationName(SHOW_HELP_POPUP, object: nil)
    }
    
    func decorateCell(emoji: String) {
        var emojiName = ""
        
        let cfstring = NSMutableString(string: emoji) as CFMutableString
        var range = CFRangeMake(0, CFStringGetLength(cfstring))
        CFStringTransform(cfstring, &range, kCFStringTransformToUnicodeName, 0)
        let capitalName = "\(cfstring)"
        
        if !capitalName.hasPrefix("\\") { //is number emoji
            var splits = split(capitalName){ $0 == "\\" }
            emojiName = ((capitalName as NSString).length > 1 ? "keycap " : "") + splits[0]
        }
        
        else {
            var splits = split(capitalName){ $0 == "}" }
            for i in 0..<splits.count {
                if (splits[i] as NSString).length > 3 {
                    splits[i] = (splits[i] as NSString).substringFromIndex(3).lowercaseString
                }
            }
            
            if splits.count == 1 {
                emojiName = splits[0]
            }
            
            if splits.count == 2{
                if splits[1].hasPrefix("emoji modifier") || splits[1].hasPrefix("variation selector"){ //skin tone emojis
                    emojiName = splits[0]
                }
                else { //flags are awful
                    var flagName = ""
                    for split in splits {
                        let splitNS = split.uppercaseString as NSString
                        flagName += splitNS.substringFromIndex(splitNS.length - 1)
                    }
                    emojiName = flagName + " flag"
                }
            }
        }
        
        decorateCell(emoji: emoji, text: emojiName)
        saveButton.hidden = false
        saveButton.enabled = true
    }
    
    
    func decorateCell(#emoji: String, text: String) {
        nameLabel.text = text
        emojiDisplay.text = emoji
        
        labelContainer.layer.borderWidth = 0.5
        labelContainer.layer.borderColor = UIColor(white: 0.9, alpha: 1.0).CGColor
        saveButton.hidden = true
        saveButton.enabled = false
        whatsNext.hidden = true
        whatsNextWidth.constant = 10
        savedLeading.constant = 375
        
        setNeedsLayout()
        setNeedsDisplay()
    }
    
}
