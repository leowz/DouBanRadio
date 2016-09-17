//
//  ChangeSong.swift
//  DouBanRadio
//
//  Created by WENGzhang on 17/09/16.
//  Copyright © 2016 WENGzhang. All rights reserved.
//

import UIKit

class ChangeSong: UIButton {
    var viewModel = SongsTableViewModel.shareManager();
    override func awakeFromNib() {
        viewModel.previous = self;
        viewModel.next = self;
        self.addTarget(self, action: #selector(ChangeSong.onClick(_:)), forControlEvents: .TouchUpInside);

    }
    //action for next/previous button
    func onClick(btn:ChangeSong){
        viewModel.autoFinish = false;
        if btn == viewModel.next{
            viewModel.curIndex += 1;
            if viewModel.curIndex > viewModel.songsInTable.count - 1 {
                viewModel.curIndex = 0;
            }
        }else{
            viewModel.curIndex -= 1;
            if viewModel.curIndex < 0 {
                viewModel.curIndex = viewModel.songsInTable.count - 1;
            }
        }
        
        viewModel.onSelectRow(viewModel.curIndex);
    }
}
