//
//  ViewController.swift
//  DouBanRadio
//
//  Created by WENGzhang on 27/08/16.
//  Copyright © 2016 WENGzhang. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import MediaPlayer

class ViewController: UIViewController {

    
//MARK:- Functions
    override func viewDidLoad() {
        super.viewDidLoad()

        backgroundBlur();
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   // blur effect
    func backgroundBlur(){
        //set blurEffet
        let blurEffect = UIBlurEffect.init(style: UIBlurEffectStyle.light);
        let blurView = UIVisualEffectView.init(effect: blurEffect);
        blurView.frame.size = CGSize.init(width: self.view.frame.width + 10, height: self.view.frame.height);
        view.subviews.first!.addSubview(blurView);

        
    }
}

