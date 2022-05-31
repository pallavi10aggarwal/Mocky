//
//  HomeVC.swift
//  MockyEntersekt
//
//  Created by Pallavi Aggarwal on 5/26/22.
//

import Combine
import UIKit
import SnapKit

protocol HomeVCDelegate: AnyObject {
    func didMoveTodetail(model: MockyResponseDataResult)
}

class HomeVC: UIViewController {
    private lazy var baseView = with(UIView()) {
        $0.backgroundColor = .clear
    }
    private lazy var mockyTableView = with(UITableView()) {
        $0.register(MockyTableViewCell.self,
                    forCellReuseIdentifier: MockyTableViewCell.reuseIdentifier)
        $0.separatorStyle = .none
        $0.backgroundColor = .clear
        $0.keyboardDismissMode = .onDrag

    }
    private lazy var customLoader = with(UIActivityIndicatorView()) {
        $0.style = .large
        $0.startAnimating()
    }
    private lazy var searchBar = with(UISearchBar()) {
        $0.searchBarStyle = .prominent
        $0.placeholder = " Search..."
        $0.sizeToFit()
        $0.isTranslucent = false
        $0.backgroundImage = UIImage()
        navigationItem.titleView = $0
    }
    weak var homeCoordinateDelegate: HomeVCDelegate?
    var viewModel: HomeViewModelling!
    private var subscriptions = Set<AnyCancellable>()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPreData()
        bind(to: viewModel)
        setupBaseView()
        setupMockyTableView()
        setupCustomLoader()
        setupSearchBar()
        viewModel.viewDidLoad.send()
    }
  
}

private extension HomeVC {
    func bind(to viewModel: HomeViewModelling) {
        subscriptions = [
            viewModel
                .dataSouceUpdated
                .receive(on: DispatchQueue.main)
                .sink { [weak self] in
                        self?.customLoader.stopAnimating()
                        self?.mockyTableView.reloadData()
                },
            viewModel
                .onSelect
                .sink(receiveValue: { [weak self] model in
                    self?.navigationItem.backBarButtonItem = UIBarButtonItem(title: model.name,
                                                                             style: .plain,
                                                                             target: nil,
                                                                             action: nil)
                    self?.homeCoordinateDelegate?.didMoveTodetail(model: model)
                }),
            searchBar
                .searchTextField
                .setupSearchBarListener()
                .compactMap {$0}
                .assign(to: viewModel.searchStr)
        ]
    }
    func setupPreData() {
        title = HomeView.title
        navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.tintColor = .black
       
    }
    func setupBaseView() {
        view.addSubview(baseView)
        baseView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.left.equalTo(view)
            make.right.equalTo(view)
            make.bottom.equalTo(view)
        }
    }
    func setupMockyTableView() {
        baseView.addSubview(mockyTableView)
        mockyTableView.delegate = self
        mockyTableView.dataSource = self
        mockyTableView.snp.makeConstraints { make in
            make.edges.equalTo(baseView)
        }
    }
    func setupCustomLoader() {
        mockyTableView.addSubview(customLoader)
        customLoader.snp.makeConstraints { make in
            make.centerY.equalTo(mockyTableView)
            make.centerX.equalTo(mockyTableView)
        }
    }

    func setupSearchBar() {
        searchBar.delegate = self
    }
}

extension HomeVC: UISearchBarDelegate {
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MockyTableViewCell.reuseIdentifier,
                                                       for: indexPath) as? MockyTableViewCell else {
            fatalError("Failed to deque a cell")
        }
        self.customLoader.stopAnimating()
        cell.configure(with: viewModel.displayModelForCell(at: indexPath))
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.didSelect.send(indexPath)
    }
}

