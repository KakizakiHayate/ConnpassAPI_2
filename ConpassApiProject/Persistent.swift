//
//  Persistent.swift
//  ConpassApiProject
//
//  Created by cmStudent on 2023/01/18.
//

import CoreData

struct PersistenceController {
    //NSPersistentContainer型のcontainerを定数で宣言
    let container: NSPersistentContainer
    
    //上記の状態では初期値を与えていないので中身は空。この定数にNSPersistentContainerのインスタンスを格納する
    //struct PersistentceControllerのインスタンスが作られたときに格納したい
    init() {
        //NSPersistentContainerのインスタンスを生成してcontainerに初期値を格納する
        container = NSPersistentContainer(name: "ConnpassCoredata")
        
        //containerの生成時にPersistentStoreを読み込み作成したことがない場合は、作成する
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            //失敗した場合にアプリを落とす
            if let  error = error as NSError? {
                fatalError("Unresolved error \(error)")
            }
        })
    }
}
