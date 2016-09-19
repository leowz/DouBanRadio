//
//  ChannelListController.swift
//  DouBanRadio
//
//  Created by WENGzhang on 30/08/16.
//  Copyright © 2016 WENGzhang. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

protocol ChannelProtocol {
    //get channel id for delegate
    func onChangeChannel(channelID:String)
}

class ChannelListController: UIViewController{

    @IBOutlet weak var listLabelView: UILabel!

    @IBOutlet weak var ChannelTableView: ChannelListTableView!{
        didSet{
            ChannelTableView.controller = self;
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.alpha = 0.9;
        let tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(ChannelListController.onTapList));
        tapGesture.numberOfTapsRequired = 1;
        tapGesture.numberOfTouchesRequired = 1;
        listLabelView.userInteractionEnabled = true;//important
        listLabelView.addGestureRecognizer(tapGesture);
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func onTapList(){
        NSLog("tap tap tap");
        self.dismissViewControllerAnimated(true, completion: nil);
    }
}
