//
//  songProgressBar.swift
//  DouBanRadio
//
//  Created by WENGzhang on 15/09/16.
//  Copyright © 2016 WENGzhang. All rights reserved.
//

import UIKit

class songProgressBar: UIImageView {
    weak var viewModel = songsTableViewModel();
    override func awakeFromNib() {
        //binding
        viewModel?.progressBar = self;
    }

}
