//
//  roundImage.swift
//  DouBanRadio
//
//  Created by WENGzhang on 28/08/16.
//  Copyright © 2016 WENGzhang. All rights reserved.
//

import UIKit

class roundImage: UIImageView {
    weak var viewModel = songsTableViewModel();
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder);
//        
//        //draw round
//        self.clipsToBounds = true;
//        self.layer.cornerRadius = self.frame.size.width / 2; //make the layer a circular
//        
//        //draw border
//        self.layer.borderWidth = 4;
//        self.layer.borderColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.7).CGColor;
//        
//    }
    override func awakeFromNib() {
        //draw round
        self.clipsToBounds = true;
        self.layer.cornerRadius = self.frame.size.width / 2; //make the layer a circular
        
        //draw border
        self.layer.borderWidth = 4;
        self.layer.borderColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.7).CGColor;
        //set view model
        viewModel?.albumImageView = self;
    }
    
    //rotation function
    func onRotate(){
        //get animation
        var animation = CABasicAnimation(keyPath: "transform.rotation");
        //set animation
        animation.fromValue = 0.0;
        animation.toValue = M_PI * 2.0; //rotate from 0 to 2pi
        animation.duration = 20;//every 20s to rotate from 0 to 2pi
        animation.repeatCount = 10000;
        
        self.layer.addAnimation(animation, forKey: nil);
    }


}
