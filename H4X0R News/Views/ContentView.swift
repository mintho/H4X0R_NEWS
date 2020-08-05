//
//  ContentView.swift
//  H4X0R News
//
//  Created by Angela Yu on 08/09/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import SwiftUI
import SwiftUIRefresh

struct ContentView: View {
    
    @State private var isShowing = false
    @ObservedObject var networkManager = NetworkManager()
    

    
    init() {
        
        
        UINavigationBar.appearance().titleTextAttributes =
            [.font : UIFont.monospacedSystemFont(ofSize: 17, weight: .bold), .foregroundColor : UIColor.systemGreen]
        UINavigationBar.appearance().largeTitleTextAttributes =
            [.font : UIFont.monospacedSystemFont(ofSize: 30, weight: .bold), .foregroundColor : UIColor.systemGreen]
        
        
    }
    
    var body: some View {
        NavigationView {
            List(networkManager.posts) { post in
                NavigationLink(destination: DetailView(url: post.url)) {
                    HStack(alignment: .top) {
                        Text(String(post.points)).frame(width: 40)
                            .font(.system(size: 17, design: .monospaced))
                            .foregroundColor(.pink)
                        Text(post.title)
                            .font(.system(size: 17, design: .monospaced))
                            .foregroundColor(.green)
                    }
                }
            }
            .navigationBarTitle("H4X0R_N3W5").foregroundColor(.green)
            .pullToRefresh(isShowing: $isShowing) {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.networkManager.fetchData()
                    self.isShowing = false
                }
            }
        }
        .onAppear {
            self.networkManager.fetchData()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}



//
//let posts = [
//    Post(id: "1", title: "Hello"),
//    Post(id: "2", title: "Bonjour"),
//    Post(id: "3", title: "Hola")
//]
