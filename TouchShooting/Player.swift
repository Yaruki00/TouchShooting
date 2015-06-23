//
//  Player.swift
//  TouchShooting
//
//  Created by Yuta Kawabe on 2015/06/23.
//  Copyright (c) 2015年 Yaruki00. All rights reserved.
//

import UIKit
import SpriteKit

class Player: SKSpriteNode {
   
    init() {
        let texture = SKTexture(imageNamed: "player1")
        super.init(texture: texture, color: SKColor.clearColor(), size: CGSize(width: texture.size().width/2, height: texture.size().height/2))
        animate()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    private func animate() {
        var playerTextures:[SKTexture] = []
        for i in 1...2 {
            playerTextures.append(SKTexture(imageNamed: "player\(i)"))
            let playerAnimation = SKAction.repeatActionForever(SKAction.animateWithTextures(playerTextures, timePerFrame: 1.0))
            self.runAction(playerAnimation)
        }
    }
    
}
