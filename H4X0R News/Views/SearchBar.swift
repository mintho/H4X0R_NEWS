//
//  SearchBar.swift
//  H4X0R News
//
//  Created by Thomas Minzenmay on 13.08.20.
//  Copyright © 2020 Angela Yu. All rights reserved.
//

import SwiftUI

struct SearchBar: View {
    
    @Binding var text: String
    let networkManager: NetworkManager
    @State private var isEditing = false
    
    var body: some View {
        HStack {
            
            TextField("Search ...", text: $text, onEditingChanged: { (changed) in
                if changed {
                    print("text edit has begun")
                } else {
                    print("committed the change")
                    // ContentView().refresh(self.text) //replace with delegate
                    let text2 = self.text.replacingOccurrences(of: " ", with: "%20")
                    self.networkManager.fetchData(text2)
                }

            })
                .padding(7)
                .padding(.horizontal, 25)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .accentColor(.green)
                .font(.system(size: 17, design: .monospaced))
                .foregroundColor(.green)
                .overlay(
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 8)
                        
                        if isEditing {
                            Button(action: {
                                self.text = ""
                            }) {
                                Image(systemName: "multiply.circle.fill")
                                    .foregroundColor(.gray)
                                    .padding(.trailing, 8)
                            }
                        }
                    }
            )
                .padding(.horizontal, 10)
                .onTapGesture {
                    self.isEditing = true
            }

            
            if isEditing {
                Button(action: {
                    self.isEditing = false
                    self.text = ""
                    self.networkManager.fetchData(self.text)
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)

                    
                }) {
                    Text("Cancel")
                        .font(.system(size: 17, design: .monospaced))
                        .foregroundColor(.pink)
                    
                }
                .padding(.trailing, 10)
                .transition(.move(edge: .trailing))
                .animation(.easeOut(duration: 0.1))
            }
        }
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(text: .constant(""), networkManager: NetworkManager())
    }
}
