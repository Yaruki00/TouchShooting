//
//  StartGameScene.swift
//  TouchShooting
//
//  Created by Yuta Kawabe on 2015/06/22.
//  Copyright (c) 2015年 Yaruki00. All rights reserved.
//

import UIKit
import SpriteKit

class StartGameScene: SKScene {
   
    override func didMoveToView(view: SKView) {
        // StartScene settings
        backgroundColor = SKColor.blackColor()
        // title label
        let title = SKLabelNode(fontNamed: "Chalkduster")
        title.text = "TouchShooting"
        title.fontSize = 40
        title.fontColor = SKColor.yellowColor()
        title.position = CGPoint(x: size.width/2, y: size.height/2)
        addChild(title)
        // message label
        let message = SKLabelNode(fontNamed: "MarkerFelt-Thin")
        message.text = "Touch Screen to Start!!"
        message.fontSize = 25
        message.fontColor = SKColor.brownColor()
        message.position = CGPoint(x: size.width/2, y: size.height/4)
        addChild(message)
        // flashing message label
        message.runAction(SKAction.repeatActionForever(
            SKAction.sequence([
                SKAction.waitForDuration(0.5),
                SKAction.hide(),
                SKAction.waitForDuration(0.5),
                SKAction.unhide()
                ])))
    }
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        // transit to GameScene
        let gameScene = GameScene(size: size)
        gameScene.scaleMode = scaleMode
        let transitionType = SKTransition.doorwayWithDuration(2.0)
        view?.presentScene(gameScene, transition: transitionType)
    }
    
}
