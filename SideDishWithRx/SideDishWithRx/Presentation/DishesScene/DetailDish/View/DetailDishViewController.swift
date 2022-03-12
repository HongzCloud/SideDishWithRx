//
//  DetailDishViewController.swift
//  SideDishWithRx
//
//  Created by 오킹 on 2022/03/12.
//

import UIKit

class DetailDishViewController: UIViewController {
    
    var viewModel: DetailDishViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
