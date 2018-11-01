//
//  Effector.swift
//  IMPRINTING
//
//  Created by tomonori takada on 2018/10/26.
//  Copyright © 2018年 takatomo. All rights reserved.
//

import Foundation
import SpriteKit

class Effector{
    static private var mScene:SKScene!
    static func activate(_ aScene:SKScene){
        self.mScene=aScene
        
        //マウスの移動
        var tMoveDelta:CGFloat=0
        NSEvent.addGlobalMonitorForEvents(matching: .mouseMoved, handler: { aNSEvent in
            if(arc4random()%100<10){
                let tCosmo=Cosmo(sizeRandom: 30)
                tCosmo.position=CGPoint(x: aNSEvent.locationInWindow.x, y: aNSEvent.locationInWindow.y)
                tCosmo.drop(dx: -aNSEvent.deltaX, dy: aNSEvent.deltaY)
                self.mScene.addChild(tCosmo)
            }
            //生成するか
            let tDelta:CGFloat=sqrt(aNSEvent.deltaX*aNSEvent.deltaX+aNSEvent.deltaY*aNSEvent.deltaY)
            if(tDelta<1){return}
            tMoveDelta+=tDelta
            if(tMoveDelta<50){return}
            tMoveDelta=CGFloat(Int(tMoveDelta)%50)
            
            let tTefu=Tefutefu(sizeRandom: 35)
            tTefu.position=CGPoint(x: aNSEvent.locationInWindow.x, y: aNSEvent.locationInWindow.y)
            tTefu.drop(dx: -aNSEvent.deltaX, dy: aNSEvent.deltaY)
            self.mScene.addChild(tTefu)
        })
        
        var tParticles:[Particle]=[]
        var tCircles:[SKNode]=[]
        var tMousePoint:SKNode!
        //左クリック
        NSEvent.addGlobalMonitorForEvents(matching: .leftMouseDown, handler: {aNSEvent in
            if(tMousePoint != nil){return}
            tMousePoint=SKNode()
            tMousePoint.position=CGPoint(x: aNSEvent.locationInWindow.x, y: aNSEvent.locationInWindow.y)
            tParticles=[]
            tCircles=[]
            self.mScene.addChild(tMousePoint)
            let tNum=CGFloat(arc4random()%3)+5
            let tRote=CGFloat(arc4random()%200)/100*CGFloat.pi
            for i in 0..<Int(tNum){
                //回転用ノード生成
                let tNode=SKNode()
                tNode.zRotation=CGFloat(i)*2/tNum*CGFloat.pi+tRote
                tCircles.append(tNode)
                tMousePoint.addChild(tNode)
                //蝶生成
                let tTefu=Tefutefu()
                tTefu.gather()
                tNode.addChild(tTefu)
                tParticles.append(tTefu)
                
                tNode.run(SKAction.repeatForever(SKAction.rotate(byAngle: -2*CGFloat.pi, duration: 7)))
            }
            //光の玉
            for _ in 0..<Int(arc4random()%5+5){
                let tLight=Cosmo(sizeRandom: 30)
                tLight.position=CGPoint(x: aNSEvent.locationInWindow.x, y: aNSEvent.locationInWindow.y)
                tLight.scatter()
                self.mScene.addChild(tLight)
            }
        })
        //左ドラッグ
        NSEvent.addGlobalMonitorForEvents(matching: .leftMouseDragged, handler: {aNSEvent in
            guard let tPoint=tMousePoint else{return}
            tPoint.position=CGPoint(x: aNSEvent.locationInWindow.x, y: aNSEvent.locationInWindow.y)
        })
        //左up
        NSEvent.addGlobalMonitorForEvents(matching: .leftMouseUp, handler: {aNSEvent in
            guard let tPoint=tMousePoint else{return}
            tMousePoint=nil
            for tCircle in tCircles{
                tCircle.removeAllActions()
            }
            for tTefu in tParticles{
                tTefu.dissolve()
            }
            Timer.scheduledTimer(withTimeInterval: 1, repeats: false, block: {_ in
                tPoint.removeFromParent()
            })
        })
        //右クリック
        NSEvent.addGlobalMonitorForEvents(matching: .rightMouseDown, handler: {aNSEvent in
            for _ in 0..<Int(arc4random()%7+7){
                let tTefu=Tefutefu(sizeRandom: 30)
                tTefu.position=CGPoint(x: aNSEvent.locationInWindow.x, y: aNSEvent.locationInWindow.y)
                tTefu.scatter()
                self.mScene.addChild(tTefu)
            }
        })
        
//        NSEvent.addGlobalMonitorForEvents(matching: .mouseMoved, handler: { aNSEvent in
//            let tDelta:CGFloat=aNSEvent.deltaX*aNSEvent.deltaX+aNSEvent.deltaY*aNSEvent.deltaY
//            if(tDelta<4){return}
//            tMoveDelta+=tDelta
//            if(tMoveDelta<100){return}
//            tMoveDelta=0
//            let tImgNum=arc4random()%15
//            let tTexture=SKTexture(imageNamed: String(tImgNum))
//            let tNode=SKSpriteNode(texture: tTexture)
//            tNode.size=CGSize(width: 50, height: 50)
//            self.mScene.addChild(tNode)
//            tNode.position=CGPoint(x: aNSEvent.locationInWindow.x, y: aNSEvent.locationInWindow.y)
//            tNode.alpha=0.5
//
//            //移動
//            let tTheta=CGFloat(arc4random()%70)-35
//            var tVec=CGVector(dx: -aNSEvent.deltaX, dy: aNSEvent.deltaY)
//            tVec.rotate(tTheta)
//            tVec.normalize()
//            tVec=CGFloat(arc4random()%50+50)*tVec
//            tNode.run(SKAction.sequence([
//                SKAction.group([
//                    SKAction.moveBy(x: tVec.dx, y: tVec.dy, duration: 1),
//                    SKAction.fadeOut(withDuration: 1)
//                    ]),
//                SKAction.run({
//                    tNode.removeFromParent()
//                })
//                ]))
//        })
    }
}
