//
//  ViewController.swift
//  ERCircularProgressView
//
//  Created by Mahmudul Hasan on 10/21/21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var circularProgressView: ERCircularProgressView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
        
        circularProgressView.foregroundLineColor = .blue
        circularProgressView.lineFinishColor = .red
        circularProgressView.backgroundLineColor = .gray
        circularProgressView.foregroundLineWidth = 20
        circularProgressView.backgroundLineWidth = 20
        //circularProgressView.safePercent = 100
        //circularProgressView.labelTextColor = UIColor.green
        //circularProgressView.labelFont = UIFont.boldSystemFont(ofSize: 25)
    }
    
    @objc func handleTap() {
        circularProgressView.setProgress(to: 1, withAnimation: true)
    }
}

