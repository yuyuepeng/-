//
//  scrollModel.swift
//  secondtableViewTry
//
//  Created by 扶摇先生 on 16/12/9.
//  Copyright © 2016年 扶摇先生. All rights reserved.
//

import Foundation
import UIKit
class scrollModel : NSObject{
    var id = String()
    var pic = String()
    var shareUrl = String()
    var spid = String()
    var title = String()
    var type = String()
    var url = String()
    init(dict:NSDictionary) {
        super.init()
        id = "\(dict["id"]!)"
        pic = "\(dict["pic"]!)"
        shareUrl = "\(dict["shareUrl"]!)"
        spid = "\(dict["spid"]!)"
        title = "\(dict["title"]!)"
        type = "\(dict["type"]!)"
        url = "\(dict["url"]!)"
    }
}

