//
//  HomeView.swift
//  ConpassApiProject
//
//  Created by cmStudent on 2023/01/20.
//

import SwiftUI
import CoreData
import Foundation

struct HomeView: View {
    //@EnvironmentはEnvironmentValueを取り出すための記述
    //引数には取り出したEnvironmentValueをKeyPathの形式で指定,取り出した値を変数の中に入れる。つまりContextが格納されるから使えるようになる（Context）
    @Environment(\.managedObjectContext) var viewContext
    //データを要求する記述、引数には取得したデータの並び順を指定するためのもの（今回は指定なし）
    @FetchRequest(sortDescriptors: [])
    var history: FetchedResults<History>//取得したデータを格納するhistory
    @State var keyWord: String = ""
    @State var keyWordArray: [String] = []
    @State var isShowSecondView: Bool = false
    @State var allSelect: Bool = false
    @Binding var numbers: String
    
    var body: some View {
        
        VStack {
            HStack {
                Spacer()
                TextField("キーワードを入力",text: $keyWord) {
                }.textFieldStyle(RoundedBorderTextFieldStyle())

                Button(action: {
                    
                    if self.keyWord.isEmpty {//中身が空なら検索できない
                        print("中身は空です")
                        
                    }else {
                        //Binding先にキーワードを渡すために必要。historyは、@Stateを使ってないから無理
                        self.keyWordArray.append(self.keyWord)//入力内容を配列に追加
                        
                        isShowSecondView.toggle()
                        addHistory()
                    }
                    
                }) {
                    Text("検索")
                        .foregroundColor(Color.white)
                }
                .padding(10)
                .background(Color.red)
                .cornerRadius(10)
                .sheet(isPresented: $isShowSecondView) {
                    SecondView(keyWord: $keyWordArray.last!, numbers: .constant(""))//Binding: State
                }
                Spacer()
                }
                HStack {
                    Button(action: deleteHistory){
                        Label("", systemImage: "trash")
                    }.padding()
                    
                    Button(action: {
                        for item in history {
                            item.checked.toggle()
                        }
                        allSelect.toggle()


                    }) {
                        if allSelect {
                            Text("キャンセル")

                        }else {
                            Text("すべて選択")
                        }
                    }
                    Spacer()
                }
                List {
                    
                    
                    
                    if history.isEmpty {
                        Text("・キーワードを入力して検索してください\n※入力しない場合検索できません")
                            .foregroundColor(Color.gray)
                            .font(.system(size: 15.0))
                    }else {
                        
                            ForEach(history) { item in
                                
                            
                                    HStack {
                                        if (item.checked) {

                                            Label("", systemImage: "checkmark.circle")
                                        }else {
                                            Label("", systemImage: "circle")
                                        }
                                        Button (action: {
                                            item.checked.toggle()
                                        }) {
                                            Text((item.keyword ?? ""))
                                                .foregroundColor(.black)
                                        }
                                    }
                            }
                    }
                   
                }
            Spacer()
            
        }
        
    }
    
    func addHistory() {
        //Contextの中にデータを作る記述
        let newHistory = History(context: viewContext)
        newHistory.keyword = keyWord
        
        do {
            //saveを試みて上手くいけばデータをContextからPersistentStoreー＞データベースへとデータを送る
            try viewContext.save()
        } catch {
            fatalError("セーブに失敗")
        }
        self.keyWord = ""
    }
    
    
    func deleteHistory() {
        for item in history {
            if item.checked {
                viewContext.delete(item)
            }
        }
        
        do {
            try viewContext.save()
        } catch {
            fatalError("セーブに失敗")
        }
    }
}



struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(numbers: .constant("1"))
    }
}
