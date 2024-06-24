//
//  BaiThiController.swift
//  AppTracNgiem
//
//  Created by thắng on 4/13/24.
//

import UIKit

class BaiThiController: UIViewController {
    var selectedMon: String?
    @IBOutlet weak var monh: UILabel!
    
    @IBOutlet weak var viewDe: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        monh.text = selectedMon
       }
    
    @IBAction func DeSo1(_ sender: Any) {
        viewDe.isHidden = true
        
    }
}
