//
//  ViewController.swift
//  Emoji Playlist
//
//  Created by DFA Film 9: K-9 on 4/14/15.
//  Copyright (c) 2015 Cal Stephens. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var hiddenField: UITextField!
    @IBOutlet weak var display: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hiddenField.becomeFirstResponder()
    }
    
    override func viewDidAppear(animated: Bool) {
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func hiddenInputReceived(sender: UITextField, forEvent event: UIEvent) {
        var emoji = sender.text.substringFromIndex(sender.text.endIndex.predecessor()) as NSString
        println(emoji)
        println(emoji.length)
        if emoji.length % 4 == 0 && emoji.length > 4 { //flags stick together for some reason?
            emoji = emoji.substringFromIndex(emoji.length - 4)
        }
        display.text = emoji as String
    }

}