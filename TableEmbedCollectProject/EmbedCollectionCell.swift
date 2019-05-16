//
//  EmbedCollectionCell.swift
//  TableEmbedCollectProject
//
//  Created by zhifu360 on 2019/5/16.
//  Copyright © 2019 ZZJ. All rights reserved.
//

import UIKit

@objc protocol EmbedCollectionCellDelegate: NSObjectProtocol {
    @objc optional
    func selectItemWith(newImage: String)
}

class EmbedCollectionCell: UITableViewCell {

    weak var delegate: EmbedCollectionCellDelegate?
    
    ///数据源
    var dataArr = [String]()
    
    ///UICollectionView
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 80, height: 80)
        layout.minimumLineSpacing = 10
        layout.scrollDirection = UICollectionView.ScrollDirection.horizontal
        layout.sectionInset = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.clear
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.classForCoder(), forCellWithReuseIdentifier: String(describing: EmbedCollectionCell.self))
        return collectionView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func addViews() {
        contentView.addSubview(collectionView)
        //添加约束
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        let leftCollectionCon = NSLayoutConstraint(item: collectionView, attribute: .left, relatedBy: .equal, toItem: contentView, attribute: .left, multiplier: 1, constant: 0)
        let rightCollectionCon = NSLayoutConstraint(item: collectionView, attribute: .right, relatedBy: .equal, toItem: contentView, attribute: .right, multiplier: 1, constant: 0)
        let topCollectionCon = NSLayoutConstraint(item: collectionView, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .top, multiplier: 1, constant: 0)
        let bottomCollectionCon = NSLayoutConstraint(item: collectionView, attribute: .bottom, relatedBy: .equal, toItem: contentView, attribute: .bottom, multiplier: 1, constant: 0)
        collectionView.superview?.addConstraint(leftCollectionCon)
        collectionView.superview?.addConstraint(rightCollectionCon)
        collectionView.superview?.addConstraint(topCollectionCon)
        collectionView.superview?.addConstraint(bottomCollectionCon)
    }
    
    ///创建Cell
    class func createCellWith(tableView: UITableView, indexPath: IndexPath, dataArr: [String]) -> EmbedCollectionCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: String(describing: EmbedCollectionCell.self), for: indexPath) as? EmbedCollectionCell
        if cell == nil {
            cell = EmbedCollectionCell(style: .default, reuseIdentifier: String(describing: EmbedCollectionCell.self))
        }
        cell?.configWith(dataArr: dataArr)
        cell?.selectionStyle = .none
        return cell!
    }
    
    func configWith(dataArr: [String]) {
        self.dataArr = dataArr
        collectionView.reloadData()
    }
    
}

extension EmbedCollectionCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: EmbedCollectionCell.self), for: indexPath)
        //创建UIImageView
        let backImgView = UIImageView(image: UIImage(named: "\(dataArr[indexPath.row]).jpg"))
        backImgView.frame = cell.contentView.bounds
        backImgView.contentMode = .scaleAspectFill
        backImgView.clipsToBounds = true
        backImgView.layer.cornerRadius = 3
        cell.contentView.addSubview(backImgView)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if delegate != nil {
            delegate?.selectItemWith?(newImage: "\(dataArr[indexPath.row])")
        }
    }
    
}
