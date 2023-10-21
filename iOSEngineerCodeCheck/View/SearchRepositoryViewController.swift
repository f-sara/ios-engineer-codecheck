//
//  ViewController.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/20.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit

class SearchRepositoryViewController: UITableViewController, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!

    var repositories: [[String: Any]] = []
    var urlSessionTask: URLSessionTask?
    var searchKeyword: String?
    var apiURL: String?
    var selectedRowIndex: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.text = "GitHubのリポジトリを検索できるよー"
        searchBar.delegate = self
    }

    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.text = ""
        return true
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        urlSessionTask?.cancel()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchKeyword = searchBar.text

        if let searchKeyword = searchKeyword, searchKeyword.count != 0 {

            if let apiURL = URL(string: "https://api.github.com/search/repositories?q=\(searchKeyword)") {
                let urlSessionTask = URLSession.shared.dataTask(with: apiURL) { (data, _, error) in

                    if let error = error {
                        print("リクエスト失敗: \(error.localizedDescription)")
                        return
                    }

                    guard let data = data else {
                        print("データがありません")
                        return
                    }

                    do {
                        if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                           let items = json["items"] as? [[String: Any]] {
                            self.repositories = items
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                            }
                            print("リクエスト成功")
                        } else {
                            print("パースエラー")
                        }
                    } catch {
                        print("パースエラー: \(error.localizedDescription)")
                    }
                }
                urlSessionTask.resume()
            }
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Detail" {
            let repositoryDetail = segue.destination as! DetailRepositoryViewController
            repositoryDetail.parentController = self
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositories.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let repository = repositories[indexPath.row]
        cell.textLabel?.text = repository["full_name"] as? String ?? ""
        cell.detailTextLabel?.text = repository["language"] as? String ?? ""
        cell.tag = indexPath.row
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedRowIndex = indexPath.row
        performSegue(withIdentifier: "Detail", sender: self)
    }
}