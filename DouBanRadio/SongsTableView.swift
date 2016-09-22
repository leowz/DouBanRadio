//
//  songsTableView.swift
//  DouBanRadio
//
//  Created by WENGzhang on 15/09/16.
//  Copyright © 2016 WENGzhang. All rights reserved.
//

import UIKit

class SongsTableView: UITableView {
    
     var viewModel  = SongsTableViewModel.shareManager();
    
    override func awakeFromNib() {
        print("init songsTableView")
        self.backgroundColor = UIColor.clear;
        viewModel.view = self;
        self.delegate = viewModel;
        self.dataSource = viewModel;
    }
    override func remoteControlReceived(with receivedEvent: UIEvent?) {
        
        if (receivedEvent?.type == UIEventType.remoteControl) {
            
            switch (receivedEvent!.subtype) { // 得到事件类型
                
            case UIEventSubtype.remoteControlTogglePlayPause :// // 暂停 ios6
                
                self.viewModel.playAndPause?.onClick(); // 调用你所在项目的暂停按钮的响应方法 下面的也是如此
                
                break;
                
            case UIEventSubtype.remoteControlNextTrack  :  // 上一首
                
                self.viewModel.previous?.onClick(self.viewModel.previous!);
                
                break;
                
            case  UIEventSubtype.remoteControlNextTrack: // 下一首
                
                self.viewModel.next?.onClick(self.viewModel.next!);
                
                break;
                
            case UIEventSubtype.remoteControlPlay: //播放
                
               self.viewModel.playAndPause?.onClick();
                
                break;
                
            case UIEventSubtype.remoteControlPause: // 暂停 ios7
                
               self.viewModel.playAndPause?.onClick();
                
                break;
                
            default:
                
                break;
                
            }
            
        }
    }
    
    override func becomeFirstResponder() -> Bool
    {
        return true;
    }
    
}
