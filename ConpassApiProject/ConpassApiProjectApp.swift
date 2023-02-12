//
//  ConpassApiProjectApp.swift
//  ConpassApiProject
//
//  Created by cmStudent on 2023/01/06.
//

import SwiftUI

@main
struct ConpassApiProjectApp: App {
    //構造体PersistenceControllerのインスタンスを生成する
    let persistenceController = PersistenceController()
    var body: some Scene {
        WindowGroup {
            ContentView()
            
            //containerにはcontextも含まれているのでそれを使えるようにする
            //ContextViewのmanagedObjectContextというEnvironment Valueに作ったContainerのContextを格納する
            //第一引数には値を格納したいEnvironment Valueの場所をKeyPathという形式で指定する。第二引数には、Environment Valueに格納する値を指定する、これは作ったContainerのContextのことを表す
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(EventID())
            
            
        }
    }
}
