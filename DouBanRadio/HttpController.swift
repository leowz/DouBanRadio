//
//  HttpController.swift
//  DouBanRadio
//
//  Created by WENGzhang on 30/08/16.
//  Copyright © 2016 WENGzhang. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


class HTTPController: NSObject{
    //delegate

    var delegate:HTTPProtocol?
    //接收网址，回调代理方法传数据
    func onSearch(_ url:String){
        print("onSearch");
        Alamofire.request(url).responseJSON{
        response in
//            print("response is \(response)");
            self.delegate?.didReceiveResults(response.result.value as AnyObject);
        }
    }
        
        
    
}

//HTTP protocol
protocol HTTPProtocol{
    func didReceiveResults(_ results:AnyObject);
}
