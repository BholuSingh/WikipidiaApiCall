//
//  GenericUtility.swift
//  Service Genie
//
//  Created by Rajan Singh on 09/09/18.
//  Copyright © 2018 Rajan Singh. All rights reserved.
//

import UIKit

class GenericUtility: NSObject {
    
    /***************************** Generic Utility ********************************/
    
    /// Int for Object
    ///
    /// - Parameter object: Any Object
    /// - Returns: Int Value
    class func intForObj(object: Any?) -> Int {
        
        switch object {
            
        case is Int, is Int8, is Int16, is Int32, is Int64:
            
            return object as! Int
            
        case is String:
            
            if (object as! String) == "" {
                return 0
            }
            return Int(object as! String)!
            
        default:
            
            return 0
        }
    }
    
    
    /// Int for Object 32 bit
    ///
    /// - Parameter object: Any Object
    /// - Returns: Int Value
    class func intForObj32(object: Any?) -> Int32 {
        
        switch object {
            
        case is Int, is Int8, is Int16, is Int32, is Int64:
            
            return object as! Int32
            
        case is String:
            
            if (object as! String) == "" {
                return 0
            }
            return Int32(object as! String)!
            
        default:
            
            return 0
        }
    }
    
    /// Float for Object
    ///
    /// - Parameter object: Any Object
    /// - Returns: Float Value
    class func floatForObj(object: Any?) -> Float {
        
        switch object {
            
        case is Float, is Int:
            
            return object as! Float
            
        case is String:
            
            if (object as! String) == "" {
                return 0.0
            }
            return Float(object as! String)!
            
        default:
            return 0.0
        }
    }
    
    /// String for Object
    ///
    /// - Parameter object: Any Object
    /// - Returns: String
    class func strForObj(object: Any?) -> String {
        
        switch object {
            
        case is String: // String
            
            switch object as! String {
                
            case "(null)", "(Null)", "<null>", "<Null>":
                
                return ""
                
            default:
                
                return object as! String
            }
            
        case is Int, is Float, is Double:
            
            return String(format:"%@",object as! CVarArg)
            
        default:
            
            return ""
        }
    }
    /// Dictionary for Object
    ///
    /// - Parameter object: Any Object
    /// - Returns: [String: AnyObject]
    class func dictionaryForObj(object: Any?) -> [String: AnyObject] {
        
        switch object {
            
        case is [String: AnyObject]: // Dictionary of Type [String: AnyObject]
            
            return object as! [String : AnyObject]
            
        case is [String: Any]: // Dictionary of Type [String: Any]
            
            return object as! [String : AnyObject]
            
        default:
            
            return [:]
        }
    }
    
    /// Array for Object
    ///
    /// - Parameter object: Any Object
    /// - Returns: [AnyObject]
    class func arrayForObj(object: Any?) -> [AnyObject] {
        
        switch object {
            
        case is [AnyObject]: // Array of Type [AnyObject]
            
            return object as! [AnyObject]
            
        case is [Any]: // Array of Type [Any]
            
            return object as! [AnyObject]
            
        default:
            
            return []
        }
    }
 
    class func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }

}
