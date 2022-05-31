//
//  SubDetailVC.swift
//  MockyEntersekt
//
//  Created by Pallavi Aggarwal on 5/26/22.
//
import UIKit
class SubDetailVC: UIViewController {
    var rooms = [AvailabilityData]()
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
        view.backgroundColor = .label
        setupBaseView()
        setupMockyTableView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        mockyTableView.reloadData()
    }

    func setup(with data: [AvailabilityData]) {
        rooms  = data
    }
    
    func setupBaseView() {
        view.backgroundColor = .white
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
extension SubDetailVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rooms.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MockyTableViewCell.reuseIdentifier,
                                                       for: indexPath) as? MockyTableViewCell else {
            fatalError("Failed to deque a cell")
        }
        cell.configure(with:rooms[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
   
}
