//
//  Enemy.swift
//  TouchShooting
//
//  Created by Yuta Kawabe on 2015/06/25.
//  Copyright (c) 2015年 Yaruki00. All rights reserved.
//

import UIKit
import SpriteKit

class Enemy: SKSpriteNode {
   
    init(texture: SKTexture) {
        super.init(texture: texture, color: SKColor.clearColor(), size: CGSize(width: texture.size().width/2, height: texture.size().height/2))
        self.name = "enemy"
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}
