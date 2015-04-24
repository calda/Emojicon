//
//  ViewController.swift
//  Emoji Playlist
//
//  Created by DFA Film 9: K-9 on 4/14/15.
//  Copyright (c) 2015 Cal Stephens. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var emojis : [String] = []
    let about : [(emoji: String, text: String)] = [
        ("🌐", "1️⃣ open emoji keyboard"),
        ("👈🏻", "2️⃣ type emoji"),
        ("📲", "3️⃣ save to camera roll"),
        ("🎧", "4️⃣ set as playlist icon"),
        ("🙏🏻", "5️⃣ nice!")
    ]
    
    @IBOutlet weak var hiddenField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    let startColor = UIColor(hue: 0.0, saturation: 0.5, brightness: 0.7, alpha: 1.0).CGColor
    let endColor = UIColor(hue: 0.5, saturation: 0.5, brightness: 0.7, alpha: 1.0).CGColor
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hiddenField.becomeFirstResponder()
        self.view.layer.backgroundColor = startColor
        //animateBackground()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardChanged:", name: UIKeyboardDidShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardChanged:", name: UIKeyboardDidChangeFrameNotification, object: nil)
    }
    
    func keyboardChanged(notification: NSNotification) {
        let info = notification.userInfo!
        let value: AnyObject = info[UIKeyboardFrameEndUserInfoKey]!
        let rawFrame = value.CGRectValue()
        let keyboardFrame = view.convertRect(rawFrame, fromView: nil)
        let height = keyboardFrame.height
        
        tableView.contentInset = UIEdgeInsetsMake(0.0, 0.0, height, 0.0)
    }
    
    func animateBackground() {
        UIView.animateWithDuration(15, animations: {
                self.view.layer.backgroundColor = self.startColor
            }, completion: { _ in
                UIView.animateWithDuration(15, animations: {
                    self.view.layer.backgroundColor = self.endColor
                }, completion: { _ in
                    self.animateBackground()
                })
        })
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    override func viewDidAppear(animated: Bool) {
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func hiddenInputReceived(sender: UITextField, forEvent event: UIEvent) {
        var emoji = sender.text.substringFromIndex(sender.text.endIndex.predecessor()) as NSString
        
        if emoji.length == 0 { return }
        
        if emoji.length > 1 {
            let char2 = emoji.characterAtIndex(1)
            if char2 >= 57339 && char2 <= 57343
            { //is skin tone marker
                emoji = sender.text.substringFromIndex(sender.text.endIndex.predecessor().predecessor()) as NSString
            }
            
            if emoji.length % 4 == 0 && emoji.length > 4 { //flags stick together for some reason?
                emoji = emoji.substringFromIndex(emoji.length - 4)
            }
        }
        
        emojis.insert(emoji as String, atIndex: 0)
        tableView.insertRowsAtIndexPaths([NSIndexPath(forRow: 0, inSection: 0)], withRowAnimation: UITableViewRowAnimation.Right)
        tableView.scrollToRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0), atScrollPosition: .Top, animated: true)
        
        sender.text = ""
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("emojiCell") as! EmojiCell
        
        if indexPath.item >= emojis.count {
            let aboutText = about[indexPath.item - emojis.count]
            cell.decorateCell(emoji: aboutText.emoji, text: aboutText.text)
        }
        
        else {
            cell.decorateCell(emojis[indexPath.item])
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return emojis.count + about.count
    }
    

}