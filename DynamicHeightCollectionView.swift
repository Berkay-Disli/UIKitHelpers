import UIKit

// Changes will be here
class ViewController: UIViewController {
    private let mainCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = UICollectionViewFlowLayout.automaticSize
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 12, left: 0, bottom: 24, right: 0)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(PostCollectionViewCell.self, forCellWithReuseIdentifier: PostCollectionViewCell.reuseIdentifier)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        
    }
  
    private func configureCollectionView() {
        mainCollectionView.delegate = self
        mainCollectionView.dataSource = self
        
        mainCollectionView.showsVerticalScrollIndicator = false
        
        view.addSubview(mainCollectionView)
        mainCollectionView.frame = view.bounds
    }
}


extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItems()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PostCollectionViewCell.reuseIdentifier, for: indexPath) as? PostCollectionViewCell else { return UICollectionViewCell() }
        
        if let content = viewModel.postWithUsers(at: indexPath.row) {
            cell.configure(with: content)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            if let content = viewModel.postWithUsers(at: indexPath.row) {
                // Calculate the dynamic height based on your content
                let userFirstNameHeight = heightForLabel(text: content.1.name, font: UIFont.systemFont(ofSize: 13, weight: .bold))
                let titleHeight = heightForLabel(text: content.0.title, font: UIFont.systemFont(ofSize: 16, weight: .bold))
                let bodyHeight = heightForLabel(text: content.0.body, font: UIFont.systemFont(ofSize: 14))

                // Add additional space for padding, borders, etc., if needed
                let totalHeight = userFirstNameHeight + titleHeight + bodyHeight + /*additional space*/ 32

                return CGSize(width: UIScreen.main.bounds.width, height: totalHeight)
            }

            // Return a default size if there's an issue with the data
            return CGSize(width: UIScreen.main.bounds.width, height: 400)
        }

        // Helper method to calculate the height of a label based on its text and font
        private func heightForLabel(text: String, font: UIFont) -> CGFloat {
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - 32, height: CGFloat.greatestFiniteMagnitude))
            label.numberOfLines = 0
            label.lineBreakMode = .byWordWrapping
            label.font = font
            label.text = text
            label.sizeToFit()
            return label.frame.height
        }
}

// The cell is like this
class PostCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "PostCollectionViewCell"

    let userFirstNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        label.numberOfLines = 1
        return label
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.numberOfLines = 0
        label.layer.borderColor = UIColor.systemRed.cgColor
        label.layer.borderWidth = 2
        return label
    }()

    let bodyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.layer.borderColor = UIColor.cyan.cgColor
        label.layer.borderWidth = 2
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }

    private func setupUI() {
        // Add and customize your UI elements here
        contentView.addSubview(titleLabel)
        contentView.addSubview(bodyLabel)
        contentView.addSubview(userFirstNameLabel)
        
        // Layout constraints (customize as needed)
        NSLayoutConstraint.activate([
            userFirstNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            userFirstNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            
            titleLabel.topAnchor.constraint(equalTo: userFirstNameLabel.bottomAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            bodyLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            bodyLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            bodyLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            bodyLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -8)
        ])
    }
    
    func configure(with content: (PostModel, UserModel)) {
        userFirstNameLabel.text = content.1.name
        titleLabel.text = content.0.title
        bodyLabel.text = content.0.body
    }
}
