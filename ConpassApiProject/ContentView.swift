//
//  ContentView.swift
//  ConpassApiProject
//
//  Created by cmStudent on 2023/01/06.
//

import SwiftUI

struct ContentView: View {
    @State var numbers = ""
    

    var body: some View {
        TabView {
            HomeView(numbers: $numbers)
                .tabItem {
                    Label("", systemImage: "checkmark.circle")
                }
            EventIdView(numbers: $numbers)
                .tabItem {
                    Label("", systemImage: "checkmark.circle")
                }
        }
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
