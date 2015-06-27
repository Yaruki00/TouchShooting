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
        self.physicsBody = SKPhysicsBody(texture: self.texture, size: self.size)
        self.physicsBody?.dynamic = true
        self.physicsBody?.usesPreciseCollisionDetection = true
        self.physicsBody?.categoryBitMask = PhisicsCategory.PlayerBullet
        self.physicsBody?.contactTestBitMask = PhisicsCategory.Enemy
        self.physicsBody?.collisionBitMask = PhisicsCategory.None
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
