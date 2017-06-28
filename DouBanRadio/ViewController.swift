//
//  ViewController.swift
//  DouBanRadio
//
//  Created by WENGzhang on 27/08/16.
//  Copyright © 2016 WENGzhang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
//MARK:- Functions
    override func viewDidLoad() {
      super.viewDidLoad();
      backgroundBlur();
      
    }

    override func viewWillAppear(_ animated: Bool) {
        UIApplication.shared.beginReceivingRemoteControlEvents();
        self.becomeFirstResponder();
    }
    override func viewWillDisappear(_ animated: Bool) {
        UIApplication.shared.endReceivingRemoteControlEvents();
        self.resignFirstResponder();
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

