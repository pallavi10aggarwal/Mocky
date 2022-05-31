//
//  DetailVC.swift
//  MockyEntersekt
//
//  Created by Pallavi Aggarwal on 5/26/22.
//

import UIKit
protocol DetailVCDelegate: AnyObject {
    func didMoveToSubdetail(model: [AvailabilityData])
}

class DetailVC: UIViewController {
    var rooms = [RoomsData]()
    weak var detailCoordinateDelegate: DetailVCDelegate?
    private lazy var baseView = with(UIView()) {
        $0.backgroundColor = .white
    }
    private lazy var mockyTableView = with(UITableView()) {
        $0.register(MockyTableViewCell.self,
                    forCellReuseIdentifier: MockyTableViewCell.reuseIdentifier)
        $0.separatorStyle = .none
        $0.backgroundColor = .white
        $0.keyboardDismissMode = .onDrag

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupBaseView()
        setupMockyTableView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        mockyTableView.reloadData()
    }

    func setup(with data: MockyResponseDataResult) {
        rooms  = data.rooms ?? []
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
}
extension DetailVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rooms.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MockyTableViewCell.reuseIdentifier,
                                                       for: indexPath) as? MockyTableViewCell else {
            fatalError("Failed to deque a cell")
        }
        cell.configure(with: rooms[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        detailCoordinateDelegate?.didMoveToSubdetail(model: rooms[indexPath.row].availability ?? [])
    }
}
