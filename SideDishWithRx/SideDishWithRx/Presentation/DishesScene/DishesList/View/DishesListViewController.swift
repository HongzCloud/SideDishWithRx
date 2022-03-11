//
//  DishesListViewController.swift
//  SideDishWithRx
//
//  Created by 오킹 on 2022/03/10.
//

import UIKit
import RxSwift
import RxDataSources

class DishesListViewController: UIViewController {
    
    let viewModel = DefaultDishesListViewModel(searchDishesUseCase: DefaultSearchDishesUseCase(dishesRepository: DefaultDishesRepository(networkManager: DefaultNetworkManager())))
    var disposeBag = DisposeBag()
    
    private lazy var dataSource = RxTableViewSectionedReloadDataSource<DishesListItemViewModel>(configureCell: { [unowned self] (dataSource, tableView, indexPath, item) -> UITableViewCell in
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "DishesListCell", for: indexPath) as? DishesListCell else { return UITableViewCell() }
        
        DispatchQueue.global().async {
            if let imageURL = URL(string: item.image) {
                
                var image = try? UIImage(data: Data(contentsOf: imageURL))
                
                if image != nil {
                    DispatchQueue.main.async {
                        cell.dishImageView.image = image
                    }
                }
            }
        }
        
        cell.fill(title: item.title, description: item.bodyDescription, nPrice: item.sPrice, sPrice: item.sPrice, badgeList: item.badge)
        
        return cell
    })
    
    @IBOutlet weak var dishesListTableView: UITableView!
    
    override func viewDidLoad() {
        configureDataSource(dataSource)
        bind()
        viewModel.viewDidLoad()
    }
    
    func bind() {

        // output
        viewModel.items
            .asDriver(onErrorJustReturn: [])
            .drive(dishesListTableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
    }
    
    private func configureDataSource(_ dataSource: RxTableViewSectionedReloadDataSource<DishesListItemViewModel>) {
        
        dataSource.titleForHeaderInSection = { dataSource, indexPath in
            return dataSource.sectionModels[indexPath].header
        }
    }
}


