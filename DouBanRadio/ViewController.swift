//
//  ViewController.swift
//  DouBanRadio
//
//  Created by WENGzhang on 27/08/16.
//  Copyright © 2016 WENGzhang. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,HTTPProtocol {
    let douBanURL = "http://www.douban.com/j/app/radio/channels";
    let songsInChannel0 = "http://douban.fm/j/mine/playlist?type=n&channel=0&from=mainsite";
    @IBOutlet weak var background: UIImageView! //background imageView
    @IBOutlet weak var albumImageView: roundImage!  //albumImageView
    @IBOutlet weak var songListTableView: UITableView! // song
    var IHttp = HTTPController();
    
//MARK:- Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        //Delegate link
        songListTableView.delegate = self;
        songListTableView.dataSource = self;
        IHttp.delegate = self;
        
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

//MARK:- Delegation function
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = songListTableView.dequeueReusableCellWithIdentifier("song") ?? UITableViewCell();// in case of force unwraping nil
        //setting reusable cell
        cell.textLabel?.text = "title \(indexPath.row)";
        cell.detailTextLabel?.text = "detail title";
        cell.imageView?.image = UIImage.init();
        
        return cell;
    }
    
    func didReceiveResults(results:AnyObject){
        print(results);
    }
}

