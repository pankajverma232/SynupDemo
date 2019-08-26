//
//  HomeVC.swift
//  SynupDemo
//
//  Created by Pankaj Verma on 24/08/19.
//  Copyright © 2019 Pankaj Verma. All rights reserved.
//

import UIKit

protocol HomeDisplayLogic: class{
    func displayVarients(viewModel:HomeModel.HomeViewModel)
    func displayError(err:String)
}

class HomeVC: UIViewController {
    
    var sections:[HomeModel.HomeViewModel.Section] = []
    var interactor:HomeInteractor?
    
    @IBOutlet weak var tableView:UITableView!
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        configureDependency()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureDependency()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Loader.shared.show(on: self.view)
        interactor?.getVarients(request: nil)
    }
    private func initialSetup(){
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(cell: VariantsCell.self)
        self.title = Constants.Strings.HomeScene.title
        
        // Apply filter bar button
        let applyFilterBarButtonItem = UIBarButtonItem(title: Constants.Strings.HomeScene.applyFilter, style: .done, target: self, action: #selector(applyFilter))
        self.navigationItem.rightBarButtonItem  = applyFilterBarButtonItem
        //refresh bar
        let refreshBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refresh))
        self.navigationItem.leftBarButtonItem  = refreshBarButtonItem
    }
    private func configureDependency(){
        let interactor = HomeInteractor()
        let presenter = HomePresenter()
        self.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = self
    }
    @objc internal func applyFilter(){
        // filter variants
        interactor?.getFilteredVarients()
    }
    @objc internal func refresh(){
        // all variants
        Loader.shared.show(on: self.view)
        interactor?.getVarients(request: nil)
    }
}

//MARK: - tableview dataSource and delegate
extension HomeVC: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].rows.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:VariantsCell = tableView.dequeueReusableCell(indexPath: indexPath)
        let variant = sections[indexPath.section].rows[indexPath.row]
        cell.setModel(viewModel: variant, indexPath: indexPath, delegate: self )
        return cell
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let section = sections[section]
        return section.name ?? ""
    }
}

//MARK: - display logic
extension HomeVC: HomeDisplayLogic {
    func displayVarients(viewModel: HomeModel.HomeViewModel) {
        Loader.shared.hide()
        sections = viewModel.sections
        tableView.reloadData()
        
    }
    func displayError(err:String){
        Loader.shared.hide()
    }
}

// radio button toggle handle
extension HomeVC: VariantsCellDelegate {
    func radioButtonSelected(_ selected: Bool, forSection indexPath: IndexPath?) {
        guard let indexPath = indexPath else {return}
        let selectedRow = sections[indexPath.section].rows[indexPath.row]
        sections[indexPath.section].rows = sections[indexPath.section].rows.map {
            var varient =  $0
              varient.selected = varient.id == selectedRow.id
            
            return varient
        }
        tableView.reloadData()
    }
}
