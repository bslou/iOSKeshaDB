//
//  KeshaDB.swift
//  Kesha Database
//
//  Created by Benjamin Sloutsky on 2/13/21.
//
 
import Foundation
 
public class KeshaDB{
    public var data = Dictionary<String, Any>()
    var name = ""
    public var vals = [String]()
    public func store(arr: NSArray, name: String){
        self.name = name
        self.vals = arr as! [String]
        for i in 0...arr.count-1{
            data[arr[i] as! String] = [""]
        }
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
            let JSONString = String(data: jsonData, encoding: String.Encoding.utf8)
            let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
            let fileURL = dir!.appendingPathComponent("\(self.name)")
            do {
                print("what is \(String(describing: JSONString))")
                try JSONString?.write(to: fileURL, atomically: true, encoding: String.Encoding.utf8)
            }
            catch let err {print(err.localizedDescription)}
            
        } catch {
            print(error.localizedDescription)
        }
        
    }
    public func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    public func access(name: String){
        self.name = name
        //set vals to something
        
        let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        let fileURL = dir!.appendingPathComponent("\(self.name)")
        var text2 : String = ""
        do {
            text2 = try String(contentsOf: fileURL, encoding: .utf8)
        }catch let err{
            print("errTwo \(err.localizedDescription)")
        }
        print("dict = \(String(describing: convertToDictionary(text: text2)))")
        data = convertToDictionary(text: text2)!
        self.vals = Array(data.keys)
    }
    public func add(arr: NSArray){
        let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        let fileURL = dir!.appendingPathComponent("\(self.name)")
        for i in stride(from: 0, to: arr.count, by: 1){
            var art = data[vals[i]] as! Array<String>
            art.append(arr[i] as! String)
            data[vals[i]] = art
        }
        do {
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
                let JSONString = String(data: jsonData, encoding: String.Encoding.utf8)
                print("String = \(String(describing: JSONString))")
                try JSONString?.write(to: fileURL, atomically: true, encoding: String.Encoding.utf8)
            } catch {
                print(error.localizedDescription)
            }
            
        }
        catch let err {print(err.localizedDescription)}
    }
    public func findColumn(at: Int) -> NSArray{
        let o: NSMutableArray = []
        
        for i in 0...vals.count-1{
            o.add((data[vals[i]] as! NSArray)[at] as! String)
        }
        
        return o
    }
    public func findRow(at: Int) -> NSArray{
        return data[vals[at]] as! NSArray
    }
    public func findRow(at: String) -> NSArray{
        return data[at] as! NSArray
    }
    public func findAt(row: Int, column: Int) -> String{
        return (data[vals[row]] as! NSArray)[column] as! String
    }
    public func DBCount() -> Int{
        return vals.count
    }
    public func removeRow(row: Int){
        data.removeValue(forKey: vals[row])
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
            let JSONString = String(data: jsonData, encoding: String.Encoding.utf8)
            let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
            let fileURL = dir!.appendingPathComponent("\(self.name)")
            do {
                print("what is \(String(describing: JSONString))")
                try JSONString?.write(to: fileURL, atomically: true, encoding: String.Encoding.utf8)
            }
            catch let err {print(err.localizedDescription)}
            
        } catch {
            print(error.localizedDescription)
        }
    }
    public func removeRow(row: String){
        data.removeValue(forKey: row)
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
            let JSONString = String(data: jsonData, encoding: String.Encoding.utf8)
            let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
            let fileURL = dir!.appendingPathComponent("\(self.name)")
            do {
                print("what is \(String(describing: JSONString))")
                try JSONString?.write(to: fileURL, atomically: true, encoding: String.Encoding.utf8)
            }
            catch let err {print(err.localizedDescription)}
            
        } catch {
            print(error.localizedDescription)
        }
    }
    public func addRow(key: String, arr: NSMutableArray){
        vals.append(key)
        arr.insert("", at: 0)
        data[key] = arr
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
            let JSONString = String(data: jsonData, encoding: String.Encoding.utf8)
            let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
            let fileURL = dir!.appendingPathComponent("\(self.name)")
            do {
                print("what is \(String(describing: JSONString))")
                try JSONString?.write(to: fileURL, atomically: true, encoding: String.Encoding.utf8)
            }
            catch let err {print(err.localizedDescription)}
            
        } catch {
            print(error.localizedDescription)
        }
    }
    public func printDBRes() -> String{
        let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        do {
            let text2 = try String(contentsOf: dir!.appendingPathComponent("\(self.name)"), encoding: .utf8)
            return text2
        }
        catch let err {return err.localizedDescription}
    }
    public func update(){
        let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        let fileURL = dir!.appendingPathComponent("\(self.name)")
        do {
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
                let JSONString = String(data: jsonData, encoding: String.Encoding.utf8)
                print("String = \(String(describing: JSONString))")
                try JSONString?.write(to: fileURL, atomically: true, encoding: String.Encoding.utf8)
            } catch {
                print(error.localizedDescription)
            }
            
        }
        catch let err {print(err.localizedDescription)}
    }
    public func exists(at: String) -> Bool{
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
            let url = NSURL(fileURLWithPath: path)
            if let pathComponent = url.appendingPathComponent("\(name)") {
                let filePath = pathComponent.path
                let fileManager = FileManager.default
                if fileManager.fileExists(atPath: filePath) {
                    print("FILE AVAILABLE")
                    return true
                } else {
                    print("FILE NOT AVAILABLE")
                    return false
                }
            } else {
                print("FILE PATH NOT AVAILABLE")
                return false
            }
    }
    public func getValues() -> [String]{
        return vals
    }
    public init() {}
}

