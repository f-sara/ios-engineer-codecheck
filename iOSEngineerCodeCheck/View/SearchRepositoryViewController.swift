//
//  ViewController.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/20.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit

final class SearchRepositoryViewController: UITableViewController{
    @IBOutlet weak var searchBar: UISearchBar!

    private var presenter: SearchRepositoryPresenterInput!
    var repositories: [RepositoryModel] = []
    var selectedRowIndex: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchBar()
        setupPresenter()
    }

    private func setupSearchBar() {
        searchBar.text = "GitHubのリポジトリを検索できるよー"
        searchBar.delegate = self
    }

    private func setupPresenter() {
        presenter = SearchRepositoryPresenter(output: self)
    }
}

extension SearchRepositoryViewController: UISearchBarDelegate {

    internal func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.text = ""
        return true
    }

    internal func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        presenter.cancelURLSession()
    }

    internal func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchRepository()
    }

    internal func searchRepository() {
        guard let searchKeyword = searchBar.text, searchKeyword.count != 0 else { return }
        presenter.searchRepositories(searchKeyword: searchKeyword)
    }
}

extension SearchRepositoryViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Detail" {
            let repositoryDetail = segue.destination as? DetailRepositoryViewController
            repositoryDetail?.parentController = self
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositories.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let repository = repositories[indexPath.row]
        cell.textLabel?.text = repository.fullName
        cell.detailTextLabel?.text = repository.language
        cell.tag = indexPath.row
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedRowIndex = indexPath.row
        performSegue(withIdentifier: "Detail", sender: self)
    }
}

extension SearchRepositoryViewController: SearchRepositoryPresenterOutput {
    internal func reloadData(repositories: [RepositoryModel]) {
        self.repositories = repositories
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
