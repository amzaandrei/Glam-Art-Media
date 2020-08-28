//
//  UIViewExt.swift
//  Glam Art Media
//
//  Created by Andrew on 11/21/19.
//  Copyright © 2019 Andrew. All rights reserved.
//

import UIKit

extension UIView {

  var safeTopAnchor: NSLayoutYAxisAnchor {
    if #available(iOS 11.0, *) {
      return self.safeAreaLayoutGuide.topAnchor
    }
    return self.topAnchor
  }

  var safeLeftAnchor: NSLayoutXAxisAnchor {
    if #available(iOS 11.0, *){
      return self.safeAreaLayoutGuide.leftAnchor
    }
    return self.leftAnchor
  }

  var safeRightAnchor: NSLayoutXAxisAnchor {
    if #available(iOS 11.0, *){
      return self.safeAreaLayoutGuide.rightAnchor
    }
    return self.rightAnchor
  }

  var safeBottomAnchor: NSLayoutYAxisAnchor {
    if #available(iOS 11.0, *) {
      return self.safeAreaLayoutGuide.bottomAnchor
    }
    return self.bottomAnchor
  }
}


extension UIStackView {
    func addBackground(color: UIColor) {
        let subView = UIView(frame: bounds)
        subView.backgroundColor = color
        subView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        insertSubview(subView, at: 0)
    }
}

extension String {

    func fromBase64() -> String? {
        guard let data = Data(base64Encoded: self) else {
            return nil
        }

        return String(data: data, encoding: .utf8)
    }

    func toBase64() -> String {
        return Data(self.utf8).base64EncodedString()
    }
    
}

extension NSObject {
    
    typealias JSONStandard = [String: AnyObject]
    
    func verifyResponseData(data: Data) -> ([JSONStandard]?, Bool?, String?){
        var json: [JSONStandard]?
        var state: Bool?
        var err: String?
        do{
            json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [JSONStandard]
            state = true
        }catch let errCat{
            state = false
            err = errCat.localizedDescription
        }
        return (json, state, err)
    }
    
}

extension TaskController {
    
    func convertDataToTime(dateStr: String) -> [String: Int]?{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z"
        var comp = DateComponents()
        guard let date = dateFormatter.date(from: dateStr) else { return nil }
        comp.hour = Calendar.current.component(.hour, from: date)
        comp.minute = Calendar.current.component(.minute, from: date)
        comp.month = Calendar.current.component(.month, from: date)
        comp.day = Calendar.current.component(.day, from: date)
        
        let allTimes : [String: Any] = [
            "hour": comp.hour!,
            "minute": comp.minute!,
            "month": comp.month!,
            "day": comp.day!
        ]
        return allTimes as! [String : Int]
    }
    
    func findTheMonthStringFromInt(_ monthNr: Int) -> String{
        
        var val: String!
        
        switch (monthNr) {
            case 1: val = "Ianuarie"; break
            case 2: val = "Februarie"; break
            case 3: val = "Martie"; break
            case 4: val = "Aprilie"; break
            case 5: val = "Mai"; break
            case 6: val = "Iunie"; break
            case 7: val = "Iulie"; break
            case 8: val = "August"; break
            case 9: val = "Septembrie"; break
            case 10: val = "Octombrie"; break
            case 11: val = "Noiembrie"; break
            case 12: val = "Decembrie"; break
            default: break
        }
        return val
    }
    
}

extension DispatchQueue {

    static func background(delay: Double = 0.0, background: (()->Void)? = nil, completion: (() -> Void)? = nil) {
        DispatchQueue.global(qos: .background).async {
            background?()
            if let completion = completion {
                DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: {
                    completion()
                })
            }
        }
    }

}
