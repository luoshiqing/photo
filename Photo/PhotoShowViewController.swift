//
//  PhotoShowViewController.swift
//  Photo
//
//  Created by sqluo on 2016/11/14.
//  Copyright © 2016年 sqluo. All rights reserved.
//

import UIKit
import Photos

class PhotoShowViewController: UIViewController ,UICollectionViewDelegate, UICollectionViewDataSource{

    
    
    var assetsFetchResults:PHFetchResult<AnyObject>! //取得的资源结果，用了存放的PHAsset
    
    var assetGridThumbnailSize:CGSize! //缩略图大小
    
    var imageManager:PHCachingImageManager! //带缓存的图片管理对象
    
    var myCollectionView: UICollectionView?
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.gray
        
        
        
        // 如果没有传入值 则获取所有资源
        if self.assetsFetchResults == nil {
            
            //则获取所有资源
            let allPhotosOptions = PHFetchOptions()
            allPhotosOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
            //只获取图片
            allPhotosOptions.predicate = NSPredicate(format: "mediaType = %d", PHAssetMediaType.image.rawValue)
            
            let a = PHAsset.fetchAssets(with: .image, options: allPhotosOptions) as! PHFetchResult<AnyObject>
            
            self.assetsFetchResults = a
            
            
        }
        
        //计算我们需要的缩略图大小
        let size = self.view.frame.size
        let w = (size.width - CGFloat(column + 1) * spacing) / CGFloat(column)
        assetGridThumbnailSize = CGSize(width: w, height: w)
        
        // 初始化和重置缓存
        self.imageManager = PHCachingImageManager()
        
        
        self.resetCachedAssets()
        
        self.initCollectionView()
        
    }
    //重置缓存
    func resetCachedAssets(){
        self.imageManager.stopCachingImagesForAllAssets()
    }
    
    //初始化 CollectionView
    
    let column = 3 //每行显示多少个
    let spacing: CGFloat = 2.5 //间距
    
    func initCollectionView(){
        
        let size = self.view.frame.size
        
        let layout = UICollectionViewFlowLayout()
        
        layout.scrollDirection = .vertical
        
        let w = (size.width - CGFloat(column + 1) * spacing) / CGFloat(column)
        layout.itemSize = CGSize(width: w, height: w)
        
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        
        layout.headerReferenceSize = CGSize(width: spacing, height: spacing)
        
        layout.footerReferenceSize = CGSize(width: spacing, height: spacing)
        
        layout.sectionInset.left = spacing
        layout.sectionInset.right = spacing
        
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        self.myCollectionView = UICollectionView(frame: rect, collectionViewLayout: layout)
        
        self.myCollectionView?.backgroundColor = UIColor.white
        
        let nib = UINib(nibName: "PhotoCollectionViewCell", bundle: Bundle.main)
        
        self.myCollectionView?.register(nib, forCellWithReuseIdentifier: "PhotoCell")
        
        self.myCollectionView?.delegate = self
        self.myCollectionView?.dataSource = self
        
        self.view.addSubview(self.myCollectionView!)
        
    }
    
    
    
    
    
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if self.assetsFetchResults == nil {
            return 0
        }else{
            return self.assetsFetchResults.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let identify:String = "PhotoCell"
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identify, for: indexPath) as! PhotoCollectionViewCell
        
        if self.assetsFetchResults != nil {
            
            let asset = self.assetsFetchResults[indexPath.row] as! PHAsset
            
            self.imageManager.requestImage(for: asset, targetSize: assetGridThumbnailSize, contentMode: .aspectFill, options: nil, resultHandler: { (image, info) in
                
                cell.imgView.image = image
  
            })
    
        }
       
        
        return cell
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        
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
