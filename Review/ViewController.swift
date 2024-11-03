//
//  ViewController.swift
//  Review
//
//  Created by Александр Белый on 29.10.2024.
//

import UIKit

class ViewModel {
    var cellViewModels: [TableViewModel] = [
        .init(type: .review(.init(icon: .iconRing, info: "Золотое плоское", info2: "обручальное кольцо 4 мм", next: .next))),
        .init(type: .review(.init(icon: .iconRing2, info: "Золотое плоское", info2: "обручальное кольцо 4 мм", next: .next))),
        .init(type: .review(.init(icon: .iconRing3, info: "Золотое плоское", info2: "обручальное кольцо 4 мм", next: .next))),
        .init(type: .review(.init(icon: .iconRing4, info: "Золотое плоское", info2: "обручальное кольцо 4 мм", next: .next))),
     
        
    ]
        
    var collectionOfRaiting: [Int] = []
    
}

class ViewController: UIViewController {
    let viewModel = ViewModel()
    
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView ()
        tableView.backgroundColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MyCell.self, forCellReuseIdentifier: String(describing: MyCell.self))
        tableView.register(TitleCell.self, forCellReuseIdentifier: String(describing: TitleCell.self))
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        
        return tableView
        
    }()

 

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Напишите отзыв"
 
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
    
        ])
        tableView.reloadData()
    }


}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.cellViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: MyCell.self)) as? MyCell else {
            fatalError()
        }
        
        let viewModel = self.viewModel.cellViewModels[indexPath.row]
        
        switch viewModel.type {
           case .review(let review):
               guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: TitleCell.self), for: indexPath) as? TitleCell else {
                   fatalError("Failed to dequeue TitleCell")
               }
               cell.viewModel = review
               return cell
           }
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row == 0 {
            DispatchQueue.main.asyncAfter(deadline: .now()) { [weak self] in
                self?.navigationController?.pushViewController(ViewController2(), animated: true)
                //  let vs = ViewController2()
                //  self?.present(vs, animated: true)
            }
        }
    }
    
    
}
   
    
class MyCell: UITableViewCell {
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = .blue
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}
    


class TitleCell: UITableViewCell {
    var viewModel: TableViewModel.ViewModelType.AllRings? {
        didSet {
            updateUI()
        }
    }
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var titleLabel2: UILabel = {
        let label2 = UILabel()
        label2.textColor = .black
        label2.font = .systemFont(ofSize: 14)
        label2.numberOfLines = 0
        return label2
    }()
    
    private lazy var iconRingView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "iconRing")
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .clear
        return imageView
    }()
    
    private lazy var iconNext: UIImageView = {
        let imageNext = UIImageView()
        imageNext.image = UIImage(named: "next")
        imageNext.contentMode = .scaleAspectFill
        imageNext.backgroundColor = .clear
        return imageNext
        
    }()
    
  
   
   
    
    private func updateUI () {
        titleLabel.text = viewModel?.info
        iconRingView.image = viewModel?.icon
        iconNext.image = viewModel?.next
        titleLabel2.text = viewModel?.info2
    }
    
    private func setupUI () {
        contentView.addSubview(titleLabel)
        contentView.addSubview(iconRingView)
        contentView.addSubview(iconNext)
        contentView.addSubview(titleLabel2)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel2.translatesAutoresizingMaskIntoConstraints = false
        iconRingView.translatesAutoresizingMaskIntoConstraints = false
        iconNext.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            titleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 90),
            titleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -50),
            
            titleLabel2.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 1),
            titleLabel2.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 90),
            titleLabel2.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -50),
            
            iconRingView.topAnchor.constraint(equalTo: contentView.topAnchor),
            iconRingView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            
         
            iconNext.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 30),
            iconNext.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -1)
            
            
            
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


        
struct TableViewModel {
    enum ViewModelType {
        struct AllRings {
            let icon: UIImage
            let info: String
            let info2: String
            let next: UIImage
        }
        
        case review(AllRings)
        
    }
    var type: ViewModelType
}




   
