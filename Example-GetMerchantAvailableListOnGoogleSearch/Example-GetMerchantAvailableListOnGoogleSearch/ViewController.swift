//
//  ViewController.swift
//  Example-GetMerchantAvailableListOnGoogleSearch
//
//  Created by 鈴木航 on 2019/05/31.
//  Copyright © 2019 WataruSuzuki. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate {

    let wkwebview = WKWebView()
    let keyword = "stockx+384664-060"
    var isLoadDetailPage = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        wkwebview.navigationDelegate = self
        view.addSubview(wkwebview)
        wkwebview.load(URLRequest(url: URL(string: "https://www.google.com/search?tbm=isch&q=\(keyword)")!))
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        webView.evaluateJavaScript("document.body.innerHTML") { (html, error) in
            if let html = html as? String {
                if self.isLoadDetailPage {
                    print(html)
                } else {
                    self.loadDetail(html: html)
                }
            }
        }
    }
    
    func loadDetail(html: String) {
        let detector = try! NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
        let matches = detector.matches(in: html, options: [], range: NSRange(location: 0, length: html.utf16.count))
        
        for match in matches {
            guard let range = Range(match.range, in: html) else { continue }
            let url = String(html[range])
            if url.contains("https://stockx.com") {
                self.isLoadDetailPage = true
//                self.wkwebview.load(URLRequest(url: URL(string: url)!))
                UIApplication.shared.open(URL(string: url)!, options: [:], completionHandler: nil)
                break
            }
        }
    }
}

