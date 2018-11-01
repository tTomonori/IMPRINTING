//
//  AppDelegate.swift
//  IMPRINTING
//
//  Created by tomonori takada on 2018/10/25.
//  Copyright © 2018年 takatomo. All rights reserved.
//


import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    //メニューとOutlet接続。
    @IBOutlet weak var menu: NSMenu!
    
    //メニューバーに表示されるアプリケーションを作成
    let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        
        // メニューバーに表示されるアプリ。今回は文字列で設定
//        self.statusItem.title = "Sample"
        let img=NSImage(named: "tefutefu")
        img!.size=NSSize(width: 20, height: 20)
        self.statusItem.image=img
        //メニューのハイライトモードの設定
        self.statusItem.highlightMode = true
        //メニューの指定
        self.statusItem.menu = menu
        
        
        //アプリ終了ボタンを作成
        let quitItem = NSMenuItem()
        //終了ボタンのテキスト
        quitItem.title = "Quit Application"
        //終了ボタンをクリックした時の動作。 ˚˚˚ func quitを呼び出す。˚˚˚
        quitItem.action = #selector(AppDelegate.quit(_:))
        //作成したボタンを追加。
        menu.addItem(quitItem)
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    @objc func quit(_ sender: Any){
        //アプリケーションの終了
        NSApplication.shared.terminate(self)
    }
    
}
