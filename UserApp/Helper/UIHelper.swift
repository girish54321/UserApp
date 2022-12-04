//
//  UIHelper.swift
//  UserApp
//
//  Created by Girish Parate on 01/10/22.
//

import Foundation
import UIKit

struct Alert {
    func showBootmSheet(title: String, message: String,vc: UIViewController,actionsList: [UIAlertAction]){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        for actions in actionsList {
            alertController.addAction(actions)
        }
        
        let cancelButton = makeUIAlertButton(title: "Cancel", style: UIAlertAction.Style.destructive, actionFunction: {
            print("Cancel taped")
        })
        
        alertController.addAction(cancelButton)
        DispatchQueue.main.async { vc.present(alertController, animated: true) }
    }
    
    func showNormlaAleat(title: String, message: String,vc: UIViewController,actionsList: [UIAlertAction]){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        for actions in actionsList {
            alertController.addAction(actions)
        }
        DispatchQueue.main.async { vc.present(alertController, animated: true) }
    }
    
    func makeUIAlertButton(title: String, style:UIAlertAction.Style ,actionFunction: @escaping () -> Void) -> UIAlertAction {
        let actionButton = UIAlertAction(title: title, style: style, handler: {(action: UIAlertAction!) in actionFunction()})
        return actionButton
    }
}

struct Helper {
    
    func createQueryParams(baseUrl: String,queryItems: [URLQueryItem]) -> URL {
        var urlComps = URLComponents(string:baseUrl)
        urlComps?.queryItems = queryItems
        return (urlComps?.url!)!
    }
}

extension URL {
    func valueOf(_ queryParameterName: String) -> String? {
        guard let url = URLComponents(string: self.absoluteString) else { return nil }
        return url.queryItems?.first(where: { $0.name == queryParameterName })?.value
    }
}

extension UIScreen {
    static let screenWidth = UIScreen.main.bounds.size.width
    static let screenHeight = UIScreen.main.bounds.size.height
    static let screenSize = UIScreen.main.bounds.size
}


class ProgressHUD: UIVisualEffectView {

  var text: String? {
    didSet {
      label.text = text
    }
  }

    let activityIndictor: UIActivityIndicatorView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.gray)
  let label: UILabel = UILabel()
  let blurEffect = UIBlurEffect(style: .light)
  let vibrancyView: UIVisualEffectView

  init(text: String) {
    self.text = text
    self.vibrancyView = UIVisualEffectView(effect: UIVibrancyEffect(blurEffect: blurEffect))
    super.init(effect: blurEffect)
    self.setup()
  }

  required init?(coder aDecoder: NSCoder) {
    self.text = ""
    self.vibrancyView = UIVisualEffectView(effect: UIVibrancyEffect(blurEffect: blurEffect))
    super.init(coder: aDecoder)
    self.setup()
  }

  func setup() {
    contentView.addSubview(vibrancyView)
    contentView.addSubview(activityIndictor)
    contentView.addSubview(label)
    activityIndictor.startAnimating()
  }

  override func didMoveToSuperview() {
    super.didMoveToSuperview()

    if let superview = self.superview {

      let width = superview.frame.size.width / 2.3
      let height: CGFloat = 50.0
      self.frame = CGRect(x: superview.frame.size.width / 2 - width / 2,
                      y: superview.frame.height / 2 - height / 2,
                      width: width,
                      height: height)
      vibrancyView.frame = self.bounds

      let activityIndicatorSize: CGFloat = 40
      activityIndictor.frame = CGRect(x: 5,
                                      y: height / 2 - activityIndicatorSize / 2,
                                      width: activityIndicatorSize,
                                      height: activityIndicatorSize)

      layer.cornerRadius = 8.0
      layer.masksToBounds = true
      label.text = text
      label.textAlignment = NSTextAlignment.center
      label.frame = CGRect(x: activityIndicatorSize + 5,
                           y: 0,
                           width: width - activityIndicatorSize - 15,
                           height: height)
      label.textColor = UIColor.gray
      label.font = UIFont.boldSystemFont(ofSize: 16)
    }
  }

  func show() {
    self.isHidden = false
  }

  func hide() {
    self.isHidden = true
  }
}
