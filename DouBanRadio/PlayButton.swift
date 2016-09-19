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
        self.addTarget(self, action: #selector(PlayButton.onClick), forControlEvents: .TouchUpInside);
        viewModel.playAndPause = self;
        self.addTarget(self, action: #selector(PlayButton.onPlay(_:)), forControlEvents: .TouchUpInside);

    }
    
     @objc private func onClick(){
        isPlaying = !isPlaying;
        if isPlaying{
            
            self.setImage(imgPause, forState: .Normal);
        }else{
            self.setImage(imgPlay, forState: .Normal);
        }
    }
    
    func onPlay(){
        isPlaying = true;
        self.setImage(imgPause, forState: .Normal);
    }
    //action for play buttion
    func onPlay(btn:PlayButton){
        if btn.isPlaying{
            viewModel.audioPlayer.play();
        }else{
            viewModel.audioPlayer.pause();
        }
    }
}
