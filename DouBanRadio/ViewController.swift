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

class ViewController: UIViewController {
    let douBanURL = "http://www.douban.com/j/app/radio/channels";
    let songsInChannel0 = "http://douban.fm/j/mine/playlist?type=n&channel=0&from=mainsite";
//    @IBOutlet weak var background: UIImageView!//background imageView
//    @IBOutlet weak var albumImageView: roundImage!  //albumImageView
//    @IBOutlet weak var songListTableView: UITableView!{
//        didSet{
//         
//        }
//    }  // songList
//    
//    var IHttp = HTTPController();
//    //variable of songs info
//    var songsInTable:[JSON] = [];
    //channel info
//    var channelsInTable:[JSON] = [];
    //image cache
//    var imageCache = Dictionary<String,UIImage>();
    
    //media player
//    var audioPlayer = MPMoviePlayerController();
    
//    //timer for song intervals
//    var timer:NSTimer?;
//    
//    //currentIndex
//    var curIndex:Int = 0;
//    
//    @IBOutlet weak var songProgressBar: UIImageView!
//    @IBOutlet weak var timeLabel: UILabel!
    //audio control buttons
    @IBOutlet weak var playAndPause: playButton!
    @IBOutlet weak var previous: UIButton!
    @IBOutlet weak var next: UIButton!
    @IBOutlet weak var list: UIButton!{
        didSet{list.enabled = false;}
    }

    @IBOutlet weak var mode: modeButton!
  
    //autoFinish Flag for mode algorthm,select song,next will are not autofinishs
    var autoFinish = true;
    
//MARK:- Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        //Delegate link
//        songListTableView.delegate = self;
//        songListTableView.dataSource = self;
//        IHttp.delegate = self;
//        backgroundBlur();
        
        //get channel
//        IHttp.onSearch(douBanURL);
//        //get sons in channel 0
//        IHttp.onSearch(songsInChannel0);
        
        //set audio control button
//        playAndPause.addTarget(self, action: #selector(ViewController.onPlay(_:)), forControlEvents: .TouchUpInside);
//        next.addTarget(self, action: #selector(ViewController.onClick(_:)), forControlEvents: .TouchUpInside);
//        previous.addTarget(self, action: #selector(ViewController.onClick(_:)), forControlEvents: .TouchUpInside);
//        mode.addTarget(self, action: #selector(ViewController.onMode(_:)), forControlEvents: .TouchUpInside);
//        
//        //notification when song finishes playing
//        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.playFinish), name: MPMoviePlayerPlaybackDidFinishNotification, object: audioPlayer);
    }
//
    //alogrithm of play mode when songs autofinished
//    func playFinish(){
//        if autoFinish{
//            switch mode.mode {
//            case 0:
//                curIndex += 1;
//                curIndex %= songsInTable.count;
//                onSelectRow(curIndex);
//            case 1:
//                curIndex = random() % songsInTable.count;
//                onSelectRow(curIndex);
//            case 2:
//                onSelectRow(curIndex);
//            default:
//                break;
//            }
//        }else{
//            autoFinish = true;
//        }
//    }
    
    //action for play buttion
//    func onPlay(btn:playButton){
//        if btn.isPlaying{
//            audioPlayer.play();
//        }else{
//            audioPlayer.pause();
//        }
//    }
    
    //action for next/previous button
