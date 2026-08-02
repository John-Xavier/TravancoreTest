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
    
    private let searchController = UISearchController(searchResultsController: nil)
    var filteredUsers = [User]()

    private var isSearching: Bool {
        searchController.isActive && !(searchController.searchBar.text ?? "").isEmpty
    }
    
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
    
    func setUpSearch(){
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search users"

        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = true   // tucks under the large title, reveals on pull-down
        definesPresentationContext = true                    // keeps search bar from lingering when you push
    }
    
    func setUpTable(){
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.register(UINib(nibName: "TestCell", bundle: nil),
                                   forCellReuseIdentifier: "TestCell")
        mainTableView.showsVerticalScrollIndicator = false
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
        isSearching ? filteredUsers.count : users.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TestCell", for: indexPath) as! TestCell
        let user = isSearching ? filteredUsers[indexPath.row] : users[indexPath.row]
        cell.titleLabel.text = user.name
        // ...rest as before...
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = isSearching ? filteredUsers[indexPath.row] : users[indexPath.row]
        let chat = sb.instantiateViewController(withIdentifier: "ChatViewController") as! ChatViewController
        // pass user to chat if needed
        navigationController?.pushViewController(chat, animated: true)
    }
    
}
extension ViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let q = (searchController.searchBar.text ?? "")
            .trimmingCharacters(in: .whitespaces).lowercased()
        filteredUsers = q.isEmpty ? [] : users.filter { $0.name.lowercased().contains(q) }
        mainTableView.reloadData()
    }
}
