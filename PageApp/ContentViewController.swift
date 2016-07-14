//
//  ContentViewController.swift
//  PageApp
//
//  Created by JHJG on 2016. 7. 13..
//  Copyright © 2016년 KangJungu. All rights reserved.
//

import UIKit

class ContentViewController: UIViewController {

    var dataObject:AnyObject?
    @IBOutlet var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    //뷰가 나타나기 직전에 호출
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        //dataObject속성을 웹뷰 오브젝트에 표시될 html로 설정하고 
        //html이 웹뷰에 할당되도록 함
        webView.loadHTMLString(dataObject as! String, baseURL: NSURL(string:""))
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
