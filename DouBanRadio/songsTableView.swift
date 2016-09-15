//
//  songsTableView.swift
//  DouBanRadio
//
//  Created by WENGzhang on 15/09/16.
//  Copyright © 2016 WENGzhang. All rights reserved.
//

import UIKit

class songsTableView: UITableView {
    var viewModel = songsTableViewModel();
    
    override func awakeFromNib() {
        self.backgroundColor = UIColor.clearColor();
        viewModel.view = self;
        self.delegate = viewModel;
        self.dataSource = viewModel;
    }
}
