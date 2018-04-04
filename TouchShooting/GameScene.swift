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
    
    override func didMove(to view: SKView) {
        self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        self.physicsWorld.contactDelegate = self
        backgroundColor = SKColor.black
        setupPlayer()
        setupInfoLabel()
        run(SKAction.repeat(
            SKAction.sequence([
                SKAction.run(addEnemy),
                SKAction.wait(forDuration: 1.0)
                ]), count: maxEnemyNum
            ))
    }
    
    private func setupPlayer() {
        player.position = CGPoint(x: self.frame.midX, y: player.size.height/2 + 10)
        addChild(player)
    }
    
    func setupInfoLabel() {
        setInfoLabelText()
        self.infoLabel.fontSize = 12
        self.infoLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        self.infoLabel.fontColor = SKColor.gray
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
        enemy.position = CGPoint(x: startPointX, y: PointY)
        addChild(enemy)
        // enemy action
        let actionMove = SKAction.move(to: CGPoint(x: endPointX, y: PointY), duration: TimeInterval(10.0))
        let actionMoveDone = SKAction.removeFromParent()
        enemy.run(SKAction.sequence([actionMove, actionMoveDone]), completion: increaseEnemyDisappearCount)
    }
    
    func random(min: CGFloat, max: CGFloat) -> CGFloat {
        return CGFloat(arc4random_uniform(UInt32(max - min))) + min
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if (!self.finishFlag) {
            let touch = touches.first!
            let touchLocation = touch.location(in: self)
            player.fireBullet(scene: self, target: touchLocation)
            self.shot += 1
            setInfoLabelText()
        }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // TODO: render
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        
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
            playerBulletDidCollideWithEnemy(enemy: firstBody.node as! SKSpriteNode, playerBullet: secondBody.node as! SKSpriteNode)
        }
        
    }
    
    func playerBulletDidCollideWithEnemy(enemy: SKSpriteNode, playerBullet: SKSpriteNode) {
        run(SKAction.playSoundFileNamed("enemy.mp3", waitForCompletion: false))
        enemy.removeFromParent()
        playerBullet.removeFromParent()
        hit += 1
        increaseEnemyDisappearCount()
    }
    
    func increaseEnemyDisappearCount() {
        self.enemyDisappearCount += 1
        setInfoLabelText()
        if ( self.enemyDisappearCount >= self.maxEnemyNum ) {
            run(SKAction.sequence([
                SKAction.wait(forDuration: 1.0),
                SKAction.run({
                    self.finishFlag = true
                    let finishLabel = SKLabelNode(fontNamed: "Avenir-Heavy")
                    finishLabel.text = "Finish"
                    finishLabel.fontSize = 40
                    finishLabel.fontColor = SKColor.red
                    finishLabel.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
                    self.addChild(finishLabel)
                }),
                SKAction.wait(forDuration: 3.0),
                SKAction.run({
                    let resultScene = ResultScene(size: self.size, hit: self.hit, shot: self.shot)
                    resultScene.scaleMode = self.scaleMode
                    let transitionType = SKTransition.doorway(withDuration: 2.0)
                    self.view?.presentScene(resultScene, transition: transitionType)
                })
                ]))
            
        }
    }
    
}
