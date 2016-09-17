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
