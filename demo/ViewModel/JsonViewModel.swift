//
//  JsonViewModel.swift
//  demo
//
//  Created by Krishna on 13/10/20.
//  Copyright © 2020 Saksha. All rights reserved.
//

import UIKit

class JsonViewModel {
    
    init(model: [JsonModel]? = nil) {
        if let inputModel = model {
            rowsArr = inputModel
        }
    }
    var rowsArr = [JsonModel]()

}

extension JsonViewModel {
    func fetchData(completion: @escaping (Result<[JsonModel], Error>) -> Void)
    {
        HTTPManager.shared.get(urlString: kFetchData, completionBlock: { [weak self] result in
            guard let self = self else {return}
            switch result {
            case .failure(let error):
                print ("failure", error)
            case .success(let dta) :
                                
                let decoder = JSONDecoder()
                do
                {
                    self.rowsArr = try decoder.decode([JsonModel].self, from: dta)
                    completion(.success(try decoder.decode([JsonModel].self, from: dta)))
                } catch {
                    // deal with error from JSON decoding if used in production
                    print(error.localizedDescription)
                }
                
                
            }
        })
    }
}
