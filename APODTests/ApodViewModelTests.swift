//
//  ApodViewModelTests.swift
//  APODTests
//
//  Created by Juan Diego Marin on 28/10/22.
//

import XCTest
@testable import APOD

class ApodViewModelTests: XCTestCase {
    
    // MARK: - Private Properties
    private var requestExpectation: XCTestExpectation?
    // MARK: - subject under test
    private var viewModel: ApodViewModel!
    // MARK: - Mock
    private var repositoryMock: ApodRepositoryMock!

    
    // MARK: - SetUp & TearDown
    override func setUp() {
        super.setUp()
        repositoryMock = ApodRepositoryMock()
        viewModel = ApodViewModel(repository: repositoryMock)
        
    }

    override func tearDown() {
        viewModel = nil
        repositoryMock = nil
    }

    
    // MARK: - test getPlanet
    
    func testGetPlanet() {
        // Given
        repositoryMock.planet = ApodFake.values
        // When
        getPlanet()
        // Then
        XCTAssertEqual(requestExpectation?.expectationDescription, RequestExpectation.ok.rawValue)
        
    }
    
}


private extension ApodViewModelTests {
    
    
    // MARK: - getPlanet
    func getPlanet() {
        requestExpectation = expectation(description: RequestExpectation.go.rawValue)
        viewModel.success = {
            self.requestExpectation?.expectationDescription = RequestExpectation.ok.rawValue
            self.requestExpectation?.fulfill()
        }
        viewModel.getPlanet()
        if let requestExpectation = requestExpectation {
            wait(for: [requestExpectation], timeout: 1)
        }
    }
}
