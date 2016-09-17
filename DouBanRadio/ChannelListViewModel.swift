
//
//  ChannelListViewModel.swift
//  DouBanRadio
//
//  Created by WENGzhang on 16/09/16.
//  Copyright © 2016 WENGzhang. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ChannelListViewModel: NSObject,UITableViewDelegate,UITableViewDataSource,HTTPProtocol {
    
    weak var view : ChannelListTableView?
    let douBanURL = "http://www.douban.com/j/app/radio/channels";
    var delegate:ChannelProtocol = SongsTableViewModel.shareManager();
    var IHttp = HTTPController();
    //Channel list row Data
    var channelData:[JSON] = [];
    
    override init() {
        super.init();
        //get channel
        IHttp.delegate = self;
        IHttp.onSearch(douBanURL);
    }
    
    func didReceiveResults(results:AnyObject){
        print("didReceiveResults");
        let json = JSON(results); //data into json format
//                print(json);
       // assigne value to variabel array
                if let channels = json["channels"].array{
                    self.channelData = channels;
//                    self.list.enabled = true;
                       self.view!.reloadData();
                }
    }
    
    
    //MARK:- delegation function
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return channelData.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.view!.dequeueReusableCellWithIdentifier("ChannelCell") ?? UITableViewCell() ;
        
        let rowData = channelData[indexPath.row];
        
        //set cell
        cell.textLabel?.text = rowData["name"].string;
        return cell;
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //get channel_id
        let rowData = channelData[indexPath.row];
        let channel_id = rowData["channel_id"].stringValue;
        //send id to ViewController
        delegate.onChangeChannel(channel_id);
        //dismiss current controller
        self.view!.controller!.dismissViewControllerAnimated(true, completion: nil);
//        controllerDismissDelegate?.onDismissChannel();
    }
    // set cell display animation
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        //cell 3D animation start value
        cell.layer.transform = CATransform3DMakeScale(0.1, 0.1, 1);
        
        UIView.animateWithDuration(0.15) {
            //end value
            cell.layer.transform = CATransform3DMakeScale(1, 1, 1);
        }
    }

    
}
