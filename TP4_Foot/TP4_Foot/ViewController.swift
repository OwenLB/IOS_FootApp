//
//  ViewController.swift
//  TP4_Foot
//
//  Created by Owen LE BEC on 14/04/2022.
//
import UIKit
import CoreLocation

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var donnees_json:[String:Any] = [:]
    
    var myTableView: UITableView = UITableView()
    var myArray: [[String:Any]]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        let path = Bundle.main.path(forResource: "ressources/scb_resultats", ofType: "json")
        let data:NSData = try! NSData(contentsOfFile: path!)
        
        do {
            donnees_json = try JSONSerialization.jsonObject(with: data
        as Data, options: .allowFragments) as! [String:AnyObject]
        } catch let error as NSError {
            print(error)
        }
                
        guard let resultats = donnees_json["resultats"] as? [[String:Any]] else {
            print("error guard resultats")
            return
        }
        
        myArray = resultats
        
        myTableView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        self.view.addSubview(myTableView)
        myTableView.dataSource = self
        myTableView.delegate = self
        myTableView.register(TableCell.self, forCellReuseIdentifier: "cell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myArray!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell : TableCell = tableView.dequeueReusableCell(withIdentifier: "cell") as! TableCell

        if self.myArray!.count > 0 {
            cell.setData(myArray: self.myArray!, indexPath: indexPath)
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        return 50.0
    }
    
}

class TableCell: UITableViewCell {
    
    var domDate: UILabel?
    var domLogo: UIImageView?
    var domLabel: UILabel?
    var scoreLabel: UILabel?
    var extLabel: UILabel?
    var extLogo: UIImageView?


    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.domDate = UILabel(frame: CGRect(x: 10, y: 0, width: 390, height: 20))
        self.domDate!.textAlignment = .left
        self.domDate!.textColor = .gray
        self.domDate!.font = UIFont.systemFont(ofSize: 15)
        
        self.domLogo = UIImageView(frame: CGRect(x: 10, y: 15, width: 40, height: 40))
        self.domLogo?.contentMode = .scaleAspectFit
        
        self.domLabel = UILabel(frame: CGRect(x: 50, y: 15, width: 100, height: 40))
        self.domLabel!.textAlignment = .left
        
        self.scoreLabel = UILabel(frame: CGRect(x: 130, y: 15, width: 130, height: 40))
        self.scoreLabel!.textAlignment = .center
        self.scoreLabel!.font = UIFont.boldSystemFont(ofSize: 16.0)
        
        self.extLabel = UILabel(frame: CGRect(x: 240, y: 15, width: 100, height: 40))
        self.extLabel!.textAlignment = .right
        
        self.extLogo = UIImageView(frame: CGRect(x: 340, y: 15, width: 40, height: 44))
        self.extLogo?.contentMode = .scaleAspectFit
        
        addSubview(domDate!)
        addSubview(domLogo!)
        addSubview(domLabel!)
        addSubview(scoreLabel!)
        addSubview(extLabel!)
        addSubview(extLogo!)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(myArray: [[String:Any]], indexPath: IndexPath) {
        
        self.domDate!.text = myArray[indexPath.row]["date"] as? String

        self.domLabel!.text = myArray[indexPath.row]["dom_name"] as? String
        
        
        if (myArray[indexPath.row]["score"] as! String == "") {
            self.scoreLabel!.text = "-"
        } else {
            self.scoreLabel!.text = myArray[indexPath.row]["score"] as? String
        }
        
       
        self.extLabel!.text = myArray[indexPath.row]["ext_name"] as? String
        
        self.domLogo!.image = UIImage(named:  myArray[indexPath.row]["dom_logo_name"]! as! String)
        
        self.extLogo!.image = UIImage(named:  myArray[indexPath.row]["ext_logo_name"]! as! String)

    }
}
