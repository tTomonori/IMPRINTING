//
//  Particle.swift
//  IMPRINTING
//
//  Created by tomonori takada on 2018/10/27.
//  Copyright © 2018年 takatomo. All rights reserved.
//

import Foundation
import SpriteKit

class Particle : SKSpriteNode{
    init(texture: SKTexture, color: NSColor,size: CGSize){
        super.init(texture: texture, color: color,size: size)
    }
    func drop(dx:CGFloat,dy:CGFloat){}
    func gather(){}
    func dissolve(){}
    func scatter(){}
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
