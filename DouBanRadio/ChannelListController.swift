//
//  ChannelListController.swift
//  DouBanRadio
//
//  Created by WENGzhang on 30/08/16.
//  Copyright © 2016 WENGzhang. All rights reserved.
//

import UIKit

class ChannelListController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var ChannelListTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

//MARK:- delegation function
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = ChannelListTableView.dequeueReusableCellWithIdentifier("ChannelCell") ?? UITableViewCell() ;
        return cell;
    }
    
    
}
