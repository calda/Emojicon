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
    
    @IBAction func saveButton(sender: AnyObject) {
        println(nameLabel.text!)
    }
    
    func decorateCell(emoji: String) {
        emojiDisplay.text = emoji
        
        var emojiName = ""
        
        if (emoji as NSString).length == 1 { //is regular letter
            emojiName = emoji
        }
        
        else { //is emoji of some sort
            let cfstring = NSMutableString(string: emoji) as CFMutableString
            var range = CFRangeMake(0, CFStringGetLength(cfstring))
            CFStringTransform(cfstring, &range, kCFStringTransformToUnicodeName, 0)
            let capitalName = "\(cfstring)"
            var splits = split(capitalName){ $0 == "}" }
            for i in 0..<splits.count {
                splits[i] = (splits[i] as NSString).substringFromIndex(3).lowercaseString
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
        
        nameLabel.text = emojiName
        
        labelContainer.layer.borderWidth = 0.5
        labelContainer.layer.borderColor = UIColor(white: 0.9, alpha: 1.0).CGColor
    }
    
}
