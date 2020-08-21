//
//  WebView.swift
//  H4X0R News
//
//  Created by Angela Yu on 08/09/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import Foundation
import WebKit
import SwiftUI

struct WebView: UIViewRepresentable {
    
    let urlString: String?
    
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        // print("urlString: "+urlString!)
        if let safeString = urlString {
            // print("safe: "+safeString)
            if let url = URL(string: safeString) {
                // print("url: \(url)")
                let request = URLRequest(url: url)
                uiView.load(request)
            }
        }
    }    
}


