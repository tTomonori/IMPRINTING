//
//  math.swift
//  IMPRINTING
//
//  Created by tomonori takada on 2018/10/26.
//  Copyright © 2018年 takatomo. All rights reserved.
//

import Foundation
import SpriteKit

func * (l:CGFloat,r:CGVector)->CGVector{
    return CGVector(dx: l*r.dx, dy: l*r.dy)
}

extension CGVector{
    //大きさ
    var length:CGFloat{
        get{return sqrt(dx*dx+dy*dy)}
    }
    //角度
    var angle:CGFloat{
        get{return atan(dx/dy)*180/CGFloat.pi}
    }
    var radian:CGFloat{
        get{return atan2(dx,dy)}
    }
    //回転する
    mutating func rotate(_ aDeg:CGFloat){
        let tAngle=CGFloat.pi*aDeg/180
        let tX=self.dx
        let tY=self.dy
        self.dx=tX*cos(tAngle)-tY*sin(tAngle)
        self.dy=tX*sin(tAngle)+tY*cos(tAngle)
    }
    //単位ベクトルにする
    mutating func normalize(){
        let tLength=self.length
        self.dx=self.dx/tLength
        self.dy=self.dy/tLength
    }
}
