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
        super.init(texture: texture, color: SKColor.clear, size: CGSize(width: texture.size().width/2, height: texture.size().height/2))
        self.name = "enemy"
        self.physicsBody = SKPhysicsBody(texture: self.texture!, size: self.size)
        self.physicsBody?.isDynamic = true
        self.physicsBody?.usesPreciseCollisionDetection = false
        self.physicsBody?.categoryBitMask = PhisicsCategory.Enemy
        self.physicsBody?.contactTestBitMask = PhisicsCategory.Player |  PhisicsCategory.PlayerBullet
        self.physicsBody?.collisionBitMask = PhisicsCategory.None
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}
