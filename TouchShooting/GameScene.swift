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
        runAction(SKAction.repeatActionForever(
            SKAction.sequence([
                SKAction.runBlock(addEnemy),
                SKAction.waitForDuration(1.0)
                ])
            ))
    }
    
    private func setupPlayer() {
        player.position = CGPoint(x: CGRectGetMidX(self.frame), y: player.size.height/2 + 10)
        addChild(player)
    }
    
    func addEnemy() {
        
        // create enemy
        var enemy: Enemy
        var startPointX: CGFloat
        var PointY: CGFloat
        var endPointX: CGFloat
        if (arc4random_uniform(2) > UInt32(0)) {
            enemy = Enemy(texture: SKTexture(imageNamed: "enemyToRight.gif"))
            startPointX = -enemy.size.width/2
            endPointX = size.width + enemy.size.width/2
            PointY = random(min: size.height/2, max: size.height - enemy.size.height/2)
        }
        else {
            enemy = Enemy(texture: SKTexture(imageNamed: "enemyToLeft.gif"))
            startPointX = size.width + enemy.size.width/2
            endPointX = -enemy.size.width/2
            PointY = random(min: size.height/2, max: size.height - enemy.size.height/2)
        }
        enemy.position = CGPointMake(startPointX, PointY)
        addChild(enemy)
        // enemy action
        let actionMove = SKAction.moveTo(CGPoint(x: endPointX, y: PointY), duration: NSTimeInterval(10.0))
        let actionMoveDone = SKAction.removeFromParent()
        enemy.runAction(SKAction.sequence([actionMove, actionMoveDone]))
    }
    
    func random(#min: CGFloat, max: CGFloat) -> CGFloat {
        return CGFloat(arc4random_uniform(UInt32(max - min))) + min
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
