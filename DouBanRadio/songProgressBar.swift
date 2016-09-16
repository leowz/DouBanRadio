//
//  songProgressBar.swift
//  DouBanRadio
//
//  Created by WENGzhang on 15/09/16.
//  Copyright © 2016 WENGzhang. All rights reserved.
//

import UIKit

class songProgressBar: UIImageView {
    var viewModel  = SongsTableViewModel.shareManager();
    override func awakeFromNib() {
        //binding
        viewModel.progressBar = self;
    }

}
