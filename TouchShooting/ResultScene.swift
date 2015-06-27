//
//  ResultScene.swift
//  TouchShooting
//
//  Created by Yuta Kawabe on 2015/06/27.
//  Copyright (c) 2015年 Yaruki00. All rights reserved.
//

import UIKit
import SpriteKit

class ResultScene: SKScene {
    
    var hit: Int = 0
    var shot: Int = 0
    
    init(size: CGSize, hit: Int, shot: Int) {
        super.init(size: size)
        self.hit = hit
        self.shot = shot
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func didMoveToView(view: SKView) {
        // StartScene settings
        backgroundColor = SKColor.blackColor()
        // title label
        let title = SKLabelNode(fontNamed: "Chalkduster")
        title.text = "Result"
        title.fontSize = 40
        title.fontColor = SKColor.greenColor()
        title.position = CGPoint(x: size.width/2, y: size.height/5*4)
        addChild(title)
        // info label
        let infoLabel = SKLabelNode(fontNamed: "Menlo-BoldItalic")
        infoLabel.text = "Hit: " + self.hit.description + ", Shot :" + self.shot.description
        infoLabel.fontSize = 25
        infoLabel.fontColor = SKColor.grayColor()
        infoLabel.position = CGPoint(x: size.width/2, y: size.height/5*3)
        // score label
        let scoreLabel = SKLabelNode(fontNamed: "Thonburi-Bold")
        scoreLabel.text = "Score: " + (self.hit * 3 - (self.shot - self.hit) ).description
        scoreLabel.fontSize = 30
        scoreLabel.fontColor = SKColor.redColor()
        scoreLabel.position = CGPoint(x: size.width/2, y: size.height/5*2)
        // restart button
        let restartButton = SKLabelNode(fontNamed: "GeezaPro-Bold")
        restartButton.name = "restart"
        restartButton.text = "Restart Game"
        restartButton.fontSize = 20
        restartButton.fontColor = SKColor.yellowColor()
        restartButton.position = CGPoint(x: size.width/4, y: size.height/5)
        // title button
        let titleButton = SKLabelNode(fontNamed: "GeezaPro-Bold")
        titleButton.name = "title"
        titleButton.text = "Back to Title"
        titleButton.fontSize = 20
        titleButton.fontColor = SKColor.yellowColor()
        titleButton.position = CGPoint(x: size.width/4*3, y: size.height/5)
        // labels animation
        runAction(SKAction.sequence([
            SKAction.waitForDuration(1.0),
            SKAction.runBlock({self.addChild(infoLabel)}),
            SKAction.waitForDuration(2.0),
            SKAction.runBlock({self.addChild(scoreLabel)}),
            SKAction.waitForDuration(1.0),
            SKAction.runBlock({
                self.addChild(restartButton)
                self.addChild(titleButton)
            })
        ]))
    }
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        let touch = touches.first as! UITouch
        let touchLocation = touch.locationInNode(self)
        let touchedNode = self.nodeAtPoint(touchLocation)
        if (touchedNode.name == "restart") {
            let gameScene = GameScene(size: size)
            gameScene.scaleMode = scaleMode
            let transitionType = SKTransition.doorwayWithDuration(2.0)
            view?.presentScene(gameScene, transition: transitionType)
        }
        else if (touchedNode.name == "title") {
            let startGameScene = StartGameScene(size: size)
            startGameScene.scaleMode = scaleMode
            let transitionType = SKTransition.doorwayWithDuration(2.0)
            view?.presentScene(startGameScene,transition: transitionType)
        }
    }
    
}
