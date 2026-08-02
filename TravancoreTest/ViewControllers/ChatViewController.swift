//
//  ChatViewController.swift
//  TravancoreTest
//
//  Created by John Xavier  on 01/08/2026.
//

import UIKit

class ChatViewController: UIViewController {
    @IBOutlet weak var chatTable: UITableView!
    
    var user : User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = user?.name ?? ""
        // Do any additional setup after loading the view.
    }

}
