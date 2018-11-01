//
//  MyWindow.swift
//  IMPRINTING
//
//  Created by tomonori takada on 2018/10/25.
//  Copyright © 2018年 takatomo. All rights reserved.
//

import Foundation
import Cocoa
import WebKit

class MyWindow : NSWindow {
    override init(contentRect: NSRect, styleMask style: NSWindow.StyleMask, backing backingStoreType: NSWindow.BackingStoreType, defer flag: Bool) {
        let tScreenSize=NSScreen.main!.frame
        super.init(contentRect: NSRect(x: 0, y: 0, width: tScreenSize.width, height: tScreenSize.height), styleMask: [.fullScreen], backing: backingStoreType, defer: flag)
        
        
        self.level=NSWindow.Level(rawValue: NSWindow.Level.RawValue(20))
        self.collectionBehavior=[.stationary,.canJoinAllSpaces]
        self.ignoresMouseEvents=true
        self.titleVisibility = .hidden
        self.styleMask = .fullSizeContentView
        
        self.isOpaque=true
        self.titlebarAppearsTransparent=false
        self.backgroundColor=NSColor.clear
        self.alphaValue=0.999
        
    }
}
