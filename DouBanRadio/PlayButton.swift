//
//  playButton.swift
//  DouBanRadio
//
//  Created by WENGzhang on 07/09/16.
//  Copyright © 2016 WENGzhang. All rights reserved.
//

import UIKit

class PlayButton: UIButton {
    var isPlaying = false;
    var viewModel = SongsTableViewModel.shareManager();
    let imgPlay = UIImage.init(named: "play");
    let imgPause = UIImage.init(named: "pause");
    override func awakeFromNib() {
//        self.setImage(UIImage.init(named: "play"), forState: .Normal);
        self.addTarget(self, action: #selector(PlayButton.onClick), for: .touchUpInside);
        viewModel.playAndPause = self;
        self.addTarget(self, action: #selector(PlayButton.onPlay(_:)), for: .touchUpInside);

    }
    
     @objc fileprivate func onClick(){
        isPlaying = !isPlaying;
        if isPlaying{
            
            self.setImage(imgPause, for: UIControlState());
        }else{
            self.setImage(imgPlay, for: UIControlState());
        }
    }
    
    func onPlay(){
        isPlaying = true;
        self.setImage(imgPause, for: UIControlState());
    }
    //action for play buttion
    func onPlay(_ btn:PlayButton){
        if btn.isPlaying{
            viewModel.audioPlayer?.play();
        }else{
            viewModel.audioPlayer?.pause();
        }
    }
}
