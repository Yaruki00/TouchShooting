//
//  GameScene.swift
//  TouchShooting
//
//  Created by Yuta Kawabe on 2015/06/22.
//  Copyright (c) 2015年 Yaruki00. All rights reserved.
//

import SpriteKit

struct PhisicsCategory {
    static let None        : UInt32 = 0
    static let All         : UInt32 = UInt32.max
    static let Player      : UInt32 = 0x1 << 0
    static let Enemy       : UInt32 = 0x1 << 1
    static let PlayerBullet: UInt32 = 0x1 << 2
    static let EnemyBullet : UInt32 = 0x1 << 3
}

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    let player: Player = Player()
    let maxEnemyNum = 20
    var enemyDisappearCount = 0
    var hit = 0
    var shot = 0
    let infoLabel = SKLabelNode(fontNamed: "Menlo-BoldItalic")
    var finishFlag = false
    
    override func didMoveToView(view: SKView) {
        self.physicsWorld.gravity = CGVectorMake(0, 0)
        self.physicsWorld.contactDelegate = self
        backgroundColor = SKColor.blackColor()
        setupPlayer()
        setupInfoLabel()
        runAction(SKAction.repeatAction(
            SKAction.sequence([
                SKAction.runBlock(addEnemy),
                SKAction.waitForDuration(1.0)
                ]), count: maxEnemyNum
            ))
    }
    
    private func setupPlayer() {
        player.position = CGPoint(x: CGRectGetMidX(self.frame), y: player.size.height/2 + 10)
        addChild(player)
    }
    
    func setupInfoLabel() {
        setInfoLabelText()
        self.infoLabel.fontSize = 12
        self.infoLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Left
        self.infoLabel.fontColor = SKColor.grayColor()
        self.infoLabel.position = CGPoint(x: 0, y: 0)
        addChild(self.infoLabel)
    }
    
    func setInfoLabelText() {
        self.infoLabel.text = "Hit: " + self.hit.description + ", Shot :" + self.shot.description
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
        enemy.runAction(SKAction.sequence([actionMove, actionMoveDone]), completion: increaseEnemyDisappearCount)
    }
    
    func random(#min: CGFloat, max: CGFloat) -> CGFloat {
        return CGFloat(arc4random_uniform(UInt32(max - min))) + min
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        if (!self.finishFlag) {
            let touch = touches.first as! UITouch
            let touchLocation = touch.locationInNode(self)
            player.fireBullet(self, target: touchLocation)
            ++self.shot
            setInfoLabelText()
        }
    }
    
    
    override func update(currentTime: NSTimeInterval) {
        // TODO: render
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        
        var firstBody: SKPhysicsBody!
        var secondBody: SKPhysicsBody!
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        }
        else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        if ((firstBody.categoryBitMask & PhisicsCategory.Enemy != 0) &&
            (secondBody.categoryBitMask & PhisicsCategory.PlayerBullet != 0)) {
                if (contact.bodyA.node?.parent == nil || contact.bodyB.node?.parent == nil) {
                    return
                }
                playerBulletDidCollideWithEnemy(firstBody.node as! SKSpriteNode, playerBullet: secondBody.node as! SKSpriteNode)
        }
        
    }
    
    func playerBulletDidCollideWithEnemy(enemy: SKSpriteNode, playerBullet: SKSpriteNode) {
        runAction(SKAction.playSoundFileNamed("enemy.mp3", waitForCompletion: false))
        enemy.removeFromParent()
        playerBullet.removeFromParent()
        ++hit
        increaseEnemyDisappearCount()
    }
    
    func increaseEnemyDisappearCount() {
        ++self.enemyDisappearCount
        setInfoLabelText()
        if ( self.enemyDisappearCount >= self.maxEnemyNum ) {
            runAction(SKAction.sequence([
                SKAction.waitForDuration(1.0),
                SKAction.runBlock({
                    self.finishFlag = true
                    let finishLabel = SKLabelNode(fontNamed: "Avenir-Heavy")
                    finishLabel.text = "Finish"
                    finishLabel.fontSize = 40
                    finishLabel.fontColor = SKColor.redColor()
                    finishLabel.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
                    self.addChild(finishLabel)
                }),
                SKAction.waitForDuration(3.0),
                SKAction.runBlock({
                    let resultScene = ResultScene(size: self.size, hit: self.hit, shot: self.shot)
                    resultScene.scaleMode = self.scaleMode
                    let transitionType = SKTransition.doorwayWithDuration(2.0)
                    self.view?.presentScene(resultScene, transition: transitionType)
                })
                ]))
            
        }
    }
    
}
