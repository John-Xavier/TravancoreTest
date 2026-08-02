//
//  ViewController.swift
//  TravancoreTest
//
//  Created by John Xavier  on 01/08/2026.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate {
    @IBOutlet weak var mainTableView: UITableView!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchLabel: UILabel!
    @IBOutlet weak var searchIconLabel: UILabel!
    
    let sb = UIStoryboard(name: "Main", bundle: nil)

    var users = [User]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Users"
        navigationController?.navigationBar.prefersLargeTitles = true
        setUpTable()
        setUpSearch()
        loadUsers()
    }
    func setUpTable(){
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.register(UINib(nibName: "TestCell", bundle: nil),
                                   forCellReuseIdentifier: "TestCell")
        mainTableView.showsVerticalScrollIndicator = false
    }
    func setUpSearch(){
        
    }
    
    func loadUsers(){
        Task{
            users = try await UserService.shared.getUsers()
            mainTableView.reloadData()
        }
    }
    
    @IBAction func searchButtonAction(_ sender: Any) {
        let vc = sb.instantiateViewController(withIdentifier: "SearchVC") as! SearchVC
        vc.users = self.users
        vc.usersVc = self
        present(vc, animated: true)
    }
    
}

extension ViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TestCell", for: indexPath) as! TestCell
        cell.titleLabel.text = users[indexPath.row].name
        cell.subtitleLabel.text = users[indexPath.row].createdAt
        cell.timeStampLabel.text = "10:00 AM"
        cell.readUnreadLabel.text = "Read"
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = sb.instantiateViewController(withIdentifier: "ChatViewController") as! ChatViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
