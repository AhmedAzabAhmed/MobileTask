//
//  MobileTaskTests.swift
//  MobileTaskTests
//
//  Created by Ahmed Azab on 19/08/2023.
//

import XCTest
import Combine
@testable import MobileTask

final class RecipesListTest: XCTestCase {

    var viewModel: RecipesViewModel!
    var usecase: MockRecipeListUsecase!
    var cancellable: Set<AnyCancellable>!
    let timeInterval: TimeInterval = 10
    let expectation = XCTestExpectation(description: "Publishes product list then finishes")
    
    override func setUpWithError() throws {
        usecase = MockRecipeListUsecase()
        viewModel = RecipesViewModel(usecase: usecase)
        cancellable = Set<AnyCancellable>()
    }

    override func tearDownWithError() throws {
        usecase = nil
        viewModel = nil
        cancellable.forEach({ $0.cancel() })
        cancellable.removeAll()
        cancellable = nil
    }

    func testSuccessedGetRecipesList() throws {
        viewModel
            .recipesList
            .receive(on: DispatchQueue.main)
            .sink { [weak self] state in
                guard let self = self else { return }
                switch state {
                case .loading:
                    break
                    
                case .success(let list):
                    XCTAssertTrue(list.count > 0)
                    
                case .failure(let error):
                    XCTAssertFalse(!error.localizedDescription.isValidString)
                }
                self.expectation.fulfill()
            }.store(in: &cancellable)
        
        viewModel.getRecipesList()
        wait(for: [expectation], timeout: timeInterval)
    }
    
    func testFailedGetRecipesList() throws {
        usecase.result = .failure(.genericError)
        viewModel
            .recipesList
            .receive(on: DispatchQueue.main)
            .sink { [weak self] state in
                guard let self = self else { return }
                switch state {
                case .loading:
                    break
                    
                case .success(let list):
                    XCTAssertFalse(list.count > 0)
                    
                case .failure(let error):
                    XCTAssertTrue(error.localizedDescription.isValidString)
                }
                self.expectation.fulfill()
            }.store(in: &cancellable)
        
        viewModel.getRecipesList()
        wait(for: [expectation], timeout: timeInterval)
    }

}
