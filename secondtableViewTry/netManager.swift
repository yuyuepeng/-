//
//  netManager.swift
//  secondtableViewTry
//
//  Created by 扶摇先生 on 16/11/21.
//  Copyright © 2016年 扶摇先生. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire
class netManager: NSObject {
    
    typealias finished = (_ response:AnyObject?, _ result:String?) ->Void
    func post(_ domain:String,path:String,form:NSDictionary,parameters:NSDictionary,finished: @escaping finished) -> Void {
        let url = self.pinjie(domain, path: path, parameters: parameters)
            Alamofire.upload(multipartFormData: { formData in
                
            self.generate(formData, data: form)
                
            }, to: url) { result in
                switch result {
                case .success(let upload, _, _):
                    upload.responseJSON { response in
                        if let value = response.result.value as? [String: AnyObject]{
                            var dict:NSDictionary = NSDictionary.init(dictionary: value as NSDictionary);
                            finished(dict.object(forKey: "data") as AnyObject?,"victory");
//                            let json = JSON(value)
                            //                            PrintLog(json)
                        }
                    }
                case .failure(let encodingError):
                    finished(encodingError as AnyObject?,"failure");

//                    NSLog("\(encodingError)")
//                    failture(encodingError)
                }

        }

       
    }
    func generate(_ formData:MultipartFormData,data:NSDictionary) -> Void {
        for key in data.allKeys {
            //            遍历上传
            var value = data.value(forKey: (key as? String)!)
            if value is NSDictionary {
                //                如果value是字典，继续执行该方法
                self.generate(formData, data: value as! NSDictionary)
            }else if value is String {
                let strValue = value as! String
                formData.append(strValue.data(using: String.Encoding.utf8)!, withName: key as! String)
            }else if value is NSData {
                let keyStr = key as! NSString
                if keyStr.contains(".") {
                    let arr:[String] = keyStr.components(separatedBy: ".")
                    if arr.last == "png" || arr.last == "jpg"||arr.last == "jpeg" || arr.last == "m4a" {
                        let typeArray = self.mineType(with: (value as! NSData!) as Data).components(separatedBy: "/")
                        let fileName = "\(self.uniqueString()).\(typeArray.last!)"
                        formData.append(value as! Data, withName: arr[0], fileName: fileName, mimeType: self.mineType(with: (value as! NSData) as Data))
                    }
                }else {
                    formData.append(value as! Data, withName: (key as! NSString) as String)
                }
            }else if value is NSArray {//value是数组
                let valueArr:NSArray = value as! NSArray
                if valueArr.firstObject is UIImage {//上传图片的数组
                    var imageData:Data = Data()
                    var a = 1
                    
                    for image:UIImage in valueArr as! [UIImage]{
                        if UIImagePNGRepresentation(image) == nil {
                            let imageData1:Data = UIImageJPEGRepresentation(image, 1.0)!
                            imageData = (imageData1 as NSData) as Data
                        }else {
                            let imageData2:Data = UIImagePNGRepresentation(image)!
                            imageData = (imageData2 as NSData) as Data
                        }
                        formData.append(imageData as Data, withName: key as! String, fileName: "\(self.uniqueString())\(a).jpg", mimeType: "image/jpg")
                        a += 1
                    }
                }else {
                    //                    上传字符串数组
                    var i = 0
                    for stringValue: String in valueArr as! [String] {
                        print("woshi\(i)---\(stringValue)")
                        formData.append(stringValue.data(using: String.Encoding.utf8)!, withName: key as! String)
                        i += 1
                    }
                }
                
            }else if value is UIImage {//上传单张图片
                var imageData:Data = Data();
                let image = (value as! UIImage)
                if UIImagePNGRepresentation(image) == nil {
                    let imageData1:Data = UIImageJPEGRepresentation(image, 1.0)!
                    imageData = (imageData1 as NSData) as Data
                }else {
                    let imageData2:Data = UIImagePNGRepresentation(image)!
                    imageData = (imageData2 as NSData) as Data
                }
                formData.append(imageData as Data, withName: key as! String, fileName: "\(self.uniqueString()).jpg", mimeType: "image/jpg")
                
            }else {
                let valueStr = value as! NSValue
                let valueStr1 = value as! NSString
                let valueStr3 = valueStr as! NSNumber
                
                if valueStr.responds(to: #selector(getter: NSNumber.stringValue)) {
                    formData.append(valueStr3.stringValue.data(using: String.Encoding.utf8)!, withName: key as! String)
                }else if valueStr.responds(to: #selector(NSString.data(using:))) {
                    formData.append(valueStr1.data(using: String.Encoding.utf8.rawValue)!, withName: key as! String)
                }
            }
        }
    }
    func uniqueString() -> String {
        let uuidRef = CFUUIDCreate(nil)
        let uuidStrRef = CFUUIDCreateString(nil, uuidRef)
        let retStr = "\(uuidStrRef as! String)"
        return retStr
    }
    func get(_ domain:String,path:String,form:NSDictionary,parameters:NSDictionary,finished: @escaping finished) -> Void {
        var url = String()
        url = self.pinjie(domain, path: path, parameters: parameters)
        Alamofire.request(url,method:.get).responseJSON { (DataResponse) in
            print("wodeJSON: \(DataResponse)")

            guard let JSON = DataResponse.result.value else {
                finished("" as AnyObject?,"成功")
                return }
            finished(DataResponse.result.value as AnyObject?,"成功")
            print("wode1JSON: \(JSON)")
        }
    }
    
    func pinjie(_ domain:String,path:String,parameters:NSDictionary) -> String {
        var url = "\(domain)"
        if !path.isEmpty {
            url += path
        }
        if parameters.allKeys.count != 0 {
            if parameters.allKeys[0] as! String == "" {
                
            }else {
                url += "?"
                for key: String in parameters.allKeys as! [String] {
                    let value = (parameters.value(forKey: key) as! String)
                    url += "\(key)=\(value)&"
                }
                url = "\(url as NSString).substring(with: NSRange(location: 0, length: url.characters.count - 1))"
            }
        }
        return url
    }
    func mineType(with data: Data) -> String {
        
//        var c = UInt8.init()
         var c = UInt8()
//         var d = NSData(bytes: c, length: 1)
        (data as NSData).getBytes(&c, length: 1)
        NSLog("\(c)");
//        NSLog("\(data)");

        switch c {
        case 0xFF:
            return "image/jpeg"
        case 0x89:
            return "image/png"
        case 0x47:
            return "image/gif"
        case 0x49, 0x4D:
            return "image/tiff"
        case 0x25:
            return "application/pdf"
        case 0xD0:
            return "application/vnd"
        case 0x46:
            return "text/plain"
        default:
            return "application/octet-stream"
        }
        
    }
}

