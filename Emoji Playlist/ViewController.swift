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
    
    @IBOutlet weak var hiddenField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    let startColor = UIColor(hue: 0.0, saturation: 0.5, brightness: 0.7, alpha: 1.0).CGColor
    let endColor = UIColor(hue: 0.5, saturation: 0.5, brightness: 0.7, alpha: 1.0).CGColor
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hiddenField.becomeFirstResponder()
        self.view.layer.backgroundColor = startColor
        animateBackground()
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
        tableView.insertRowsAtIndexPaths([NSIndexPath(forRow: 0, inSection: 0)], withRowAnimation: UITableViewRowAnimation.Top)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("emojiCell") as! EmojiCell
        cell.decorateCell(emojis[indexPath.row])
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (section == 0 ? emojis.count : 0)
    }
    

}