//
//  HomeCoordinator.swift
//  MockyEntersekt
//
//  Created by Pallavi Aggarwal on 5/26/22.
//

import UIKit

protocol HomeCoordinatorDelegate: AnyObject {
    func didStartApp()
}

class HomeCoordinator: Coordinator<DeepLink> {
    lazy var homeVC: HomeVC = {
        let homeVC = self.homeVCFactory()
        homeVC.homeCoordinateDelegate = self
        homeVC.navigationItem.hidesBackButton = true
        return homeVC
    }()
    lazy var detailVC: DetailVC = {
        let detailVC = self.detailVCFactory()
        detailVC.detailCoordinateDelegate = self
        detailVC.navigationItem.hidesBackButton = false
        return detailVC
    }()
    lazy var subDetailVC: SubDetailVC = {
        let subDetailVC = self.subDetailVCFactory()
        subDetailVC.navigationItem.hidesBackButton = false
        return subDetailVC
    }()
    weak var delegate: HomeCoordinatorDelegate?
    private let homeVCFactory: () -> HomeVC
    private let detailVCFactory: () -> DetailVC
    private let subDetailVCFactory: () -> SubDetailVC
    init(router: RouterType,
         homeVCFactory: @escaping () -> HomeVC,
         detailVCFactory: @escaping () -> DetailVC,
         subDetailVCFactory: @escaping () -> SubDetailVC) {
        self.homeVCFactory = homeVCFactory
        self.detailVCFactory = detailVCFactory
        self.subDetailVCFactory = subDetailVCFactory
        super.init(router: router)
    }
    override func start(with link: DeepLink?) {
        guard link != nil else {
            router.setRootModule(self, hideBar: false, animated: true)
            return
        }
    }

    deinit {
        debugPrint("\(self) is dead")
    }
    // default to the router's navigationController
    override func toPresentable() -> UIViewController { homeVC }
}

extension HomeCoordinator: HomeVCDelegate {
    func didMoveTodetail(model: MockyResponseDataResult) {
        moveToDetailVC(model: model)
    }
}

extension HomeCoordinator: DetailVCDelegate {
    func didMoveToSubdetail(model: [AvailabilityData]) {
        moveToSubdetail(model: model)
    }
}
extension HomeCoordinator {
    func moveToDetailVC(model: MockyResponseDataResult) {
        detailVC.setup(with: model)
        router.push(detailVC, animated: true, completion: nil)
    }
    func moveToSubdetail(model: [AvailabilityData]) {
        subDetailVC.setup(with: model)
        router.push(subDetailVC, animated: true, completion: nil)
    }
}

