//
//  modeButton.swift
//  DouBanRadio
//
//  Created by WENGzhang on 07/09/16.
//  Copyright © 2016 WENGzhang. All rights reserved.
//

import UIKit

class modeButton: UIButton {
    //play mode 0:sequential 1: shuffle 2:repeat
    var mode = 0;
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
        self.addTarget(self, action: #selector(modeButton.onClick(_:)), forControlEvents: .TouchUpInside);
        self.addTarget(self, action: #selector(modeButton.onMode(_:)), forControlEvents: .TouchUpInside);
    }
    
    func onClick(sender:UIButton){
        mode += 1;
        mode = mode % 3;
        switch mode {
        case 0:
            self.setTitle("sequen", forState: .Normal);
        case 1:
            self.setTitle("shuffle", forState: .Normal);
        case 2:
            self.setTitle("repeat", forState: .Normal);
        default:
            break;
        }
    }
    
    func onMode(btn:modeButton){
        
    }
}
