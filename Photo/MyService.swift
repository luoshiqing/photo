//
//  MyService.swift
//  Photo
//
//  Created by sqluo on 2016/11/14.
//  Copyright © 2016年 sqluo. All rights reserved.
//

import UIKit

class MyService: NSObject {
    
    class func transformAblumTitle(title: String) -> String{

        var valueTit = title
        switch title {
        case "Slo-mo":
            valueTit = "慢动作"
        case "Recently Added":
            valueTit = "最近添加"
        case "Favorites":
            valueTit = "最爱"
        case "Recently Deleted":
            valueTit = "最近删除"
        case "Videos":
            valueTit = "视频"
        case "All Photos":
            valueTit = "所有照片"
        case "Selfies":
            valueTit = "自拍"
        case "Screenshots":
            valueTit = "屏幕快照"
        case "Camera Roll":
            valueTit = "相机胶卷"
        case "Panoramas":
            valueTit = "全景照片"
        case "Hidden":
            valueTit = "隐藏的"
        default:
            valueTit = title
        }
        return valueTit
    }
    
    

}
