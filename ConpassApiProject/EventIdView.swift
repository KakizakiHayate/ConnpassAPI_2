//
//  EventIdView.swift
//  ConpassApiProject
//
//  Created by cmStudent on 2023/01/20.
//

import SwiftUI

struct EventIdView: View {
    @State private var event = [Event]()
    @Environment(\.managedObjectContext) var viewContext
    @FetchRequest(sortDescriptors: [])
    var eventNumber: FetchedResults<EventNumber>
    @Binding var numbers: String
    @EnvironmentObject var eventID: EventID
    var body: some View {
        
        VStack {
            Button(action: {
                deleteNumber()
            }) {
                Text("履歴を全削除")
            }
            
            List {
                //eventをhistoryの数分回したい
                    ForEach(event) { list in
                        VStack(alignment: .leading) {
                            Text("タイトル：\(list.title)")
                            Text("ハッシュタグ： \(list.hashTag)")
                            Text("アドレス： \(list.address)")
                            Text("開始時間: \(list.startDate)")
                            Text("終了時間： \(list.endDate)")
                            Link("ページに飛ぶ",destination: URL(string: list.eventUrl)!)
                            
                        }
                    }
                
            }
            .onAppear(perform:  {
                addNumber(numberStr: eventID.number)
                loadData(numberStr: eventID.number)

            })
        }
    }
    
    func loadData(numberStr: String) {
        
        if numberStr.isEmpty {
            print("中身は空でした。")
            return
        }
        
//        for item in eventNumber {
//            if item.number != nil {
                //item.numberだとnilが見つかる
                let url = URL(string: "https://connpass.com/api/v1/event/?event_id=" + numberStr)!
                print(url)
                
                let request = URLRequest(url: url)
                
                URLSession.shared.dataTask(with: request) { data, responce, error in
                    if let data = data {//データ取得チェック
                        let decoder = JSONDecoder()
                        guard let decoderResponce = try? decoder.decode(Responce.self, from: data) else {
                            print("Json decodeエラー")
                            return
                        }
                        
//                        DispatchQueue.main.async {
                            event = decoderResponce.events
                            event.append(contentsOf: decoderResponce.events)
//                        }
                        
                        
                    }else {
                        print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
                    }
                    
                }.resume()
//            }
           
//        }

    }
    
    func addNumber(numberStr: String) {
        if numberStr.isEmpty {
            return
        }
//        Contextの中にデータを作る記述
        print("中身は空ではありません")
               let newHistory = History(context: viewContext)
                newHistory.number = eventID.number
               do {
                   //saveを試みて上手くいけばデータをContextからPersistentStoreー＞データベースへとデータを送る
                   try viewContext.save()
                   print("セーブに成功\(newHistory.number ?? "oo")")
               } catch {
                   fatalError("セーブに失敗")
               }
    }
    
    func deleteNumber() {
        for item in eventNumber {
            viewContext.delete(item)
        }
        
        do {
            try viewContext.save()
            print("データを全削除")
        } catch {
            fatalError("セーブに失敗")
        }
    }
}
    

//struct EventIdView_Previews: PreviewProvider {
//    static var previews: some View {
//        EventIdView()
//    }
//}
