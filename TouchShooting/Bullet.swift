//
//  Bullet.swift
//  TouchShooting
//
//  Created by Yuta Kawabe on 2015/06/24.
//  Copyright (c) 2015年 Yaruki00. All rights reserved.
//

import UIKit
import SpriteKit

class Bullet: SKSpriteNode {
   
    init(imageName: String, bulletSound: String?) {
        let texture = SKTexture(imageNamed: imageName)
        super.init(texture: texture, color: SKColor.clearColor(), size: texture.size())
        if (bulletSound != nil) {
            runAction(SKAction.playSoundFileNamed(bulletSound!, waitForCompletion: false))
        }
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
