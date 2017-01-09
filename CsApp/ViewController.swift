//
//  ViewController.swift
//  CsApp
//
//  Created by William Gossard on 05/01/2017.
//  Copyright © 2017 William Gossard. All rights reserved.
//

import UIKit
import SWXMLHash


class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    var feed: Feed? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadImageFrom(urlString: (feed?.link)!)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    func loadImageFrom(urlString:String)
    {
        let urlEncoded: String = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let imgURL: NSURL = NSURL(string: urlEncoded)!
        let request: NSURLRequest = NSURLRequest(url: imgURL as URL)
        
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest){
            (data, response, error) -> Void in
            
            if (error == nil && data != nil)
            {
                func display_image()
                {
                    self.imageView.image = UIImage(data: data!)
                }
                
                DispatchQueue.main.async {
                    display_image()
                }
            }
            
        }
        
        task.resume()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

