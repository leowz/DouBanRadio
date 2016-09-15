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
    func onSearch(url:String){
        print("onSearch");
        Alamofire.request(.GET, url).responseJSON{
        response in
//            print("response is \(response)");
            self.delegate?.didReceiveResults(response.result.value!);
        }
    }
        
        
    
}

//HTTP protocol
protocol HTTPProtocol{
    func didReceiveResults(results:AnyObject);
}