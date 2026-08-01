//
//  ViewController.swift
//  TravancoreTest
//
//  Created by John Xavier  on 01/08/2026.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate {
    @IBOutlet weak var mainTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "Test Table View"
        navigationController?.navigationBar.prefersLargeTitles = true
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.register(UINib(nibName: "TestCell", bundle: nil),
                                   forCellReuseIdentifier: "TestCell")
        mainTableView.showsVerticalScrollIndicator = false
    }

}

extension ViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TestCell", for: indexPath) as! TestCell
        cell.titleLabel.text = "John Xavier"
        cell.subtitleLabel.text = "Software Engineer"
        cell.timeStampLabel.text = "10:00 AM"
        cell.readUnreadLabel.text = "Read"
        return cell
        
    }
    
    
}
