//
//  Tefutefu.swift
//  IMPRINTING
//
//  Created by tomonori takada on 2018/10/27.
//  Copyright © 2018年 takatomo. All rights reserved.
//

import Foundation
import SpriteKit

class Tefutefu : Particle{
    init(sizeRandom:CGFloat=0){
        let tSize=(sizeRandom==0) ? 40
            :40*(1+(CGFloat(arc4random()%UInt32(sizeRandom*2))-sizeRandom)/100)
        super.init(texture: SKTexture(imageNamed: "tefutefu"), color: NSColor.clear,
                   size: CGSize(width: tSize, height: tSize))
    }
    //羽ばたきアクションを実行
    func flap(){
        if(self.xScale != 1 && (self.xScale==0.2 || arc4random()%2==0)){
            //広げるところから
            self.run(SKAction.sequence([
                SKAction.scaleX(to: 1, duration: TimeInterval((0.9-self.xScale)/0.9*0.6)),
                SKAction.repeatForever(SKAction.sequence([
                    SKAction.scaleX(to: 0.2, duration: 0.6),
                    SKAction.scaleX(to: 1, duration: 0.6)
                    ]))
                ]))
        }else{
            //閉じるところから
            self.run(SKAction.sequence([
                SKAction.scaleX(to: 0.2, duration: TimeInterval((self.xScale-0.1)/0.9*0.6)),
                SKAction.repeatForever(SKAction.sequence([
                    SKAction.scaleX(to: 1, duration: 0.6),
                    SKAction.scaleX(to: 0.2, duration: 0.6)
                    ]))
                ]))
        }
    }
    override func drop(dx:CGFloat,dy:CGFloat) {
        //初期値
        self.alpha=CGFloat(arc4random()%30)/100+0.3
        self.xScale=CGFloat(arc4random()%80)/100+0.2
        //移動方向
        let tTheta=CGFloat(arc4random()%80)-40
        var tVec=CGVector(dx: dx, dy: dy)
        tVec.rotate(tTheta)
        tVec.normalize()
        tVec=CGFloat(arc4random()%70+50)*tVec
        //向き
        self.zRotation = -tVec.radian
        //羽ばたき
        self.flap()
        
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
    override func gather() {
        self.alpha=0.2
        self.position=CGPoint(x: 0, y: 20)
        flap()
        self.run(SKAction.group([
            SKAction.moveBy(x: 0, y: 30, duration: 2.5),
            SKAction.fadeAlpha(to: 0.5, duration: 1),
            SKAction.rotate(byAngle: -CGFloat.pi/2, duration: 2.5)
            ]),
                 withKey: "spin")
    }
    override func dissolve() {
        self.removeAction(forKey: "spin")
        self.zRotation=0
        self.run(SKAction.sequence([
            SKAction.group([
                SKAction.move(by: CGVector(dx: 0, dy: 100), duration: 1),
                SKAction.fadeOut(withDuration: 1)
                ]),
            SKAction.run({
                self.removeFromParent()
            })
            ]))
    }
    override func scatter() {
        //透明度
        self.alpha=CGFloat(arc4random()%30)/100+0.3
        //方向
        var tVec=CGVector(dx: 0, dy: 1)
        tVec.rotate(CGFloat(arc4random()%360))
        //速度
        let tSpeed=CGFloat(arc4random()%100)+50
        tVec=tSpeed*tVec
        //向き
        self.zRotation = -tVec.radian
        flap()
        self.run(SKAction.sequence([
            SKAction.group([
                SKAction.moveBy(x: tVec.dx, y: tVec.dy, duration: 1),
                SKAction.fadeOut(withDuration: 1)
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
