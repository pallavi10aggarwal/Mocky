//
//  HomeViewModel.swift
//  MockyEntersekt
//
//  Created by Pallavi Aggarwal on 5/26/22.
//

import Combine
import CombineExt
import Foundation

protocol HomeViewModelling: BaseViewModelling {
    var viewDidLoad: PassthroughSubject<Void, Never> { get }
    var numberOfRows: Int { get }
    func displayModelForCell(at indexPath: IndexPath) -> MockyResponseDataResult
    var searchStr: CurrentValueSubject<String?, Never> { get }
    var dataSouceUpdated: PassthroughSubject<Void, Never> { get }
    var didSelect: PassthroughSubject<IndexPath, Never> { get }
    var onSelect: AnyPublisher<MockyResponseDataResult, Never> { get }
}

class HomeViewModel: BaseViewModel, HomeViewModelling {
    var viewDidLoad = PassthroughSubject<Void, Never>()
    var dataSouceUpdated = PassthroughSubject<Void, Never>()
    let searchStr = CurrentValueSubject<String?, Never>(nil)
    var didSelect = PassthroughSubject<IndexPath, Never>()
    var onSelect: AnyPublisher<MockyResponseDataResult, Never> { _didSelect.eraseToAnyPublisher() }
    private var _didSelect = PassthroughSubject<MockyResponseDataResult, Never>()

    // MARK: - Properties
    private let homeRepository: HomeRepository
    private var backupDataSource = [MockyResponseDataResult]()
    private var dataSource = [MockyResponseDataResult]() {
        didSet { dataSouceUpdated.send() }
    }
    var numberOfRows: Int { dataSource.count }
    
    private let userDefaults = UserDefaults.standard
    // MARK: - Methods

    init(homeRepository: HomeRepository) {
        self.homeRepository = homeRepository
        super.init()
        bindOutput()
    }
    func displayModelForCell(at indexPath: IndexPath) -> MockyResponseDataResult {
        return dataSource[indexPath.row]
    }

    private func bindOutput() {
        viewDidLoad
            .sink { [weak self] in
                self?.triggerAPI.send()
            }
            .store(in: &subscriptions)
            getSavedData()
            getMockList()
            .sink { networkError in
                print(networkError)
            } receiveValue: { [unowned self] valu in
                debugPrint("resultsresultsresults",valu.floors)
                backupDataSource = valu.floors
                dataSource = valu.floors
                setDataToStorage(result: valu.floors)
            }
            .store(in: &subscriptions)
        searchStr
            .compactMap { $0 }
            .sink { [weak self] searchStr in
                self?.searchString(searchText: searchStr)
            }
            .store(in: &subscriptions)
        didSelect.map { [unowned self] in self.dataSource[$0.row] }
            .assign(to: _didSelect)
            .store(in: &subscriptions)
    }
    private func searchString(searchText: String) {
        dataSource = searchText.isEmpty ?
        backupDataSource : backupDataSource.filter { $0.name.range(of: searchText, options: .caseInsensitive) != nil }
        debugPrint("dataSource", dataSource)
    }
    private func getMockList() -> AnyPublisher<MockyResponse, NetworkError> {
        return homeRepository.mockyList()
        .eraseToAnyPublisher()
    }
    private func setDataToStorage(result: [MockyResponseDataResult]) {
        do {
            try self.userDefaults.setObject(result, forKey: "mockyList")
        } catch {
            print(error.localizedDescription, "Error")
        }
    }
    private func getSavedData() {
        do {
            let mockyList = try userDefaults.getObject(forKey: "mockyList",
                                                        castTo: [MockyResponseDataResult].self)
            dataSource = mockyList
            backupDataSource = mockyList
        } catch {
            print(error.localizedDescription, "Error")
        }
    }
}
