//
//  DetailViewController.swift
//  swift-9uick
//
//  Created by Issei Ueda on 2023/02/09.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var detailTextView: UITextView!
    @IBOutlet weak var dateLabel: UILabel!
    
    var str = ""
    var strAfter = ""
    
    var date = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        strAfter = str.replacingOccurrences(of: "｜", with: "\n")

        detailTextView.text = strAfter
        dateLabel.text = "追加日：\(date)"
    }
    
}
