//
//  MainTableViewCell.swift
//  UfanetTestApp
//
//  Created by Искандер Ситдиков on 22.09.2023.
//

import UIKit
import Kingfisher

class MainTableViewCell: UITableViewCell {
    
    var onToggleFav: ((Int) -> Void)?
    static let cellIdentifire = "MainTableViewCell"
    private let constant = Constant()
    private var charID: Int = 0
    
    private var isFavourite: Bool = false {
        didSet {
            updateTitleButton()
        }
    }
    
    // MARK: - UI
    
    private var avatarImageView: UIImageView = {
        var image = UIImageView()
        image.layer.cornerRadius = 10
        
        return image
    }()
    
    private var nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        
        return label
    }()
    
    private var statusLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        
        return label
    }()
    
    private var favouriteButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBlue
        button.setTitle("Add to favorites", for: .normal)
        button.layer.cornerRadius = 15
        button.setTitleColor(.lightGray, for: .highlighted)
        button.addTarget(nil,
                         action: #selector(buttonTap),
                         for: .touchUpInside)
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        layout()
    }
    
    // MARK: - View hierarchy
    
    private func addViews() {
        contentView.backgroundColor = .lightGray
        contentView.layer.cornerRadius = 15
        
        contentView.addSubview(avatarImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(statusLabel)
        contentView.addSubview(favouriteButton)
        
        configureAddFavouriteButton()
    }
    
    // MARK: - Layout

    private func layout() {
        
        contentView.snp.makeConstraints { make in
            make.top.left.equalToSuperview().offset(10)
            make.right.bottom.equalToSuperview().offset(-10)
        }
        
        avatarImageView.snp.makeConstraints { make in
            make.left.equalTo(contentView).inset(20)
            make.top.equalTo(contentView.snp.top).inset(10)
            make.bottom.equalTo(contentView.snp.bottom).inset(10)
            make.width.height.equalTo(150)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.left.equalTo(avatarImageView.snp.right).offset(15)
            make.right.equalTo(contentView.snp.right).offset(-15)
            make.top.equalTo(avatarImageView.snp.top).inset(15)
        }
        statusLabel.snp.makeConstraints { make in
            make.left.equalTo(nameLabel)
            make.right.equalTo(contentView.snp.right).offset(-15)
            make.top.equalTo(nameLabel.snp.bottom).offset(15)
        }

        favouriteButton.snp.makeConstraints { make in
            make.left.equalTo(statusLabel)
            make.bottom.equalTo(avatarImageView.snp.bottom).inset(15)
            make.right.equalTo(contentView.snp.right).offset(-15)
            make.height.equalTo(35)
        }
    }
    
    func configureViews(character: CharacterModel, isFav: Bool) {
        isFavourite = isFav
        charID = character.id
        configureImageView(imageUrl: character.image)
        configureCharacterNameLabel(name: character.name)
        configureStatusCharacterLabel(status: character.status.rawValue)
    }
    
    // MARK: - Private methods
    
    private func configureImageView(imageUrl: String) {
        avatarImageView.contentMode = .scaleAspectFit
        avatarImageView.clipsToBounds = true
        avatarImageView.kf.setImage(with: URL(string: imageUrl))
    }
    
    private func configureCharacterNameLabel(name: String) {
        nameLabel.text = "Name: \(name)"
        nameLabel.font = UIFont(name: constant.avenirBook, size: 18)
    }
    
    private func configureStatusCharacterLabel(status: String) {
        statusLabel.text = "Status: \(status)"
        statusLabel.font = UIFont(name: constant.avenirBook, size: 15)
    }
    
    private func configureAddFavouriteButton() {
        favouriteButton.titleLabel?.font = UIFont(name: constant.avenirBook, size: 15)
    }
    
    private func updateTitleButton() {
        if isFavourite {
            favouriteButton.setTitle("Remove from favourites", for: .normal)
            favouriteButton.backgroundColor = .red
        } else {
            favouriteButton.setTitle("Add to favourites", for: .normal)
            favouriteButton.backgroundColor = .systemBlue
        }
    }
    
    //MARK: - PrepareForReuse method
    
    override func prepareForReuse() {
        super.prepareForReuse()
        avatarImageView.image = nil
        nameLabel.text = ""
        statusLabel.text = ""
        isFavourite = false
        charID = 0
    }
    
    @objc
    private func buttonTap() {
        isFavourite.toggle()
        onToggleFav?(charID)
    }
}
