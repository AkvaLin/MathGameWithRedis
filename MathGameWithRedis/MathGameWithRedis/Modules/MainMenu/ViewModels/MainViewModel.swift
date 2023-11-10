//
//  MainViewModel.swift
//  MathGameWithRedis
//
//  Created by Никита Пивоваров on 24.10.2023.
//

import Foundation

class MainViewModel: ObservableObject {    
    public func onLaunch() {
        
        if UserDefaults.standard.value(forKey: "username") == nil {
            UserDefaults.standard.setValue("User-\(UUID().uuidString.components(separatedBy: "-")[0])", forKey: "username")
        }
    }
}
