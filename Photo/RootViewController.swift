//
//  RootViewController.swift
//  Photo
//
//  Created by sqluo on 2016/11/14.
//  Copyright © 2016年 sqluo. All rights reserved.
//

import UIKit

let ScreenSize = UIScreen.main.bounds


class RootViewController: UIViewController ,UITableViewDelegate ,UITableViewDataSource{

    fileprivate let nameArray = ["相册多选","测试","选啊"]
    
    
    fileprivate var myTabView: UITableView?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "开始"
        self.view.backgroundColor = UIColor.white
        
        self.setTabView()
    }

    
    fileprivate func setTabView(){
        
        let rect = self.view.bounds
        self.myTabView = UITableView(frame: rect, style: .plain)
        
        self.myTabView?.delegate = self
        self.myTabView?.dataSource = self
        
        self.myTabView?.tableFooterView = UIView()
        
        self.view.addSubview(self.myTabView!)
  
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.nameArray.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let tableViewCellIdentifier = "Cell"
        
        var cell = tableView.dequeueReusableCell(withIdentifier: tableViewCellIdentifier)
        
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: tableViewCellIdentifier)
        }
        
        cell?.accessoryType = .disclosureIndicator
        
        let name = self.nameArray[indexPath.row]
        
        cell?.textLabel?.text = name
        
        return cell!
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch indexPath.row {
        case 0:
            let multiVC = MultiSelectViewController()
            
            multiVC.title = self.nameArray[indexPath.row]
            
            self.navigationController?.pushViewController(multiVC, animated: true)
        case 1:
            let lsqPh = LSQPhotoViewController()
            lsqPh.title = self.nameArray[indexPath.row]
            self.navigationController?.pushViewController(lsqPh, animated: true)
        case 2:
            let secVC = SecViewController()
            secVC.title = self.nameArray[indexPath.row]
            self.navigationController?.pushViewController(secVC, animated: true)
            
        default:
            break
        }

        
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
