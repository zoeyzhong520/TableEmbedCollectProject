//
//  SinglePhotoCell.swift
//  TableEmbedCollectProject
//
//  Created by zhifu360 on 2019/5/16.
//  Copyright © 2019 ZZJ. All rights reserved.
//

import UIKit

class SinglePhotoCell: UITableViewCell {

    ///图片
    lazy var backImgView: UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = UIView.ContentMode.scaleAspectFill
        imgView.clipsToBounds = true
        return imgView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        adddViews()
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
    
    func adddViews() {
        contentView.addSubview(backImgView)
        //添加约束
        backImgView.translatesAutoresizingMaskIntoConstraints = false
        let leftBackImgCon = NSLayoutConstraint(item: backImgView, attribute: .left, relatedBy: .equal, toItem: contentView, attribute: .left, multiplier: 1, constant: 0)
        let rightBackImgCon = NSLayoutConstraint(item: backImgView, attribute: .right, relatedBy: .equal, toItem: contentView, attribute: .right, multiplier: 1, constant: 0)
        let topBackImgCon = NSLayoutConstraint(item: backImgView, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .top, multiplier: 1, constant: 0)
        let bottomBackImgCon = NSLayoutConstraint(item: backImgView, attribute: .bottom, relatedBy: .equal, toItem: contentView, attribute: .bottom, multiplier: 1, constant: 0)
        backImgView.superview?.addConstraint(leftBackImgCon)
        backImgView.superview?.addConstraint(rightBackImgCon)
        backImgView.superview?.addConstraint(topBackImgCon)
        backImgView.superview?.addConstraint(bottomBackImgCon)
        
    }
    
    ///创建Cell
    class func createCellWith(tableView: UITableView, indexPath: IndexPath) -> SinglePhotoCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: String(describing: SinglePhotoCell.self), for: indexPath) as? SinglePhotoCell
        if cell == nil {
            cell = SinglePhotoCell(style: .default, reuseIdentifier: String(describing: SinglePhotoCell.self))
        }
        cell?.selectionStyle = .none
        return cell!
    }
    
}
