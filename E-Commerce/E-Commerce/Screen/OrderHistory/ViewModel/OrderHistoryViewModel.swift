//
//  OrderHistoryViewModel.swift
//  E-Commerce
//
//  Created by Oğuzhan Akın on 28.07.2024.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

protocol OrderHistoryViewModelDelegate: AnyObject {
    func didOccurError(_ error: Error)
    func didFetchOrderHistory()
}

final class OrderHistoryViewModel {
   
    deinit {
        print("OrderHistoryViewModel deinit")
    }
    
    weak var delegate: OrderHistoryViewModelDelegate?
    
    private let database = Firestore.firestore()
    private let currentUser = Auth.auth().currentUser
    
    var orders: [Order] = [] {
        didSet {
            delegate?.didFetchOrderHistory()
        }
    }
    
    func fetchOrderHistory() {
        guard let currentUser = currentUser else {
            print("No current user")
            return
        }
        
        let userId = currentUser.uid
        print("Current user ID: \(userId)")
        
        let orderHistoryRef = database.collection("Users").document(userId).collection("OrderHistory")
        orderHistoryRef.getDocuments { snapshot, error in
            if let error = error {
                print("Error fetching documents: \(error)")
                self.delegate?.didOccurError(error)
                return
            }
            
            guard let documents = snapshot?.documents else {
                print("No documents found")
                return
            }
            
            self.orders = documents.compactMap { document in
                print("Document data: \(document.data())")
                return Order(document: document)
            }
            print("Fetched orders: \(self.orders)")
            
            if self.orders.isEmpty {
                print("No orders found for user ID: \(userId)")
            } else {
                print("Orders fetched successfully for user ID: \(userId)")
            }
        }
    }
}
