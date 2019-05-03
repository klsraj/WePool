//
//  ProfileSettingsView.swift
//  WePool
//
//  Created by Raj Kadiyala on 5/2/19.
//  Copyright © 2019 WePool. All rights reserved.
//

import UIKit

class ProfileSettingsView : UIView{
    
    let settingsTableView : UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.backgroundColor = UIColor.groupTableViewBackground
        table.tableFooterView = UIView()
        return table
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.white
        setupTableView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupTableView(){
        addSubview(settingsTableView)
        
        settingsTableView.translatesAutoresizingMaskIntoConstraints = false
        settingsTableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        settingsTableView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        settingsTableView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        settingsTableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    
}
