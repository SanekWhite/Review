//
//  ViewController2.swift
//  Review
//
//  Created by Александр Белый on 30.10.2024.
//

import UIKit

class ViewModel2 {
    var cellViewModels2: [TableViewModel2] = [.init(type: .descriptionRing(.init(info1: "Золотое плоское обручальноe", info2: "кольцо", size: "Размер: 17", icon: .iconRing))),
                                            .init(type: .rating(.init(rating: 0))),
                                            .init(type: .addPhoto(.init(info1: "Добавьте фото или видео", info2: "Нажмите, чтобы выбрать файлы", image: .addPhoto))),
                                          
                                          
                                       
                                           

                                            
    ]
}

class ViewController2: UIViewController {
    let colorGrayLight  = UIColor(red: 246/255, green: 246/255, blue: 246/255, alpha: 1)
    var viewModel2 = ViewModel2()
    
    private lazy var tableView2: UITableView = {
        let tableView2 = UITableView()
        tableView2.backgroundColor = .blue
        tableView2.delegate = self
        tableView2.dataSource = self
        tableView2.register(MyCell2.self, forCellReuseIdentifier: String(describing: MyCell2.self))
        tableView2.register(Ring.self, forCellReuseIdentifier: String(String(describing: Ring.self)))
        tableView2.register(RatingCell.self, forCellReuseIdentifier: String(describing: RatingCell.self))
        tableView2.register(CollectionTableViewCell.self, forCellReuseIdentifier: String(describing: CollectionTableViewCell.self))
       
        

        return tableView2
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Напишите отзыв"
        view.addSubview(tableView2)
        tableView2.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView2.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView2.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView2.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView2.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            
        ])
        
        tableView2.reloadData()
        
    }


}

//MARK: class MyCell2

class MyCell2: UITableViewCell {
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = .lightGray
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}

extension ViewController2: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel2.cellViewModels2.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 2 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CollectionTableViewCell.self), for: indexPath) as? CollectionTableViewCell else {
                fatalError()
            }
            
            return cell
        }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: MyCell2.self)) as? MyCell2 else {
            fatalError()
        }
        
        
        
        let viewModel = self.viewModel2.cellViewModels2[indexPath.row]
        
        switch viewModel.type {
        case .descriptionRing(let descriptionRing):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: Ring.self)) as? Ring else {
                fatalError()
            }
            cell.viewModel2 = descriptionRing
            return cell
            
            
            
            
        case .rating(let rating):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: RatingCell.self), for: indexPath) as? RatingCell else {
                fatalError()
                
            }
            if indexPath.row == 1 {
                cell.backgroundColor = colorGrayLight
                   }
            
            cell.viewModel2 = rating
               return cell
            
        case .addPhoto(let addPhoto):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CollectionTableViewCell.self), for: indexPath) as? CollectionTableViewCell else {
                fatalError()
            }
            
            cell.viewModel2 = addPhoto
            return cell
        }
        
     
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 80
        } else if
            indexPath.row == 1 {
                return 55
            } else if
                indexPath.row == 2 {
                return 80
            }
        
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    
}

//MARK: class Ring

class Ring: UITableViewCell {
    
    var viewModel2: TableViewModel2.viewModelType.Description? {
        didSet {
            updateUI ()
        }
    }
    
    private lazy var ringtitleLabel1: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var ringtitleLabel2: UILabel = {
        let label2 = UILabel()
        label2.textColor = .black
        label2.font = .systemFont(ofSize: 14)
        label2.numberOfLines = 0
        return label2
    }()
    
    private lazy var ringSize: UILabel = {
        let size = UILabel()
        size.textColor = .gray
        size.font = .systemFont(ofSize: 14)
        size.numberOfLines = 0
        return size
    }()
    
    private lazy var iconRingView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "iconRing")
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .clear
        return imageView
    }()
    
    private func updateUI () {
        ringtitleLabel1.text = viewModel2?.info1
        ringtitleLabel2.text = viewModel2?.info2
        iconRingView.image = viewModel2?.icon
        ringSize.text = viewModel2?.size
    }
    
    private func setupUI () {
        contentView.addSubview(ringtitleLabel1)
        contentView.addSubview(ringtitleLabel2)
        contentView.addSubview(iconRingView)
        contentView.addSubview(ringSize)
        
        ringtitleLabel1.translatesAutoresizingMaskIntoConstraints = false
        ringtitleLabel2.translatesAutoresizingMaskIntoConstraints = false
        iconRingView.translatesAutoresizingMaskIntoConstraints = false
        ringSize.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            iconRingView.topAnchor.constraint(equalTo: contentView.topAnchor),
            iconRingView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            
            ringtitleLabel1.topAnchor.constraint(equalTo: iconRingView.topAnchor, constant: 10),
            ringtitleLabel1.leftAnchor.constraint(equalTo: iconRingView.rightAnchor, constant: 12),
            ringtitleLabel1.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -1),
            
            ringtitleLabel2.topAnchor.constraint(equalTo: ringtitleLabel1.bottomAnchor, constant: 2),
            ringtitleLabel2.leftAnchor.constraint(equalTo: iconRingView.rightAnchor, constant: 12),
            
            ringSize.topAnchor.constraint(equalTo: ringtitleLabel2.bottomAnchor, constant: 2),
            ringSize.leftAnchor.constraint(equalTo: iconRingView.rightAnchor, constant: 12)
            
            
            
            
        ])
        
        
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
       // selectionStyle = .none
    }
}

