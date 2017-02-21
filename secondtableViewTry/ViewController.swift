//
//  ViewController.swift
//  secondtableViewTry
//
//  Created by 扶摇先生 on 16/11/21.
//  Copyright © 2016年 扶摇先生. All rights reserved.
//

import UIKit
import Alamofire
class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,secondScrollViewDelegate {
    var tableView:UITableView = UITableView.init(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height), style: UITableViewStyle.plain)
    
    var singleLength:CGFloat = 0.0

    var dataSource:[scrollModel] = Array()
    
    var manager = netManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        singleLength = UIScreen.main.bounds.size.width/640.0
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableHeaderView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: screenWidth, height: 300 * singleLength))
        self.view.addSubview(self.tableView)
        manager.post("http://appapi.yx.dreamore.com/index/banners", path: "", form: ["":""], parameters: ["":""]) { (response, result) in
            let arr:NSArray = response as! NSArray
            for dict:NSDictionary in arr as! [NSDictionary] {
                let model:scrollModel = scrollModel.init(dict: dict)
                self.dataSource.append(model)
            }
            self.tableView.reloadData()
             let headView = secondScrollView.init(frame: CGRect.init(x: 0, y: 0, width: screenWidth, height: 300 * self.singleLength), models: self.dataSource)
            headView.delegate = self
            self.tableView.tableHeaderView = headView
        }
        // Do any additional setup after loading the view, typically from a nib.
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:secondCell = secondCell.init(style: UITableViewCellStyle.default, reuseIdentifier: nil)
        cell.selectionStyle = UITableViewCellSelectionStyle.none;
        let model:scrollModel = self.dataSource[indexPath.row]
        cell.model = model
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400 * singleLength
    }
    func 点击事件(_ modelIndex: Int) {
        let newVc = ModelDetailController()
        newVc.model = self.dataSource[modelIndex]
        self.navigationController?.pushViewController(newVc, animated: true)
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let newVc = ModelDetailController()
        newVc.model = self.dataSource[indexPath.row]
        self.navigationController?.pushViewController(newVc, animated: true)

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

