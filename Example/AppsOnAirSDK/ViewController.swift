//
//  ViewController.swift
//  AppsOnAirSDK
//
//  Created by nikesh8 on 11/24/2022.
//  Copyright (c) 2022 nikesh8. All rights reserved.
//

import UIKit
import AppsOnAir

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appUpdateManager = UpdateManager()
        // Please replace your APP_ID from https://appsonair.com
        // appUpdateManager.setAppId(APP_ID: "XXXXX-XXXX-XXXX-XXXX-XXXXXXXX", showNativeUI: true/false)
        appUpdateManager.setAppId("XXXXX-XXXX-XXXX-XXXX-XXXXXXXX", true)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

