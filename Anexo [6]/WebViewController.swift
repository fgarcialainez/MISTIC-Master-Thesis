//
//  WebViewController.swift
//  TFM - Protección de Aplicaciones Móviles en iOS
//
//  Created by Felix Garcia Lainez on 19/3/18.
//  Copyright (c) 2018. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    
    private var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Disable JavasSript execution
        let preferences = WKPreferences()
        preferences.setJavaScriptEnabled(false)
        preferences.setJavaScriptCanOpenWindowsAutomatically(false)
        
        let configuration = WKWebViewConfiguration()
        configuration.preferences = preferences
        
        webView = WKWebView(frame: view.bounds, configuration: configuration)
        view.addSubview(webView)
    }
}
