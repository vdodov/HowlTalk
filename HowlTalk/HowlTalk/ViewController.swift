//
//  ViewController.swift
//  HowlTalk
//
//  Created by 차수연 on 17/08/2019.
//  Copyright © 2019 차수연. All rights reserved.
//

import UIKit
import Firebase
import SnapKit

class ViewController: UIViewController {
  
  var box: UIImageView = {
    let imageView = UIImageView()
    imageView.image = #imageLiteral(resourceName: "icons8-talk-64")
    return imageView
  }()
  
  var remoteConfig : RemoteConfig!
  
  

  override func viewDidLoad() {
    super.viewDidLoad()
    
    remoteConfig = RemoteConfig.remoteConfig()
    let settings = RemoteConfigSettings()
//    settings.minimumFetchInterval = 0
    remoteConfig.configSettings = settings
    remoteConfig.setDefaults(fromPlist: "RemoteConfigDefaults")

    //TimeInterval(0) -> 앱을 실행 시킬때마다 요청됨
    remoteConfig.fetch(withExpirationDuration: TimeInterval(0)) { (status, error) -> Void in
      if status == .success {
        print("Config fetched!")
        self.remoteConfig.activateFetched()
      } else {
        print("Config not fetched")
        print("Error: \(error?.localizedDescription ?? "No error available.")")
      }
      self.displayWelcome()
    }

    

    
    
    
    self.view.addSubview(box)
    box.snp.makeConstraints { (make) in
      make.center.equalTo(self.view)
    }
    //배경색 검은색으로
    //self.view.backgroundColor = UIColor(hex: "#000000")
    
    
  }
  
  func displayWelcome() {
    let color = remoteConfig["splash_background"].stringValue
    let caps = remoteConfig["splash_message_caps"].boolValue
    let message = remoteConfig["splash_message"].stringValue
    print("[Log]:", color, caps, message)
    
    //서버의 caps가 true이면, alert 띄우고 종료
    if(caps) {
      let alert = UIAlertController(title: "공지사항", message: message, preferredStyle: .alert)
      let okAction = UIAlertAction(title: "확인", style: .default) { (action) in
        exit(0)
      }
      alert.addAction(okAction)
      self.present(alert, animated: true, completion: nil)
    }
    self.view.backgroundColor = UIColor(hex: color!)
  }
  


}

//16진수 컬러코드
extension UIColor {
  convenience init(hex: String) {
    let scanner = Scanner(string: hex)
    
    //1로 주는 이유는 #aabbcc일때 -> #을 제외하고 a부터 읽기 위함
    scanner.scanLocation = 1
    
    var rgbValue: UInt64 = 0
    
    scanner.scanHexInt64(&rgbValue)
    
    let r = (rgbValue & 0xff0000) >> 16
    let g = (rgbValue & 0xff00) >> 8
    let b = rgbValue & 0xff
    
    self.init(
      red: CGFloat(r) / 0xff,
      green: CGFloat(g) / 0xff,
      blue: CGFloat(b) / 0xff, alpha: 1
    )
  }
}
