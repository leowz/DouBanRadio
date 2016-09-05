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
import MediaPlayer

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
    //variable of songs info
    var songsInTable:[JSON] = [];
    //channel info
    var channelsInTable:[JSON] = [];
    //image cache
    var imageCache = Dictionary<String,UIImage>();
    
    //media player
    var audioPlayer = MPMoviePlayerController();
    
    //timer for song intervals
    var timer:NSTimer?;
    
    @IBOutlet weak var timeLabel: UILabel!
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
    //blur effect
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
        
        //get music url
        let musicURL = rowData["url"].string;
        //play music
        onSetAudio(musicURL!);
        //rotate album
        self.albumImageView.onRotate();
    }
    
    //set bakcground image
    func onSetBackground(url:String){
        //set image
        onGetImageCache(url, imgView: self.background);
        onGetImageCache(url, imgView: self.albumImageView);
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
    
    //Music play function
    func onSetAudio(url:String){
        //play music
        self.audioPlayer.stop();
        self.audioPlayer.contentURL = NSURL.init(string: url);
        self.audioPlayer.play();
        
        //set timer
        timer?.invalidate();
        timeLabel.text = "00:00";
        //start timer
        timer = NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector: "onUpdate", userInfo: nil, repeats: true);
    }
    
    //timer update function
    func onUpdate(){
        //get current music play time
        let cTime = audioPlayer.duration;//totoal seconds
        let playedTime = audioPlayer.currentPlaybackTime;
        if cTime > 0.0 {
            //translate seconds into real time format
            let realTime = Int(cTime) - Int(playedTime);
            let seconds = realTime % 60 ;
            let minutes = Int(realTime/60);
            
            var time = "";
            if (minutes < 10 ){
                time = "0\(minutes):";
            }else{
                time = "\(minutes):";
            }
            
            if (seconds < 10){
                time += "0\(seconds)";
            }else{
                time += "\(seconds)";
            }
            
            //upDate time label
            timeLabel.text = time;
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
        onGetImageCache(thumbURL!, imgView: cell.imageView!);
        
        return cell;
    }
    
    func didReceiveResults(results:AnyObject){
//        print(results);
        let json = JSON(results); //data into json format
        
        //assigne value to variabel array
        if let channels = json["channels"].array{
            self.channelsInTable = channels;
        }else if let songs = json["song"].array{
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

