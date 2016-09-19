//
//  modeButton.swift
//  DouBanRadio
//
//  Created by WENGzhang on 07/09/16.
//  Copyright © 2016 WENGzhang. All rights reserved.
//

import UIKit

class ModeButton: UIButton {
    //play mode 0:sequential 1: shuffle 2:repeat
    var mode = 0;
    var viewModel = SongsTableViewModel.shareManager();
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
        self.addTarget(self, action: #selector(ModeButton.onClick(_:)), forControlEvents: .TouchUpInside);
        self.addTarget(self, action: #selector(ModeButton.onMode(_:)), forControlEvents: .TouchUpInside);
        viewModel.mode = self;
    }
    
    func onClick(sender:UIButton){
        mode += 1;
        mode = mode % 3;
        switch mode {
        case 0:
            self.setImage(UIImage.init(named: "music"), forState: .Normal);
        case 1:
            self.setImage(UIImage.init(named: "listPlay"), forState: .Normal);
        case 2:
            self.setImage(UIImage.init(named: "replay"), forState: .Normal);
        default:
            break;
        }
    }
    
    func onMode(btn:ModeButton){
        
    }
}
