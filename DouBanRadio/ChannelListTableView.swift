//
//  ChannelListTableView.swift
//  DouBanRadio
//
//  Created by WENGzhang on 16/09/16.
//  Copyright © 2016 WENGzhang. All rights reserved.
//

import UIKit

class ChannelListTableView: UITableView {
    
    var viewModel = ChannelListViewModel();
    var controller : ChannelListController?
    
    override func awakeFromNib() {

        viewModel.view = self;
        self.backgroundColor = UIColor.clearColor();
//        viewModel.delegate = self;
        self.delegate = viewModel;
        self.dataSource = viewModel;
        
    }

}
