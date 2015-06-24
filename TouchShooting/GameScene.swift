//
//  GameScene.swift
//  TouchShooting
//
//  Created by Yuta Kawabe on 2015/06/22.
//  Copyright (c) 2015年 Yaruki00. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    let player: Player = Player()
    
    override func didMoveToView(view: SKView) {
        backgroundColor = SKColor.blackColor()
        setupPlayer()
    }
    
    private func setupPlayer() {
        player.position = CGPoint(x: CGRectGetMidX(self.frame), y: player.size.height/2 + 10)
        addChild(player)
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        let touch = touches.first as! UITouch
        let touchLocation = touch.locationInNode(self)
        player.fireBullet(self, target: touchLocation)
    }
    
    
    override func update(currentTime: NSTimeInterval) {
        // TODO: render
    }
    
}
