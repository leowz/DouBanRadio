//
//  playButton.swift
//  DouBanRadio
//
//  Created by WENGzhang on 07/09/16.
//  Copyright © 2016 WENGzhang. All rights reserved.
//

import UIKit

class playButton: UIButton {
    var isPlaying = false;
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
        self.setTitle("play", forState: .Normal);
        self.addTarget(self, action: #selector(playButton.onClick), forControlEvents: .TouchUpInside);
    }
    
     @objc private func onClick(){
        isPlaying = !isPlaying;
        if isPlaying{
            self.setTitle("pause", forState: .Normal);
            
        }else{
            self.setTitle("play", forState: .Normal);
        }
    }
    
    func onPlay(){
        isPlaying = true;
        self.setTitle("pause", forState: .Normal);
    }
}
