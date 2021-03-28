//
//  MainPresenter.swift
//  CleanSwiftShop
//
//  Created by Nicklas on 28/03/2021.
//

import Foundation

protocol MainView: AnyObject {
}

protocol MainViewDelegate {
}

class MainPresenter: MainViewDelegate {
    
    weak var view: MainView!
    
    init(view: MainView) {
        self.view = view
    }
}
