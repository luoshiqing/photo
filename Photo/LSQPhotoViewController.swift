//
//  LSQPhotoViewController.swift
//  Photo
//
//  Created by sqluo on 2016/11/14.
//  Copyright © 2016年 sqluo. All rights reserved.
//

import UIKit


import Photos

class LSQPhotoViewController: UIViewController {

 
//    let a = PHPhotoLibrary()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white
        
//        self.getAlbumsFromDevice()
        self.smartAlbums()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    func getAlbumsFromDevice(){
        
        let userAlbums = PHAssetCollection.fetchAssetCollections(with: PHAssetCollectionType.album, subtype: PHAssetCollectionSubtype.smartAlbumUserLibrary, options: nil)
        
        
        userAlbums.enumerateObjects({ (collection, idx, stop) in
//            print(collection.localizedTitle)
        })
 
    }
    

    
    func smartAlbums(){
        
        let smartAlbums: PHFetchResult = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .albumRegular, options: nil)
        
        smartAlbums.enumerateObjects({ (collection, idx, stop) in

            let tit = collection.localizedTitle!
            
            let new = self.transformAblumTitle(title: tit)
            print(new)
        })
        
    
        
    }
    

    
    
    
    
    
    func transformAblumTitle(title: String) -> String{
        
        var valueTit = title
        switch title {
        case "Slo-mo":
            valueTit += " -->慢动作"
        case "Recently Added":
            valueTit += " -->最近添加"
        case "Favorites":
            valueTit += " -->最爱"
        case "Recently Deleted":
            valueTit += " -->最近删除"
        case "Videos":
            valueTit += " -->视频"
        case "All Photos":
            valueTit += " -->所有照片"
        case "Selfies":
            valueTit += " -->自拍"
        case "Screenshots":
            valueTit += " -->屏幕快照"
        case "Camera Roll":
            valueTit += " -->相机胶卷"
        case "Panoramas":
            valueTit += " -->全景照片"
        case "Hidden":
            valueTit += " -->隐藏的"
        default:
            valueTit += " -->\(title)"
        }
        return valueTit
    }
    
    
    
    
    
    

}
