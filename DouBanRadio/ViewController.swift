//
//  ViewController.swift
//  DouBanRadio
//
//  Created by WENGzhang on 27/08/16.
//  Copyright © 2016 WENGzhang. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,HTTPProtocol,ChannelProtocol {
    let douBanURL = "http://www.douban.com/j/app/radio/channels";
    let songsInChannel0 = "http://douban.fm/j/mine/playlist?type=n&channel=0&from=mainsite";
    @IBOutlet weak var background: UIImageView!//background imageView
    @IBOutlet weak var albumImageView: roundImage!  //albumImageView
    @IBOutlet weak var songListTableView: UITableView!{
        didSet{
            songListTableView.backgroundColor = UIColor.clearColor();
        }
    }  // songList
    var IHttp = HTTPController();
    
    var songsInTable:[JSON] = [];//variable of songs info
    var channelsInTable:[JSON] = [];//channel info
//MARK:- Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        //Delegate link
        songListTableView.delegate = self;
        songListTableView.dataSource = self;
        IHttp.delegate = self;
        backgroundBlur();
        
        //get channel
        IHttp.onSearch(douBanURL);
        //get sons in channel 0
        IHttp.onSearch(songsInChannel0);
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func backgroundBlur(){
        //set blurEffet
        let blurEffect = UIBlurEffect.init(style: UIBlurEffectStyle.Light);
        let blurView = UIVisualEffectView.init(effect: blurEffect);
        blurView.frame.size = CGSize.init(width: self.view.frame.width, height: self.view.frame.height);
        background.addSubview(blurView);
        
    }
    //the song selected
    func onSelectRow(index:Int){
        //build an indexpath
        let indexPath = NSIndexPath.init(forRow: index, inSection: 0);
        //when selected
        songListTableView.selectRowAtIndexPath(indexPath, animated: true, scrollPosition: UITableViewScrollPosition.Top);
        //get row info
        let rowData = songsInTable[index];
        //get image url
        let imURL = rowData["picture"].string;
        //set background
        onSetBackground(imURL!);
    }
    
    //set bakcground image
    func onSetBackground(url:String){
        //get image
        Alamofire.request(.GET, url).response { (_, _, data, error) in
            let img = UIImage.init(data: data!);
            self.background.image = img;
            self.albumImageView.image = img;
        }
    }

//MARK:- Delegation function
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songsInTable.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = songListTableView.dequeueReusableCellWithIdentifier("song") ?? UITableViewCell();// in case of force unwraping nil
        //setting reusable cell
        let rowData = songsInTable[indexPath.row];
        cell.textLabel?.text = rowData["title"].string; //title of the song
        cell.detailTextLabel?.text = rowData["artist"].string;    //artist
        cell.backgroundColor = UIColor.clearColor();
       
        //set cell image
        let thumbURL = rowData["picture"].string;
        Alamofire.request(.GET,thumbURL!).response { (_, _, data, error) in
             cell.imageView?.image = UIImage.init(data: data!);
        }
        
        return cell;
    }
    
    func didReceiveResults(results:AnyObject){
//        print(results);
        let json = JSON(results); //data into json format
        
        //assigne value to variabel array
        if let channels = json["channels"].array{
            self.channelsInTable = channels;
        }else if let songs = json["song"].array{
            print(songs);
            print(songs.count);
            self.songsInTable = songs;
            self.songListTableView.reloadData();
        }
    }
    
    func onChangeChannel(channelID: String) {
        //set url of given channel
        let url = "http://douban.fm/j/mine/playlist?type=n&channel=\(channelID)&from=mainsite"
        IHttp.onSearch(url);
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        onSelectRow(indexPath.row);
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //get destination controller
        let controller = segue.destinationViewController ;
        if controller is ChannelListController {
            // send data to channel Controller
            (controller as! ChannelListController).channelData = channelsInTable;
            (controller as! ChannelListController).delegate = self;
//            (controller as! ChannelListController).ChannelListTableView.reloadData();
        }
    }
}

