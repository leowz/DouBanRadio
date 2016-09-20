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

class SongsTableViewModel: NSObject,UITableViewDelegate,UITableViewDataSource,HTTPProtocol,ChannelProtocol {
    //VM`s View target
    weak var view :SongsTableView?;
    //background image
    weak var albumImageView :RoundImage?;
    //song progress bar
    weak var progressBar :SongProgressBar?;
    //background
    weak var background:BackGroundImageView?;
    //labelview time label
    weak var timeLabel :TimeLabelView?;
    //play button
    weak var playAndPause:PlayButton?
    weak var next:ChangeSong?
    weak var previous:ChangeSong?
    weak var mode:ModeButton?
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
    var timer:Timer?;
    //autoFinish Flag for mode algorthm,select song,next will are not autofinishs
    var autoFinish = true;
    
    override init() {
        super.init();

        
        IHttp.delegate = self;
        //get sons in channel 0
        IHttp.onSearch(songsInChannel0);
        //set audio control button
 
        


         //notification when song finishes playing
        NotificationCenter.default.addObserver(self, selector: #selector(SongsTableViewModel.playFinish), name:NSNotification.Name.MPMoviePlayerPlaybackDidFinish , object: nil);
    }
    //alogrithm of play mode when songs autofinished
        func playFinish(){
            if autoFinish{
                switch mode!.mode {
                case 0:
                    curIndex += 1;
                    curIndex %= songsInTable.count;
                    onSelectRow(curIndex);
                case 1:
                    curIndex = Int(arc4random()) % songsInTable.count;
                    onSelectRow(curIndex);
                case 2:
                    onSelectRow(curIndex);
                default:
                    break;
                }
            }else{
                autoFinish = true;
            }
        }

 //singleton
    static let instance: SongsTableViewModel = SongsTableViewModel()
    
    class func shareManager() -> SongsTableViewModel {
        return instance;
    }
    
    func didReceiveResults(_ results:AnyObject){
        print("didReceiveResults");
        let json = JSON(results); //data into json format
        if let songs = json["song"].array{
            print("reloadData");
            self.songsInTable = songs;
            self.view!.reloadData();
        }
    }
    
    func onChangeChannel(_ channelID: String) {
        //set url of given channel
        let url = "http://douban.fm/j/mine/playlist?type=n&channel=\(channelID)&from=mainsite"
        IHttp.onSearch(url);
    }
    
    //the song selected
    func onSelectRow(_ index:Int){
        
        //build an indexpath
        let indexPath = IndexPath.init(row: index, section: 0);
        curIndex = index;
        //when selected
        self.view!.selectRow(at: indexPath, animated: true, scrollPosition: UITableViewScrollPosition.top);
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
        playAndPause!.onPlay();
    }
    //set bakcground image
    func onSetBackground(_ url:String){
        //set image
        onGetImageCache(url, imgView: self.background!);
        onGetImageCache(url, imgView: self.albumImageView!);
    }
    //Music play function
    func onSetAudio(_ url:String){
        //play music
        self.audioPlayer.stop();
        self.audioPlayer.contentURL = URL.init(string: url);
        self.audioPlayer.play();
        
        //set timer
        timer?.invalidate();
        timeLabel!.text = "00:00";
        //start timer
        timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(SongsTableViewModel.onUpdate), userInfo: nil, repeats: true);
        
        //set autofinish Flag
        autoFinish = true;
    }
    
    //timer update function
        func onUpdate(){
            //get current music play time
            let tTime = audioPlayer.duration;//totoal seconds
            let playedTime = audioPlayer.currentPlaybackTime;
            if tTime > 0.0 {
                //translate seconds into real time format
                let realTime = Int(tTime) - Int(playedTime);
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
                timeLabel!.text = time;
    
                //ratio for progressBar
                let ratio = CGFloat(playedTime/tTime);
                //set progressBar
                progressBar!.frame.size.width = view!.frame.width * ratio;
            }
            
         
        }


    
  
    
    //functio for image cache
    func onGetImageCache(_ url:String,imgView:UIImageView){
        //check if the dic contains the image
        let img = imageCache[url];
        //if nil fetch through network else set imgView as img
        if img == nil{
            //set imgView as the fetched image
            Alamofire.request(url).response(completionHandler: { (response) in
                let img = UIImage.init(data:response.data!);
                imgView.image = img;
                //save to cache Dic
                self.imageCache[url] = img;
            })
        }else{
            imgView.image = img;
        }
    }
    
    //MARK:- Delegation function
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songsInTable.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.view!.dequeueReusableCell(withIdentifier: "song") ?? UITableViewCell();// in case of force unwraping nil
        //setting reusable cell
        let rowData = songsInTable[(indexPath as NSIndexPath).row];
        cell.textLabel?.text = rowData["title"].string; //title of the song
        cell.detailTextLabel?.text = rowData["artist"].string;    //artist
        cell.backgroundColor = UIColor.clear;
        
        //set cell image
        let thumbURL = rowData["picture"].string;
        onGetImageCache(thumbURL!, imgView: cell.imageView!);
        
        return cell;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //set autoFinish flag
        autoFinish = false;
        onSelectRow((indexPath as NSIndexPath).row);
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        //cell 3D animation start value
        cell.layer.transform = CATransform3DMakeScale(0.1, 0.1, 1);
        
        UIView.animate(withDuration: 0.35, animations: {
            //end value
            cell.layer.transform = CATransform3DMakeScale(1, 1, 1);
        }) 
    }
}
