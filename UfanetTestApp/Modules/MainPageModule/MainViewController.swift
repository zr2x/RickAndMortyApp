//
//  MainViewController.swift
//  UfanetTestApp
//
//  Created by Искандер Ситдиков on 22.09.2023.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {
    
    var viewModel: MainViewModel = MainViewModelImp()
    var cellDataSource = [CharacterModel]()
    var favourites = Set<Int>()
    var dataSource = [CharacterModel]()
    
    // MARK: - UI
    private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        return tableView
    }()
    
    private var containerView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    private var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        
        return refreshControl
    }()
    
    private var segmentedControl: UISegmentedControl = {
        let itemsSegment = ["All characters", "Favourite"]
        let segment = UISegmentedControl(items: itemsSegment)
        segment.backgroundColor = .lightGray
        segment.selectedSegmentIndex = 0
        segment.addTarget(nil, action: #selector(segmentControlAction), for: .valueChanged)
        return segment
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupViewModel()
    }
    

    private func setupView() {
        self.title = "All characters"
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        view.addSubview(containerView)
        containerView.addSubview(segmentedControl)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MainTableViewCell.self, forCellReuseIdentifier: MainTableViewCell.cellIdentifire)
        tableView.estimatedRowHeight = 120
        tableView.rowHeight = UITableView.automaticDimension
        
        layout()
        setupSegmentedControl()
        setupRefreshControl()
    }
    
    // MARK: - Layout
    private func layout() {
        
        containerView.snp.makeConstraints { make in
            make.left.equalTo(view.safeAreaLayoutGuide).offset(50)
            make.right.equalTo(view.safeAreaLayoutGuide).offset(-50)
            make.height.equalTo(40)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(15)
        }
        
        segmentedControl.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(15)
            make.left.equalTo(view.safeAreaLayoutGuide).offset(50)
            make.right.equalTo(view.safeAreaLayoutGuide).offset(-50)
            make.height.equalTo(35)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(segmentedControl.snp.top).inset(50)
            make.left.right.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func setupViewModel() {
        viewModel.onLoadCharacters = { [weak self] characters in
            guard let self = self else { return }
            self.cellDataSource = characters
            self.dataSource = characters
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        viewModel.getData()
    }
    
    private func setupRefreshControl() {
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshControlAction), for: .valueChanged)
    }
    
    @objc
    private func refreshControlAction() {
        tableView.reloadData()
        DispatchQueue.main.async {
            self.tableView.refreshControl?.endRefreshing()
        }
    }
    
    @objc
    private func segmentControlAction() {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            cellDataSource = dataSource
        case 1:
            cellDataSource = dataSource.filter({ viewModel.getFavouriteList().contains($0.id) })
        default:
            break
        }
        tableView.reloadData()
    }
    
    private func setupSegmentedControl() {
        
    }
}

// MARK: - DataSource, Delegate
extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cellDataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.cellIdentifire, for: indexPath) as? MainTableViewCell else { return UITableViewCell() }
        
        let characterRow = cellDataSource[indexPath.row]
        cell.configureViews(character: characterRow, isFav: viewModel.getFavouriteList().contains(characterRow.id))
        cell.onToggleFav = { [weak self] id in
            guard let dataSource = self?.dataSource, let viewModel = self?.viewModel, let tableView = self?.tableView else { return}
            viewModel.setFavourite(id: id)
            guard self?.segmentedControl.selectedSegmentIndex == 1 else { return }
            self?.cellDataSource = dataSource.filter({ viewModel.getFavouriteList().contains($0.id) })
            tableView.reloadData()  
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let character = cellDataSource[indexPath.row]
        let detail = DetailCharacterViewController(viewModel: DetailViewModel(character: character))
        detail.onUpdateFav = { [weak self] in
            guard let self = self, let cell = tableView.cellForRow(at: indexPath) as? MainTableViewCell else { return }
            cell.configureViews(character: character, isFav: self.viewModel.getFavouriteList().contains(character.id))
        }
        
        navigationController?.pushViewController(detail, animated: true)
    }
}
