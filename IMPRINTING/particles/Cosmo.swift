//
//  Cosmo.swift
//  IMPRINTING
//
//  Created by tomonori takada on 2018/10/27.
//  Copyright © 2018年 takatomo. All rights reserved.
//

import Foundation
import SpriteKit

class Cosmo : Particle{
    init(sizeRandom:CGFloat=0){
        let tSize=(sizeRandom==0) ? 10
            :10*(1+(CGFloat(arc4random()%UInt32(sizeRandom*2))-sizeRandom)/100)
        super.init(texture: SKTexture(imageNamed: "cosmo"), color: NSColor.clear,
                   size: CGSize(width: tSize, height: tSize))
    }
    
    override func drop(dx: CGFloat, dy: CGFloat) {
        //透明度
        self.alpha=CGFloat(arc4random()%20)/100+0.8
        //移動方向
        let tTheta=CGFloat(arc4random()%80)-40
        var tVec=CGVector(dx: dx, dy: dy)
        tVec.rotate(tTheta)
        tVec.normalize()
        tVec=CGFloat(arc4random()%70+50)*tVec
        //向き
        self.zRotation = -tVec.radian
        
        self.run(SKAction.sequence([
            SKAction.group([
                SKAction.moveBy(x: tVec.dx, y: tVec.dy, duration: 1.2),
                SKAction.fadeOut(withDuration: 1.2)
                ]),
            SKAction.run({
                self.removeAllActions()
                self.removeFromParent()
            })
            ]))
    }
    override func scatter() {
        //透明度
        self.alpha=CGFloat(arc4random()%20)/100+0.8
        //方向
        var tVec=CGVector(dx: 0, dy: 1)
        tVec.rotate(CGFloat(arc4random()%360))
        //速度
        let tSpeed=CGFloat(arc4random()%70)+20
        tVec=tSpeed*tVec
        self.run(SKAction.sequence([
            SKAction.group([
                SKAction.moveBy(x: tVec.dx, y: tVec.dy, duration: 0.6),
                SKAction.fadeOut(withDuration: 0.6)
                ]),
            SKAction.run({
                self.removeFromParent()
            })
            ]))
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
