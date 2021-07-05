//
//  WhyCatsTests.swift
//  WhyCatsTests
//
//  Created by macos on 01/07/2021.
//

import XCTest
@testable import WhyCats

class WhyCatsTests: XCTestCase {
    
    var sut1: AllCatsViewController!
    var collectionView: UICollectionView!
    

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try super.setUpWithError()
        sut1 = AllCatsViewController()
        _ = sut1.view
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut1 = nil
        try super.tearDownWithError()
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testLikeStatusIsChanged() {
//        given
        let indexPath = IndexPath(row: 1, section: 0)
        let isLiked = sut1.catsFetchedResultController.fetchedObjects?[indexPath.item].isLiked
//when
        sut1.allCatsCollectionView.delegate?.collectionView!(sut1.allCatsCollectionView, didSelectItemAt: indexPath)
//then
        XCTAssertEqual(isLiked, true, "isLiked Value is wrong")
    }

}
