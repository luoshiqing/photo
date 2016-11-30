//
//  MultiSelectViewController.swift
//  Photo
//
//  Created by sqluo on 2016/11/14.
//  Copyright © 2016年 sqluo. All rights reserved.
//

import UIKit

import Photos


class MultiSelectViewController: UIViewController, PHPhotoLibraryChangeObserver {

    
    var scrollView: UIScrollView?
    
    
    var assets = [PHAsset]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.gray
        
        
//        self.automaticallyAdjustsScrollViewInsets = false
//        
//        
//        self.reloadScrollView()
//        
//        
//        
//        self.getAllAssetInPhotoAblumWithAscending(ascending: true)
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
//        PHPhotoLibrary.shared().register(self)
        
        
    }
    
    func photoLibraryDidChange(_ changeInstance: PHChange) {
        
        DispatchQueue.main.async { 
            print("....")
        }
        
        
    }
    //MARK:读取相册内所有图片资源
    
    func getAllAssetInPhotoAblumWithAscending(ascending: Bool){
        //ascending 为YES时，按照照片的创建时间升序排列;为NO时，则降序排列
        
        var assets = [PHAsset]()
        
        let option = PHFetchOptions()
        
        option.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: ascending)]
        
        let result = PHAsset.fetchAssets(with: PHAssetMediaType.image, options: option)
        
        result.enumerateObjects({ (asset, idx, stop) in
            
            print("照片名: \(asset.value(forKey: "filename"))")
 
            assets.append(asset)
 
        })

        
        self.assets = assets
        
//        self.reloadScrollView()
        
        self.phassetToImg(assets)
        

        
    }
    
    
    var myImgArray = [UIImage]()
    
    //根据获取的PHAsset对象，解析图片
    func phassetToImg(_ asset: [PHAsset]){
        
        
        let option = PHImageRequestOptions()
        
        option.resizeMode = PHImageRequestOptionsResizeMode.fast
        
        option.isNetworkAccessAllowed = true

        var imgArray = [UIImage]()
        
        
        for asset in assets {
            
            PHCachingImageManager.default().requestImage(for: asset, targetSize: PHImageManagerMaximumSize, contentMode: PHImageContentMode.aspectFit, options: option) { (image: UIImage?, info: [AnyHashable : Any]?) in
                
                imgArray.append(image!)

                if imgArray.count == self.assets.count {
                    DispatchQueue.main.async {
                        self.myImgArray = imgArray
                        
                        self.reloadScrollView()
                    }
                }
                
                
                
                
            }
            
            
            
            
            
        }
        
        
        
        
        
        
        
    }
    
    
    //每列 三个
    let column = 3
    

    func reloadScrollView(){
   
        if self.scrollView == nil {
            
            let rect = CGRect(x: 0, y: 64, width: self.view.frame.width, height: self.view.frame.height - 64)
            self.scrollView = UIScrollView(frame: rect)
    
            self.scrollView?.backgroundColor = UIColor.blue
            
            self.view.addSubview(self.scrollView!)
        }
        // 先移除，后添加
        for item in self.scrollView!.subviews {
            item.removeFromSuperview()
        }
    
        
        let toLeft: CGFloat = 5 //间距
        let assetCount = self.myImgArray.count + 1
        //宽度
        let width: CGFloat = (self.view.frame.width - CGFloat(column + 1) * toLeft) / CGFloat(column)
        
        for i in 0..<assetCount {

            let row: Int = i / column //行
            let col: Int = i % column
            
            let btn = UIButton(type: .custom)
            btn.imageView?.contentMode = UIViewContentMode.scaleAspectFill
            
            let x: CGFloat = width * CGFloat(col) + toLeft * CGFloat(col + 1)
            let y: CGFloat = width * CGFloat(row) + toLeft * CGFloat(row + 1)
  
            btn.frame = CGRect(x: x, y: y, width: width, height: width)
            
            if i == self.myImgArray.count {
                
                btn.setImage(UIImage(named: "add.png"), for: UIControlState())
                
                btn.addTarget(self, action: #selector(self.photoSelectet), for: .touchUpInside)
                
                btn.backgroundColor = UIColor.white
            }else{
                let img = self.myImgArray[i]
                btn.setImage(img, for: UIControlState())
                
                btn.backgroundColor = UIColor.red

            }
            
            self.scrollView?.addSubview(btn)
            
        }
        let hhh: CGFloat = (self.scrollView!.subviews.last!).frame.origin.y + width + toLeft
    
        self.scrollView?.contentSize = CGSize(width: self.view.frame.width, height: hhh)
        
  
    }
    
 
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func photoSelectet(){
        print("点击选择照片")
        
        
    }
    
    
    

}
