
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
    
    func didReceiveResults(_ results:AnyObject){
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
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return channelData.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.view!.dequeueReusableCell(withIdentifier: "ChannelCell") ?? UITableViewCell() ;
        
        let rowData = channelData[(indexPath as NSIndexPath).row];
        
        //set cell
        cell.textLabel?.text = rowData["name"].string;
        return cell;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //get channel_id
        let rowData = channelData[(indexPath as NSIndexPath).row];
        let channel_id = rowData["channel_id"].stringValue;
        //send id to ViewController
        delegate.onChangeChannel(channel_id);
        //dismiss current controller
        self.view!.controller!.dismiss(animated: true, completion: nil);
    }
    // set cell display animation
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        //cell 3D animation start value
        cell.layer.transform = CATransform3DMakeScale(0.1, 0.1, 1);
        
        UIView.animate(withDuration: 0.15, animations: {
            //end value
            cell.layer.transform = CATransform3DMakeScale(1, 1, 1);
        }) 
    }

    
}
