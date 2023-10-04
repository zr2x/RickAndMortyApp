//
//  DetailCharacterViewController.swift
//  UfanetTestApp
//
//  Created by Искандер Ситдиков on 23.09.2023.
//

import UIKit

protocol DetailCharacterViewDelegate: AnyObject {
    func updateFav(id: Int, isFav: Bool)
}

class DetailCharacterViewController: UIViewController {
    
    private let constant = Constant()
    var viewModel: DetailViewModelImp // protocol
    var onUpdateFav: (() -> Void)?
    
    weak var delegate: DetailCharacterViewDelegate?
    
    // MARK: - UI
    private var characterImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        
        return image
    }()
    
    private var characterNameLabel = UILabel()
    
    private var statusCharacterLabel = UILabel()
    
    private var speciesCharacterLabel = UILabel()
    
    private var genderCharacterLabel = UILabel()
    
    init(viewModel: DetailViewModelImp) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addViews()
    }
    
    private func addViews() {
        view.addSubview(characterImageView)
        view.addSubview(characterNameLabel)
        view.addSubview(speciesCharacterLabel)
        view.addSubview(statusCharacterLabel)
        view.addSubview(genderCharacterLabel)
        
        layout()
        configureView()
    }
    
    private func configureView() {
        title = "Character detail"
        view.backgroundColor = .systemBackground
        characterImageView.kf.setImage(with: URL(string: viewModel.imageCharacter))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: viewModel.isFavourite ? "Unsave" : "Save",
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(onFavItem))
        
        characterNameLabel.text = "Name: " + viewModel.nameCharacter
        speciesCharacterLabel.text = "Species: " + viewModel.speciesCharacter
        genderCharacterLabel.text = "Gender: " + viewModel.genderCharacter
        statusCharacterLabel.text = "Status: " + viewModel.statusCharacter
        
        characterNameLabel.font = UIFont(name: constant.avenirBook, size: 18)
        speciesCharacterLabel.font = UIFont(name: constant.avenirBook, size: 18)
        genderCharacterLabel.font = UIFont(name: constant.avenirBook, size: 18)
        statusCharacterLabel.font = UIFont(name: constant.avenirBook, size: 18)
    }
    
    // MARK: - Layout
    
    private func layout() {
        
        characterImageView.snp.makeConstraints { make in
            make.left.right.equalTo(view.safeAreaLayoutGuide)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(150)
            make.size.equalTo(100)
        }
        
        characterNameLabel.snp.makeConstraints { make in
            make.top.equalTo(characterImageView.snp.bottom).inset(-150)
            make.left.equalTo(view.safeAreaLayoutGuide).inset(15)
            make.right.equalTo(view.safeAreaLayoutGuide).offset(-15)
        }
        
        statusCharacterLabel.snp.makeConstraints { make in
            make.top.equalTo(characterNameLabel.snp.bottom).offset(10)
            make.left.equalTo(view.safeAreaLayoutGuide).inset(15)
            make.right.equalTo(view.safeAreaLayoutGuide).offset(-15)
        }
        
        speciesCharacterLabel.snp.makeConstraints { make in
            make.top.equalTo(statusCharacterLabel.snp.bottom).offset(10)
            make.left.equalTo(view.safeAreaLayoutGuide).inset(15)
            make.right.equalTo(view.safeAreaLayoutGuide).offset(-15)
        }
        
        genderCharacterLabel.snp.makeConstraints { make in
            make.top.equalTo(speciesCharacterLabel.snp.bottom).offset(10)
            make.left.equalTo(view.safeAreaLayoutGuide).inset(15)
            make.right.equalTo(view.safeAreaLayoutGuide).offset(-15)
        }
    }
    
    @objc
    private func onFavItem() {
        let isFavourite = viewModel.setFav()
        navigationItem.rightBarButtonItem?.title = isFavourite ? "Unsave" : "Save"
        onUpdateFav?()
    }
}
