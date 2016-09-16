//
//  timeLabelView.swift
//  DouBanRadio
//
//  Created by WENGzhang on 15/09/16.
//  Copyright © 2016 WENGzhang. All rights reserved.
//

import UIKit

class timeLabelView: UILabel {
    var viewModel = songsTableViewModel.shareManager();
    override func awakeFromNib() {
        viewModel.timeLabel = self;
    }
}
