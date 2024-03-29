//
//  SearchRepositoryPresenter.swift
//  iOSEngineerCodeCheck
//
//  Created by 藤井紗良 on 2023/10/20.
//  Copyright © 2023 YUMEMI Inc. All rights reserved.
//

import Foundation

protocol SearchRepositoryPresenterInput {
    func searchRepositories(searchKeyword: String)
    func cancelURLSession()
}

protocol SearchRepositoryPresenterOutput: AnyObject {
    func reloadData(repositories: [RepositoryModel])
}

final class SearchRepositoryPresenter {
    private weak var output: SearchRepositoryPresenterOutput!
    private var repositories: [RepositoryModel]
    private var urlSessionTask: URLSessionTask?

    init(output: SearchRepositoryPresenterOutput!) {
        self.output = output
        self.repositories = []
    }
}

extension SearchRepositoryPresenter: SearchRepositoryPresenterInput {

    func searchRepositories(searchKeyword: String) {
        if let apiURL = createAPIURL(for: searchKeyword) {
            urlSession(apiURL: apiURL)
        }
    }

    func cancelURLSession() {
        urlSessionTask?.cancel()
    }
}

extension SearchRepositoryPresenter {

    func createAPIURL(for searchKeyword: String) -> URL? {
        guard let apiURL = URL(string: "https://api.github.com/search/repositories?q=\(searchKeyword)") else {
            return nil
        }
        return apiURL
    }

    private func urlSession(apiURL: URL) {
        let urlSessionTask = URLSession.shared.dataTask(with: apiURL) { (data, _, error) in

            guard let data = data else {
                print("データがありません")
                return
            }

            if let error = error {
                print("リクエスト失敗: \(error.localizedDescription)")
                return
            }
            
            self.parseRepositoryData(data: data)
        }
        urlSessionTask.resume()
    }

    private func parseRepositoryData(data: Data) {
        do {
            if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
               let items = json["items"] as? [[String: Any]] {
                let repositories = items.compactMap { item in
                    if let fullName = item["full_name"] as? String,
                       let language = item["language"] as? String,
                       let stargazersCount = item["stargazers_count"] as? Int,
                       let watchersCount = item["watchers_count"] as? Int,
                       let forksCount = item["forks_count"] as? Int,
                       let openIssuesCount = item["open_issues_count"] as? Int,
                       let owner = item["owner"] as? [String: Any],
                       let stringImageURL = owner["avatar_url"] as? String,
                       let imageURL = URL(string: stringImageURL) {

                        return RepositoryModel(
                            fullName: fullName,
                            language: language,
                            stargazersCount: stargazersCount,
                            watchersCount: watchersCount,
                            forksCount: forksCount,
                            openIssuesCount: openIssuesCount,
                            avatarURL: imageURL
                        )
                    }
                    return nil
                }
                self.output?.reloadData(repositories: repositories)
                print("リクエスト成功")
            } else {
                print("パースエラー")
            }
        } catch {
            print("パースエラー")
        }
    }
}
