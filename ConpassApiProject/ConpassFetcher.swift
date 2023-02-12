////
////  ConpassFetcher.swift
////  ConpassApiProject
////
////  Created by cmStudent on 2023/01/10.
////
//
//import Foundation
//
//class ConpassFetcher: ObservableObject {
//    let url = "https://connpass.com/api/v1/event/?ym=202210"
//
//    @Published var Conpass: [Mock] = []
//
//    init() {
//        FetcherConpass()
//    }
//
//    func FetcherConpass() {
//        URLSession.shared.dataTask(with: URL(string: url)!) { data, responce, error in
//            guard let data = data else {
//                return
//            }
//            let decoder: JSONDecoder = JSONDecoder()
//            print(decoder)
//            print(data)
//            do{
//                let Conpass = try decoder.decode([Mock].self, from: data)
//                print(Conpass)
//                DispatchQueue.main.async {
//                    self.Conpass = Conpass
//                }
//            } catch {
//                print("FAILED DECODER:", error.localizedDescription)
//            }
//
//        }.resume()
//    }
//
//
//}