//    func onClick(btn:UIButton){
//        autoFinish = false;
//        if btn == next{
//            curIndex += 1;
//            if curIndex > self.songsInTable.count - 1 {
//                curIndex = 0;
//            }
//        }else{
//            curIndex -= 1;
//            if curIndex < 0 {
//                curIndex = self.songsInTable.count - 1;
//            }
//        }
//        
//        onSelectRow(curIndex);
//    }
    
    func onMode(btn:modeButton){
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //blur effect
//    func backgroundBlur(){
//        //set blurEffet
//        let blurEffect = UIBlurEffect.init(style: UIBlurEffectStyle.Light);
//        let blurView = UIVisualEffectView.init(effect: blurEffect);
//        blurView.frame.size = CGSize.init(width: self.view.frame.width + 10, height: self.view.frame.height);
//        background.addSubview(blurView);
//        
//    }
    //the song selected
//    func onSelectRow(index:Int){
//       
//        //build an indexpath
//        let indexPath = NSIndexPath.init(forRow: index, inSection: 0);
//        curIndex = index;
//        //when selected
//        songListTableView.selectRowAtIndexPath(indexPath, animated: true, scrollPosition: UITableViewScrollPosition.Top);
//        //get row info
//        let rowData = songsInTable[index];
//        //get image url
//        let imURL = rowData["picture"].string;
//        //set background
//        onSetBackground(imURL!);
//        
//        //get music url
//        let musicURL = rowData["url"].string;
//        //play music
//        onSetAudio(musicURL!);
//        //rotate album
//        self.albumImageView.onRotate();
//        //progressive bar to zero width
//        songProgressBar.frame.size.width = 0;
//        //change button title to pause
//        playAndPause.onPlay();
//    }
    
//    //set bakcground image
//    func onSetBackground(url:String){
//        //set image
//        onGetImageCache(url, imgView: self.background);
//        onGetImageCache(url, imgView: self.albumImageView);
//    }
    
//    //functio for image cache
//    func onGetImageCache(url:String,imgView:UIImageView){
//    //check if the dic contains the image
//        let img = imageCache[url];
//    //if nil fetch through network else set imgView as img
//        if img == nil{
//            Alamofire.request(.GET, url).response(completionHandler: { (_, _, data, error) in
//                //set imgView as the fetched image
//                let img = UIImage.init(data: data!);
//                imgView.image = img;
//                //save to cache Dic
//                self.imageCache[url] = img;
//            })
//        }else{
//            imgView.image = img;
//        }
//    }

//    //Music play function
//    func onSetAudio(url:String){
//        //play music
//        self.audioPlayer.stop();
//        self.audioPlayer.contentURL = NSURL.init(string: url);
//        self.audioPlayer.play();
//        
//        //set timer
//        timer?.invalidate();
//        timeLabel.text = "00:00";
//        //start timer
//        timer = NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector: #selector(ViewController.onUpdate), userInfo: nil, repeats: true);
//        
//        //set autofinish Flag
//        autoFinish = true;
//    }
    
    //timer update function
//    func onUpdate(){
//        //get current music play time
//        let tTime = audioPlayer.duration;//totoal seconds
//        let playedTime = audioPlayer.currentPlaybackTime;
//        if tTime > 0.0 {
//            //translate seconds into real time format
//            let realTime = Int(tTime) - Int(playedTime);
//            let seconds = realTime % 60 ;
//            let minutes = Int(realTime/60);
//            
//            var time = "";
//            if (minutes < 10 ){
//                time = "0\(minutes):";
//            }else{
//                time = "\(minutes):";
//            }
//            
//            if (seconds < 10){
//                time += "0\(seconds)";
//            }else{
//                time += "\(seconds)";
//            }
//            
//            //upDate time label
//            timeLabel.text = time;
//            
//            //ratio for progressBar
//            var ratio = CGFloat(playedTime/tTime);
//            //set progressBar
//            songProgressBar.frame.size.width = view.frame.width * ratio;
//        }
//        
//     
//    }

//MARK:- Delegation function
//    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return songsInTable.count;
//    }
    // set cell display animation
//    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
//        //cell 3D animation start value
//        cell.layer.transform = CATransform3DMakeScale(0.1, 0.1, 1);
//        
//        UIView.animateWithDuration(0.35) {
//            //end value
//            cell.layer.transform = CATransform3DMakeScale(1, 1, 1);
//        }
//    }
    
//    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        let cell = songListTableView.dequeueReusableCellWithIdentifier("song") ?? UITableViewCell();// in case of force unwraping nil
//        //setting reusable cell
//        let rowData = songsInTable[indexPath.row];
//        cell.textLabel?.text = rowData["title"].string; //title of the song
//        cell.detailTextLabel?.text = rowData["artist"].string;    //artist
//        cell.backgroundColor = UIColor.clearColor();
//       
//        //set cell image
//        let thumbURL = rowData["picture"].string;
//        onGetImageCache(thumbURL!, imgView: cell.imageView!);
//        
//        return cell;
//    }
    
//    func didReceiveResults(results:AnyObject){
////        print(results);
//        let json = JSON(results); //data into json format
//        
//        //assigne value to variabel array
//        if let channels = json["channels"].array{
//            self.channelsInTable = channels;
//            self.list.enabled = true;
//        }else if let songs = json["song"].array{
//            self.songsInTable = songs;
//            self.songListTableView.reloadData();
//        }
//    }
    
//    func onChangeChannel(channelID: String) {
//        //set url of given channel
//        let url = "http://douban.fm/j/mine/playlist?type=n&channel=\(channelID)&from=mainsite"
//        IHttp.onSearch(url);
//    }
    
//    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        //set autoFinish flag
//        autoFinish = false;
//        onSelectRow(indexPath.row);
//    }
    
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        //get destination controller
//        let controller = segue.destinationViewController ;
//        if controller is ChannelListController {
//            // send data to channel Controller
//            (controller as! ChannelListController).channelData = channelsInTable;
//            (controller as! ChannelListController).delegate = self;
////            (controller as! ChannelListController).ChannelListTableView.reloadData();
//        }
//    }

}

