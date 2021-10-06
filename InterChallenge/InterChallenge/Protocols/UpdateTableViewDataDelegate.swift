//
//  UpdateTableViewDataDelegate.swift
//  InterChallenge
//
//  Created by Ronaldo Gomes on 05/10/21.
//

import Foundation

protocol UpdateTableViewData: AnyObject {
    func updateDataForNextPage()
    func updateDataForPreviousPage()
}
