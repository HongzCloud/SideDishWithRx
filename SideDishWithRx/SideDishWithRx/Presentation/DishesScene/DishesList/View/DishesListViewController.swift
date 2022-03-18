//
//  DishesListViewController.swift
//  SideDishWithRx
//
//  Created by 오킹 on 2022/03/10.
//

import UIKit
import RxSwift
import RxDataSources
import Kingfisher

class DishesListViewController: UIViewController {
    
    var viewModel: DishesListViewModel!
    var disposeBag = DisposeBag()
    
    private lazy var dataSource = RxTableViewSectionedReloadDataSource<DishesListItemViewModel>(configureCell: { [unowned self] (dataSource, tableView, indexPath, item) -> UITableViewCell in
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "DishesListCell", for: indexPath) as? DishesListCell else { return UITableViewCell() }
        
        cell.dishImageView.setImage(imagePath: item.image)
        
        cell.fill(title: item.title, description: item.bodyDescription, nPrice: item.nPrice, sPrice: item.sPrice, badgeList: item.badge)
        
        return cell
    })
    
    @IBOutlet weak var dishesListTableView: UITableView!
    
    override func viewDidLoad() {
        configureDataSource(dataSource)
        bind()
        viewModel.viewDidLoad()
    }
    
    func bind() {

        // Output
        viewModel.items
            .asDriver(onErrorJustReturn: [])
            .drive(dishesListTableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        // Action
        Observable.zip(
            dishesListTableView.rx.itemSelected,
            dishesListTableView.rx.modelSelected(Dish.self))
            
            .subscribe { [weak self] indexPath, item in
                self?.viewModel.itemSelected(dish: item)
                self?.dishesListTableView.deselectRow(at: indexPath, animated: true)
            }
            .disposed(by: disposeBag)
    }
    
    private func configureDataSource(_ dataSource: RxTableViewSectionedReloadDataSource<DishesListItemViewModel>) {
        
        dataSource.titleForHeaderInSection = { dataSource, indexPath in
            return dataSource.sectionModels[indexPath].header
        }
    }
}
