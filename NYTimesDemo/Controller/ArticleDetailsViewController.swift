//
//  ArticleDetailsViewController.swift
//  CollectionViewDataSourceBlog
//
//  Created by Jhanvi on 24/07/18.
//

import UIKit
import SDWebImage

class ArticleDetailsViewController: UIViewController {

    @IBOutlet weak var articleImageView: UIImageView!
    @IBOutlet weak var publishedDateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var AuthorLabel: UILabel!
    
    var article: Article?

    @IBAction func onReadArticleClick(_ sender: Any) {
        guard let url = URL(string: (self.article?.webUrl)!) else {
            return //be safe
        }
        //Open the article in native browser
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
    
    override func viewDidLoad() {
        // Setup XCUITest Accessibility Labels
        headerLabel.accessibilityIdentifier = "label--articleTitleLabel"
        publishedDateLabel.accessibilityIdentifier = "label--articleDateLabel"
        descriptionLabel.accessibilityIdentifier = "label--articleDescriptionLabel"
        AuthorLabel.accessibilityIdentifier = "button--articleAuthorLabel"
        articleImageView.accessibilityIdentifier = "button--articleImageView"

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //Load data to display
        displayArticlesDetails()
    }

    func displayArticlesDetails() {
        // just in case we don't have a article due to some error, empty out the contents
        self.descriptionLabel?.text = ""
        self.headerLabel?.text = ""
        self.AuthorLabel?.text = ""
        self.publishedDateLabel?.text = ""
        self.articleImageView?.image = UIImage(named: "placeholder.png")
        
        if self.article == nil {
            return
        }
        
        var descriptionText = ""
        var headerText = ""
        var authorText = ""
        var publishDate = ""

        self.title = "Article Details" // set the title for the navigation bar

        if let header = self.article?.header {
            headerText = header
        }

        if let description = self.article?.description {
            descriptionText = description
        }
        
        if let dateStr = self.article?.publishDate {
            publishDate = "Published on \(dateStr)."
        }
        
        if let autherStr = self.article?.author {
            authorText = autherStr
        }
        
        if let normailImageURL = self.article?.detailImageURL {
            self.articleImageView?.sd_setImage(with: normailImageURL, placeholderImage: UIImage(named: "placeholder.png"))
        }

        self.headerLabel?.text = headerText
        self.descriptionLabel?.text = descriptionText
        self.publishedDateLabel?.text = publishDate
        self.AuthorLabel?.text = authorText
        
        self.descriptionLabel?.sizeToFit() // to top-align text
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
