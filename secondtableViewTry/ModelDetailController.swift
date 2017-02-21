//
//  ModelDetailController.swift
//  secondtableViewTry
//
//  Created by 扶摇先生 on 16/12/30.
//  Copyright © 2016年 扶摇先生. All rights reserved.
//

import UIKit

class ModelDetailController: UIViewController,UIWebViewDelegate {
    
    var model : scrollModel?
    var webView = UIWebView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        webView = UIWebView.init(frame: CGRect.init(x: 0, y: 0, width: screenWidth, height: screenHeight))
        webView.delegate = self
        self.view.addSubview(self.webView)
        self.webView.loadRequest(URLRequest.init(url: URL.init(string: (self.model?.shareUrl)!)!))
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
