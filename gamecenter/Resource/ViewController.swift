//
//  ViewController.swift
//  gamecenter
//
//  Created by daovu on 9/29/20.
//  Copyright © 2020 daovu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        _ = OAuth2(
            consumerKey: "6gd9wd6tj4eeydpexxl7w4apt93c9m",
            consumerSecret: "zf4rexfxdl7op26wi4wl7e7cznolc1",
            authorizeUrl: "https://id.twitch.tv/oauth2/authorize",
            accessTokenUrl: "https://id.twitch.tv/oauth2/token",
            responseType: "code"
        )
    }
}

struct OAuth2 {
    let consumerKey: String
    let consumerSecret: String
    let authorizeUrl: String
    let  accessTokenUrl: String
    let responseType: String
}
