//
//  PlayerBullet.swift
//  TouchShooting
//
//  Created by Yuta Kawabe on 2015/06/24.
//  Copyright (c) 2015年 Yaruki00. All rights reserved.
//

import UIKit
import SpriteKit

class PlayerBullet: Bullet {
   
    override init(imageName: String, bulletSound: String?) {
        super.init(imageName: imageName, bulletSound: bulletSound)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
