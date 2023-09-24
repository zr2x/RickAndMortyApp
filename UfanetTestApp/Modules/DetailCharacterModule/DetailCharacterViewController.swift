//
//  DetailCharacterViewController.swift
//  UfanetTestApp
//
//  Created by Искандер Ситдиков on 23.09.2023.
//

import UIKit

class DetailCharacterViewController: UIViewController {
    
    
    var viewModel: DetailViewModel
    let constant = Constant()
    var onUpdateFav: (() -> Void)?
    
    // MARK: - UI
    private var characterImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private var characterNameLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private var statusCharacterLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    private var speciesCharacterLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    private var genderCharacterLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    
    init(viewModel: DetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(onFavItem))
        
        addViews()
    }
    
    private func configureView() {
        title = "Character detail"
        view.backgroundColor = .systemBackground
        characterImageView.kf.setImage(with: URL(string: viewModel.imageCharacter))
        
        characterNameLabel.text = "Name: " + viewModel.nameCharacter
        speciesCharacterLabel.text = "Species " + viewModel.speciesCharacter
        genderCharacterLabel.text = "Gender: " + viewModel.genderCharacter
        statusCharacterLabel.text = "Status: " + viewModel.statusCharacter
        
        characterNameLabel.font = UIFont(name: constant.avenirBook, size: 18)
        speciesCharacterLabel.font = UIFont(name: constant.avenirBook, size: 18)
        genderCharacterLabel.font = UIFont(name: constant.avenirBook, size: 18)
        statusCharacterLabel.font = UIFont(name: constant.avenirBook, size: 18)
        
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
    
    // MARK: - Layout
    
    private func layout() {
        
        characterImageView.snp.makeConstraints { make in
            make.top.left.right.equalTo(view.safeAreaLayoutGuide)
            make.width.height.equalTo(200)
        }
        
        characterNameLabel.snp.makeConstraints { make in
            make.top.equalTo(characterImageView.snp.bottom).offset(10)
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
        viewModel.setFav()
        onUpdateFav?()
    }
}
