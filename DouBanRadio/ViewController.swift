//
//  ViewController.swift
//  DouBanRadio
//
//  Created by WENGzhang on 27/08/16.
//  Copyright © 2016 WENGzhang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var background: UIImageView!
    @IBOutlet weak var albumImage: roundImage!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func backgroundBlur(){
        //set blurEffet
        let blurEffect = UIBlurEffect.init(style: UIBlurEffectStyle.Light);
        let blurView = UIVisualEffectView.init(effect: blurEffect);
        blurView.frame.size = CGSize.init(width: self.view.frame.width, height: self.view.frame.height);
        background.addSubview(blurView);
        
    }


}

