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
    
    let bulletSpeed: CGFloat = 100.0
   
    init() {
        let texture = SKTexture(imageNamed: "player1.gif")
        super.init(texture: texture, color: SKColor.clear, size: CGSize(width: texture.size().width/2, height: texture.size().height/2))
        self.physicsBody = SKPhysicsBody(texture: self.texture!, size: self.size)
        self.physicsBody?.isDynamic = true
        self.physicsBody?.usesPreciseCollisionDetection = false
        self.physicsBody?.categoryBitMask = PhisicsCategory.Player
        self.physicsBody?.contactTestBitMask = PhisicsCategory.Enemy |  PhisicsCategory.EnemyBullet
        self.physicsBody?.collisionBitMask = PhisicsCategory.None
        animate()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    private func animate() {
        var playerTextures:[SKTexture] = []
        for i in 1...2 {
            playerTextures.append(SKTexture(imageNamed: "player\(i).gif"))
            let playerAnimation = SKAction.repeatForever(SKAction.animate(with: playerTextures, timePerFrame: 1.0))
            self.run(playerAnimation)
        }
    }
    
    func fireBullet(scene: SKScene, target: CGPoint) {
        // create bullet and add to scene
        let bullet = PlayerBullet(imageName: "playerBullet.gif", bulletSound: "playerBullet.mp3")
        bullet.position.x = self.position.x
        bullet.position.y = self.position.y + self.size.height/2
        scene.addChild(bullet)
        // bullet action
        var destination = target
        var distanceX = target.x - bullet.position.x
        var distanceY = target.y - bullet.position.y
        while (destination.x >= 0 && destination.x < scene.size.width && destination.y >= 0 && destination.y < scene.size.height) {
            destination.x += distanceX
            destination.y += distanceY
        }
        distanceX = destination.x - bullet.position.x
        distanceY = destination.y - bullet.position.y
        let distance = sqrt(distanceX*distanceX + distanceY*distanceY)
        let moveBulletAction = SKAction.move(to: destination, duration: TimeInterval(distance/bulletSpeed))
        let removeBulletAction = SKAction.removeFromParent()
        bullet.run(SKAction.sequence([moveBulletAction, removeBulletAction]))
    }
    
}
