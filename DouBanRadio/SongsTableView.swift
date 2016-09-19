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
        self.backgroundColor = UIColor.clearColor();
        viewModel.view = self;
        self.delegate = viewModel;
        self.dataSource = viewModel;
    }
}
