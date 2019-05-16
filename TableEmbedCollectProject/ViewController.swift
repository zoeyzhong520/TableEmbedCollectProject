//
//  ViewController.swift
//  TableEmbedCollectProject
//
//  Created by zhifu360 on 2019/5/16.
//  Copyright © 2019 ZZJ. All rights reserved.
//

import UIKit

class ViewController: BaseViewController {

    ///数据源
    var dataArray = ["1","2","3","4","5","6"]
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: ScreenSize.width, height: ContentHeight), style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: BaseTableReuseIdentifier)
        tableView.register(SinglePhotoCell.self, forCellReuseIdentifier: String(describing: SinglePhotoCell.self))
        tableView.register(EmbedCollectionCell.self, forCellReuseIdentifier: String(describing: EmbedCollectionCell.self))
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setPage()
    }

    func setPage() {
        title = "演示"
        view.addSubview(tableView)
    }

}


extension ViewController: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            //一张图片Cell
            let cell:SinglePhotoCell = SinglePhotoCell.createCellWith(tableView: tableView, indexPath: indexPath)
            cell.backImgView.image = UIImage(named: "\(dataArray.first!).jpg")
            return cell
        } else if indexPath.row == 1 {
            //带有UICollectionView的Cell
            ///数据源
            let dataArray = ["1","2","3","4","5","6"]
            let cell:EmbedCollectionCell = EmbedCollectionCell.createCellWith(tableView: tableView, indexPath: indexPath, dataArr: dataArray)
            cell.delegate = self
            return cell
        } else {
            //默认Cell
            let cell = tableView.dequeueReusableCell(withIdentifier: BaseTableReuseIdentifier, for: indexPath)
            cell.textLabel?.text = "第\(indexPath.row)行"
            cell.textLabel?.font = UIFont.systemFont(ofSize: 16)
            cell.textLabel?.textColor = UIColor.black
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return ScreenSize.width
        } else if indexPath.row == 1 {
            return 100
        } else {
            return 44
        }
    }
    
}

extension ViewController: EmbedCollectionCellDelegate {
    
    func selectItemWith(newImage: String) {
        //修改数据源
        dataArray.removeFirst()
        dataArray.insert(newImage, at: 0)
        //刷新指定行
        tableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .fade)
    }
    
}
