//
//  SecViewController.swift
//  Photo
//
//  Created by sqluo on 2016/11/14.
//  Copyright © 2016年 sqluo. All rights reserved.
//

import UIKit

import Photos


class AlbumItem {
    //相簿名称
    var title:String?
    //相簿内的资源
    var fetchResult: PHFetchResult<AnyObject>!
    
    init(title:String?,fetchResult:PHFetchResult<AnyObject>){
        self.title = title
        self.fetchResult = fetchResult
    }
    
    
}



class SecViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource{
    
    //相簿列表项集合
    var items:[AlbumItem] = []
  
    var myTabView: UITableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.gray
        
        
        
        self.myTabView = UITableView(frame: self.view.bounds, style: .plain)
        
        self.myTabView?.delegate = self
        self.myTabView?.dataSource = self
        
        self.view.addSubview(self.myTabView!)
        
        
        

        let smartOptions = PHFetchOptions()
        
        let smartAlbums: PHFetchResult<PHAssetCollection> = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .albumRegular, options: smartOptions)
        
        self.convertCollection(collection: smartAlbums as! PHFetchResult<AnyObject>)
        
        //PHAssetCollection
        let userCollections: PHFetchResult<PHCollection> = PHCollectionList.fetchTopLevelUserCollections(with: nil)
        
        self.convertCollection(collection: userCollections as! PHFetchResult<AnyObject>)
        
        self.items.sort { (item1, item2) -> Bool in
            return item1.fetchResult.count > item2.fetchResult.count
        }
        
        
        
    }
    
    func convertCollection(collection:PHFetchResult<AnyObject>){
    
    
        for i in 0..<collection.count {
            
            //获取出当前相簿内的图片
            let resultsOptions = PHFetchOptions()
            
            resultsOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
            
            resultsOptions.predicate = NSPredicate(format: "mediaType = %d",
                                                   PHAssetMediaType.image.rawValue)
            
            guard let c = collection[i] as? PHAssetCollection else { return }
            
            let assetsFetchResult = PHAsset.fetchAssets(in: c, options: resultsOptions)
            
            if assetsFetchResult.count > 0 {
                
                let tit = MyService.transformAblumTitle(title: c.localizedTitle!)
                
                items.append(AlbumItem(title: tit, fetchResult: assetsFetchResult as! PHFetchResult<AnyObject>))
            }
            
            
        }
        

    }
    
    
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let identify = "myCell"
        
        var cell = tableView.dequeueReusableCell(withIdentifier: identify)
        
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: identify)
        }
        
        cell?.accessoryType = .disclosureIndicator
        
        let item = self.items[indexPath.row]

        if let tit = item.title {
            
            let t = MyService.transformAblumTitle(title: tit)
            
            cell?.textLabel?.text = t
        }else{
            cell?.textLabel?.text = "未知"
        }
        
        
        cell?.detailTextLabel?.text = "\(item.fetchResult.count)张"
        
        return cell!
   
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        
        
        
        let item = self.items[indexPath.row]
        
        
        
        if let x = item.fetchResult.firstObject, x is PHAsset {
            print("传递值")
            let photoVC = PhotoShowViewController()
            
            photoVC.title = item.title
            
            photoVC.assetsFetchResults = item.fetchResult
            
            self.navigationController?.pushViewController(photoVC, animated: true)
        }else{
            print("错误？？？")
            return
        }
        
        
    }
    
    
    
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
