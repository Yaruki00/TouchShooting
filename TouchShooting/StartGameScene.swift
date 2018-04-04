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
   
    override func didMove(to view: SKView) {
        // StartScene settings
        backgroundColor = SKColor.black
        // title label
        let title = SKLabelNode(fontNamed: "Chalkduster")
        title.text = "TouchShooting"
        title.fontSize = 40
        title.fontColor = SKColor.yellow
        title.position = CGPoint(x: size.width/2, y: size.height/2)
        addChild(title)
        // message label
        let message = SKLabelNode(fontNamed: "MarkerFelt-Thin")
        message.text = "Touch Screen to Start!!"
        message.fontSize = 25
        message.fontColor = SKColor.brown
        message.position = CGPoint(x: size.width/2, y: size.height/4)
        addChild(message)
        // flashing message label
        message.run(SKAction.repeatForever(
            SKAction.sequence([
                SKAction.wait(forDuration: 0.5),
                SKAction.hide(),
                SKAction.wait(forDuration: 0.5),
                SKAction.unhide()
                ])))
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        // transit to GameScene
        let gameScene = GameScene(size: size)
        gameScene.scaleMode = scaleMode
        let transitionType = SKTransition.doorway(withDuration: 2.0)
        view?.presentScene(gameScene, transition: transitionType)
    }
    
}