//MARK: struct TableViewModel2

struct TableViewModel2 {
    enum viewModelType {
        struct Description {
            let info1: String
            let info2: String
            let size: String
            let icon: UIImage
            
        }
        struct Rating {
            var rating: Int
        }
        
        struct Photo {
            let info1: String
            let info2: String
            let image: UIImage
        }
        
        case addPhoto(Photo)
        case descriptionRing(Description)
        case rating(Rating)
    }
        
    var type: viewModelType
}

//MARK: class CollectionViewCell

class CollectionViewCell: UICollectionViewCell {
    var viewModel2: TableViewModel2.viewModelType.Photo? {
        didSet {
            updateUI ()
            
        }
    }
   
    
    private func updateUI() {
        label.text = viewModel2?.info1
        
        icon.image = viewModel2?.image
    }
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 14)
        label.textColor = .black
        label.backgroundColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var icon: UIImageView = {
        var iconAdd = UIImageView ()
      //  iconAdd.image = .addPhoto
        return iconAdd
    }()
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
        
    }
    
    private func setupUI () {
        contentView.addSubview(label)
        contentView.addSubview(icon)
        label.translatesAutoresizingMaskIntoConstraints = false
        icon.translatesAutoresizingMaskIntoConstraints = false
     
     
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: contentView.topAnchor),
            label.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 5),
            label.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -5),
            label.heightAnchor.constraint(equalToConstant: 20),
            
            icon.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 5),
            icon.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
        ])
        
    }
    
    
}

//MARK: class CollectionTableViewCell

class CollectionTableViewCell: UITableViewCell {
    var viewModel2: TableViewModel2.viewModelType.Photo?{
        didSet {
            collectionView.reloadData()
            
    }
    
        
    }
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 80, height: 80)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .red
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: String(describing: CollectionViewCell.self))
        return collectionView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
            collectionView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 80)
        ])
        collectionView.reloadData()
    }
}

extension CollectionTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: CollectionViewCell.self), for: indexPath) as? CollectionViewCell else {
            fatalError()
        }
        
        cell.viewModel2 = viewModel2
        
        
        
        return cell
    }
}

//MARK: class RatingCell

class RatingCell: UITableViewCell {
    private let ratingTexts = ["Ваша оценка", "Ужасно", "Плохо", "Нормально", "Хорошо", "Отлично"]
    var viewModel2: TableViewModel2.viewModelType.Rating? {
        didSet {
            
            rating = viewModel2?.rating ?? 0
        }
    }
    
    private let titleLabel = UILabel()
    private lazy var ratingLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textColor = .black
        label.text = ratingTexts[0]
        return label
    }()
    
    private var starImageViews: [UIImageView] = []
    
    var rating: Int = 0 {
        didSet {
            updateStars()
            updateRatingLabel()
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        titleLabel.font = .systemFont(ofSize: 1)
        ratingLabel.font = .systemFont(ofSize: 16)
        ratingLabel.textColor = .black
        contentView.addSubview(titleLabel)
        contentView.addSubview(ratingLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        ratingLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -150),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            
            ratingLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            ratingLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16)
        ])
        
        for index in 0..<5 {
            let imageView = UIImageView(image: UIImage(named: "star_empty"))
            imageView.contentMode = .scaleAspectFit
            imageView.isUserInteractionEnabled = true
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(starTapped(_:)))
            imageView.addGestureRecognizer(tapGesture)
            imageView.tag = index + 1
            starImageViews.append(imageView)
            contentView.addSubview(imageView)
            imageView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                imageView.leadingAnchor.constraint(equalTo: index == 0 ? titleLabel.trailingAnchor : starImageViews[index - 1].trailingAnchor, constant: 4),
                imageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
                
            ])
            
        }
    }
    
    private func updateStars() {
        for (index, imageView) in starImageViews.enumerated() {
            imageView.image = UIImage(named: index < rating ? "star" : "star_empty")
        }
    }
    
    private func updateRatingLabel() {
        ratingLabel.text = ratingTexts[rating]
    }
    
    @objc private func starTapped(_ sender: UITapGestureRecognizer) {
        guard let tappedStar = sender.view else { return }
        rating = tappedStar.tag
        viewModel2?.rating = rating
    }
}





