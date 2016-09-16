//
//  songsTableViewModel.swift
//  DouBanRadio
//
//  Created by WENGzhang on 15/09/16.
//  Copyright © 2016 WENGzhang. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import MediaPlayer

class songsTableViewModel: NSObject,UITableViewDelegate,UITableViewDataSource,HTTPProtocol {
    //VM`s View target
    var view :songsTableView?
//        didSet{
//            print("didSet")
//            IHttp.delegate = self;
//            //get sons in channel 0
//            IHttp.onSearch(songsInChannel0);
//        }
    ;
    //background image
    var albumImageView :roundImage?;
    //song progress bar
    var progressBar :songProgressBar?;
    //background
    var background:backGroundImageView?;
    //labelview time label
    var timeLabel :timeLabelView?;
    //variable of songs info
    var songsInTable:[JSON] = [];
    //get data
    var IHttp = HTTPController();
    let songsInChannel0 = "http://douban.fm/j/mine/playlist?type=n&channel=0&from=mainsite";
    //image cache
    var imageCache = Dictionary<String,UIImage>();
    //currentIndex
    var curIndex:Int = 0;
    //media player
    var audioPlayer = MPMoviePlayerController();
    
    //timer for song intervals
    var timer:NSTimer?;
    //autoFinish Flag for mode algorthm,select song,next will are not autofinishs
    var autoFinish = true;
    
    override init() {
        super.init();
        print("init viewModel")
//        albumImageView.viewModel = self;
//        progressBar.viewModel = self;
//        background.viewModel = self;
//        timeLabel.viewModel = self;
        
        IHttp.delegate = self;
        //get sons in channel 0
        IHttp.onSearch(songsInChannel0);
    }
 //singleton
    static let instance: songsTableViewModel = songsTableViewModel()
    
    class func shareManager() -> songsTableViewModel {
        return instance;
    }
    
    func didReceiveResults(results:AnyObject){
        print("didReceiveResults");
        let json = JSON(results); //data into json format
//        print(json);
        //assigne value to variabel array
//        if let channels = json["channels"].array{
////            self.channelsInTable = channels;
////            self.list.enabled = true;
//        }else 
        if let songs = json["song"].array{
            print("reloadData");
            self.songsInTable = songs;
            self.view!.reloadData();
        }
    }
    //the song selected
    func onSelectRow(index:Int){
        
        //build an indexpath
        let indexPath = NSIndexPath.init(forRow: index, inSection: 0);
        curIndex = index;
        //when selected
        self.view!.selectRowAtIndexPath(indexPath, animated: true, scrollPosition: UITableViewScrollPosition.Top);
        //get row info
        let rowData = songsInTable[index];
        //get image url
        let imURL = rowData["picture"].string;
        //set background
        onSetBackground(imURL!);
        
        //get music url
        let musicURL = rowData["url"].string;
        //play music
        onSetAudio(musicURL!);
        //rotate album
        self.albumImageView!.onRotate();
        //progressive bar to zero width
        progressBar!.frame.size.width = 0;
        //change button title to pause
//        playAndPause.onPlay();
    }
    //set bakcground image
    func onSetBackground(url:String){
        //set image
        onGetImageCache(url, imgView: self.background!);
        onGetImageCache(url, imgView: self.albumImageView!);
    }
    //Music play function
    func onSetAudio(url:String){
        //play music
        self.audioPlayer.stop();
        self.audioPlayer.contentURL = NSURL.init(string: url);
        self.audioPlayer.play();
        
        //set timer
        timer?.invalidate();
        timeLabel!.text = "00:00";
        //start timer
//        timer = NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector: #selector(ViewController.onUpdate), userInfo: nil, repeats: true);
        
        //set autofinish Flag
        autoFinish = true;
    }
    //functio for image cache
    func onGetImageCache(url:String,imgView:UIImageView){
        //check if the dic contains the image
        let img = imageCache[url];
        //if nil fetch through network else set imgView as img
        if img == nil{
            Alamofire.request(.GET, url).response(completionHandler: { (_, _, data, error) in
                //set imgView as the fetched image
                let img = UIImage.init(data: data!);
                imgView.image = img;
                //save to cache Dic
                self.imageCache[url] = img;
            })
        }else{
            imgView.image = img;
        }
    }
    
    //MARK:- Delegation function
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songsInTable.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.view!.dequeueReusableCellWithIdentifier("song") ?? UITableViewCell();// in case of force unwraping nil
        //setting reusable cell
        let rowData = songsInTable[indexPath.row];
        cell.textLabel?.text = rowData["title"].string; //title of the song
        cell.detailTextLabel?.text = rowData["artist"].string;    //artist
        cell.backgroundColor = UIColor.clearColor();
        
        //set cell image
        let thumbURL = rowData["picture"].string;
        onGetImageCache(thumbURL!, imgView: cell.imageView!);
        
        return cell;
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //set autoFinish flag
        autoFinish = false;
        onSelectRow(indexPath.row);
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        //cell 3D animation start value
        cell.layer.transform = CATransform3DMakeScale(0.1, 0.1, 1);
        
        UIView.animateWithDuration(0.35) {
            //end value
            cell.layer.transform = CATransform3DMakeScale(1, 1, 1);
        }
    }
}
