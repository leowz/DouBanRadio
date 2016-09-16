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
//protocol DismissChannel{
//    func onDismissChannel();
//}
class ChannelListController: UIViewController{


    @IBOutlet weak var ChannelTableView: ChannelListTableView!{
        didSet{
            ChannelTableView.controller = self;
        }
    }
    
    var delegate:ChannelProtocol?
    
    //Channel list row Data
    var channelData:[JSON] = [];
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.alpha = 1;
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

////MARK:- delegation function
//    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return channelData.count;
//    }
//    
//    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        let cell = ChannelListTableView.dequeueReusableCellWithIdentifier("ChannelCell") ?? UITableViewCell() ;
//        
//        let rowData = channelData[indexPath.row];
//        
//        //set cell
//        cell.textLabel?.text = rowData["name"].string;
//        return cell;
//    }
//    
//    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        //get channel_id
//        let rowData = channelData[indexPath.row];
//        let channel_id = rowData["channel_id"].stringValue;
//        //send id to ViewController
//        delegate?.onChangeChannel(channel_id);
//        //dismiss current controller
//        self.dismissViewControllerAnimated(true, completion: nil);
//    }
//    // set cell display animation
//    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
//        //cell 3D animation start value
//        cell.layer.transform = CATransform3DMakeScale(0.1, 0.1, 1);
//        
//        UIView.animateWithDuration(0.15) {
//            //end value
//            cell.layer.transform = CATransform3DMakeScale(1, 1, 1);
//        }
//    }
}
