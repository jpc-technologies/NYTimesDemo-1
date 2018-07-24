//
//  ViewController.swift
//
//  Created by Jhanvi on 24/07/18.
//  Copyright © 2018 Jhanvi. All rights reserved.
//

import UIKit
import SDWebImage

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var processLabel: UILabel!

    let store = DataStore.sharedInstance
    let cellReuseIdentifier = "articleCellID"

    override func viewDidLoad() {
        super.viewDidLoad()
        //Cofigure navigation header
        navigationItem.titleView = UIImageView(image: UIImage(named: "header"))
        
        tableView.accessibilityIdentifier = "table--articleTableView"
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView.init()
        self.processLabel.isHidden = false
        self.view.bringSubview(toFront: self.processLabel)
        
        //Make an API call and fetch data
        store.getPopularArticles {
            self.processLabel.isHidden = true
            self.tableView.reloadData()
        }
    }
    
    //MARK: UITABLEVIEW DATASOURCE METHODS
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return store.articles.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 144.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath)
            as! ArticleCell
        
        //Configure cell
        let article = store.articles[indexPath.row]
        
        cell.headerLabel?.text = article.header
        cell.descriptionLabel?.text = article.description
        cell.authorLabel?.text = article.author
        cell.dataLabel?.text = article.publishDate
        cell.articleImage?.sd_setImage(with: article.tumbnailUrl, placeholderImage: UIImage(named: "placeholder.png"))
        cell.articleImage.layer.cornerRadius = cell.articleImage.frame.size.width / 2
        cell.articleImage.clipsToBounds = true
        return cell
    }

    //MARK: UITABLEVIEW DELEGATE METHODS
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated:true)

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        //Load article details view and pass the article data to display
        if let articleDetailVC = segue.destination as? ArticleDetailsViewController {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                articleDetailVC.article = store.articles[indexPath.row]
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

