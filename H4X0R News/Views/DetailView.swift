//
//  DetailView.swift
//  H4X0R News
//
//  Created by Angela Yu on 08/09/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import SwiftUI

struct DetailView: View {
    
    let url: String?
    
    @State private var showShareSheet = false
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var btnBack : some View { Button(action: {
        self.presentationMode.wrappedValue.dismiss()
    }) {
        HStack {
            Image(systemName: "arrow.left") // set image here
                .aspectRatio(contentMode: .fit)
                .foregroundColor(.green)
            Text("H4X0R_N3W5")
                .font(.system(size: 17, weight: .semibold, design: .monospaced))
                .foregroundColor(.green)
        }
        }
    }
    
    var btnShare : some View { Button(action: {
        self.showShareSheet = true
    }) {
        Image(systemName: "square.and.arrow.up") // set image here
            .aspectRatio(contentMode: .fit)
            .foregroundColor(.green)
        }
    }
    
    
    var body: some View {
        WebView(urlString: url)
            .edgesIgnoringSafeArea(.bottom)
            .padding(.top, -50)
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: btnBack, trailing: btnShare)
            .sheet(isPresented: $showShareSheet) {
                ShareSheet(activityItems: ["5H4R3_W3851T3"])
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(url: "https://www.google.com")
        
    }
}

