//
//  backGroundImageView.swift
//  DouBanRadio
//
//  Created by WENGzhang on 15/09/16.
//  Copyright © 2016 WENGzhang. All rights reserved.
//

import UIKit

class BackGroundImageView: UIImageView {
    var viewModel = SongsTableViewModel.shareManager();
    override func awakeFromNib() {
        viewModel.background = self;
//        let blurEffect = UIBlurEffect.init(style: UIBlurEffectStyle.Light);
//        let blurView = UIVisualEffectView.init(effect: blurEffect);
//        blurView.frame.size = CGSize.init(width: self.frame.width + 10, height: self.frame.height);
//        self.addSubview(blurView);
    }

}
