//
//  ArticleTableNewViewCell.swift
//  NoticiasMVVM-New
//
//  Created by Jose David Bustos H on 09-01-24.
//
import UIKit

struct ArticleTableNewModel {
    let autor: String
    let title: String
    let desc: String
    let imageURL: String?
    
    init(autor: String, title: String, desc: String, imageURL: String?) {
        self.autor = autor
        self.title = title
        self.desc = desc
        self.imageURL = imageURL
    }
}

class ArticleTableNewViewCell: UITableViewCell {
    static let identifier = "ArticleTableNewViewCell"
 
    // MARK: - UI Elements
    private lazy var articleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var lblAutor: UILabel = {
        let label = UILabel()
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var lblTitle: UILabel = {
        let label = UILabel()
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var lblDescrip: UILabel = {
        let label = UILabel()
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUIUX()
        configLabels()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configuration
    func configure(_ model: ArticleTableNewModel) {
        lblTitle.text = model.title
        lblDescrip.text = model.desc
        lblAutor.text = model.autor
        
        if let imageURLString = model.imageURL, let url = URL(string: imageURLString) {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url) {
                    DispatchQueue.main.async {
                        self.articleImageView.image = UIImage(data: data)
                    }
                }
            }
        } else {
            articleImageView.image = UIImage(named: "news")
        }
    }
    
    private func setupUIUX() {
        contentView.addSubview(articleImageView)
        contentView.addSubview(lblAutor)
        contentView.addSubview(lblTitle)
        contentView.addSubview(lblDescrip)
        
        NSLayoutConstraint.activate([
            articleImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            articleImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            articleImageView.heightAnchor.constraint(equalToConstant: 80),
            articleImageView.widthAnchor.constraint(equalToConstant: 80),
            
            lblAutor.topAnchor.constraint(equalTo: articleImageView.topAnchor),
            lblAutor.leadingAnchor.constraint(equalTo: articleImageView.trailingAnchor, constant: 10),
            lblAutor.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            
            lblTitle.topAnchor.constraint(equalTo: lblAutor.bottomAnchor, constant: 5),
            lblTitle.leadingAnchor.constraint(equalTo: articleImageView.trailingAnchor, constant: 10),
            lblTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            
            lblDescrip.topAnchor.constraint(equalTo: lblTitle.bottomAnchor, constant: 5),
            lblDescrip.leadingAnchor.constraint(equalTo: articleImageView.trailingAnchor, constant: 10),
            lblDescrip.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            lblDescrip.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15)
        ])
    }
    
    private func configLabels() {
        lblTitle.font = UIFont.boldSystemFont(ofSize: 18.0)
        lblTitle.textColor = .black
        
        lblDescrip.font = UIFont.systemFont(ofSize: 14.0)
        lblDescrip.textColor = .gray
        
        lblAutor.font = UIFont.italicSystemFont(ofSize: 14.0)
        lblAutor.textColor = .darkGray
    }
    
    // MARK: - Override Methods
    override func prepareForReuse() {
        super.prepareForReuse()
        articleImageView.image = nil
        lblTitle.text = nil
        lblDescrip.text = nil
        lblAutor.text = nil
    }
}
