//
//  ViewController.swift
//  IMPRINTING
//
//  Created by tomonori takada on 2018/10/25.
//  Copyright © 2018年 takatomo. All rights reserved.
//

import Cocoa
import SpriteKit
import GameplayKit

class ViewController: NSViewController {

    @IBOutlet var skView: SKView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let view = self.skView {
            view.allowsTransparency=true
            view.setFrameSize(NSSize(width: NSScreen.main!.frame.width, height: NSScreen.main!.frame.height))
            
            if let scene = SKScene(fileNamed: "GameScene") {
                scene.scaleMode = .aspectFill
                scene.backgroundColor=NSColor.clear
                
                view.presentScene(scene)
            }
            view.ignoresSiblingOrder = true

//            view.showsFPS = true
//            view.showsNodeCount = true
            
            
        }
    }
}

