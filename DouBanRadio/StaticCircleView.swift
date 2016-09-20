//
//  staticCircleView.swift
//  DouBanRadio
//
//  Created by WENGzhang on 16/09/16.
//  Copyright © 2016 WENGzhang. All rights reserved.
//

import UIKit

class StaticCircleView: UIImageView {
    override func awakeFromNib() {
        //draw round
        self.clipsToBounds = true;
        self.layer.cornerRadius = self.frame.size.width / 2; //make the layer a circular
        
        //draw border
        self.layer.borderWidth = 4;
        self.layer.borderColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.7).cgColor;
    }

}
