//
//  CommitListTableViewController.swift
//  CsApp
//
//  Created by William Gossard on 09/01/2017.
//  Copyright © 2017 William Gossard. All rights reserved.
//

import UIKit

class CommitListTableViewController: UITableViewController {
    
    var feeds: [Feed] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        feeds = FeedManager.shared.feeds
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.barTintColor = UIColor(red:0.17, green:0.25, blue:0.42, alpha:1.0)
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func creditAction(_ sender: Any) {
        let alertController = UIAlertController(title: "Credits", message:
            "All credits goes to commitstrip.com !", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .default,handler: nil))
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feeds.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommitCell", for: indexPath) as! CommitCellTableViewCell
 
        cell.titleField.text = feeds[indexPath.row].title
        loadImageFrom(urlString: feeds[indexPath.row].link, indexPath: indexPath)

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }


    func loadImageFrom(urlString:String, indexPath: IndexPath)
    {
        let urlEncoded: String = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let imgURL: NSURL = NSURL(string: urlEncoded)!
        let request: NSURLRequest = NSURLRequest(url: imgURL as URL)
        
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest){
            (data, response, error) -> Void in
            
            if (error == nil && data != nil)
            {
                DispatchQueue.main.async {
                    let updateCell: CommitCellTableViewCell = self.tableView.cellForRow(at: indexPath) as! CommitCellTableViewCell
                    updateCell.bgImageView.image = UIImage(data: data!)
                }
            }
            
        }
        
        task.resume()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "displayCs", sender: self)
    }
    


    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "displayCs" {
            let vc = segue.destination as! ViewController
            let indexPath = self.tableView.indexPathForSelectedRow!
            
            vc.feed = feeds[indexPath.row]
        }
    }

}
