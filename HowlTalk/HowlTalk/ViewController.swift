//
//  ViewController.swift
//  HowlTalk
//
//  Created by 차수연 on 17/08/2019.
//  Copyright © 2019 차수연. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  var box: UIImageView = {
    let imageView = UIImageView()
    imageView.image = #imageLiteral(resourceName: "icons8-talk-64")
    return imageView
  }()
  
  

  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.view.addSubview(box)
    box.snp.makeConstraints { (make) in
      make.center.equalTo(self.view)
    }
    
    
  }


}

