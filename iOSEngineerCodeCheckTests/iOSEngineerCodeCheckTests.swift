//
//  SearchRepositoryPresenterTests.swift
//  iOSEngineerCodeCheckTests
//
//  Created by 史 翔新 on 2020/04/20.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import XCTest
@testable import iOSEngineerCodeCheck

class SearchRepositoryPresenterTests: XCTestCase {
    var presenter: SearchRepositoryPresenter!

    override func setUp() {
        super.setUp()
        presenter = SearchRepositoryPresenter(output: nil)
    }

    func testCreateAPIURL() {
        let url = presenter.createAPIURL(for: "Swift")
        XCTAssertNotNil(url)
        XCTAssertEqual(url?.absoluteString, "https://api.github.com/search/repositories?q=Swift")
    }

    func testSearchRepositories() {
        let searchKeyword = "Swift"
        presenter.searchRepositories(searchKeyword: searchKeyword)
        XCTAssertNotNil(RepositoryModel.self)
    }
}

class RepositoryModelTests: XCTestCase {

    func testInit() {
        let repositoy = RepositoryModel(
            fullName: "test",
            language: "test",
            stargazersCount: 1,
            watchersCount: 2,
            forksCount: 3,
            openIssuesCount: 4,
            avatarURL: URL(string: "https://api.github.com")!
        )

        XCTAssertEqual(repositoy.fullName, "test")
        XCTAssertEqual(repositoy.language, "test")
        XCTAssertEqual(repositoy.stargazersCount, 1)
        XCTAssertEqual(repositoy.watchersCount, 2)
        XCTAssertEqual(repositoy.forksCount, 3)
        XCTAssertEqual(repositoy.openIssuesCount, 4)
        XCTAssertEqual(repositoy.avatarURL, URL(string: "https://api.github.com")!)
    }
}

