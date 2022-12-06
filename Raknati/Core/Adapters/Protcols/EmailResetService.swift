//
//  EmailResetService.swift
//  Raknati
//
//  Created by Shady K. Maadawy on 28/11/2022.
//

import Foundation

protocol EmailResetService: AnyObject {
    func requestResetPassword(_ emailAddress: String!, handler: @escaping(Result<Bool, Error>) -> ())
}

