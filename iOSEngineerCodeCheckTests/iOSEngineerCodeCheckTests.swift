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



}
