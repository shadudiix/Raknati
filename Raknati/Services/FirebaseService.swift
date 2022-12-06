//
//  FirebaseService.swift
//  Raknati
//
//  Created by Shady K. Maadawy on 01/12/2022.
//

import Foundation

import FirebaseFirestore
import FirebaseFirestoreSwift

final class FirebaseService {
    
    // MARK: - Properties

    private let sessionManager = SessionManager.shared
    
    private var currentUserUUID: String! {
        guard let currentUser = self.sessionManager.currentUser else {
            fatalError("User UUID Is not available")
        }
        return currentUser.uuid
    }

    enum collectionPaths: String {
        case ParkingLocationsCollection = "User/%@/Locations"

        func fixCollectionPath(_ userUUID: String!) -> String {
            return String(format: self.rawValue, userUUID)
        }
        
    }
    private lazy var firebaseInstance: Firestore = {
        let baseFirestore = Firestore.firestore()
        return baseFirestore
    }()
    
    // MARK: - Object Life Cycle
    
    deinit {
        print("deinit \(self)")
    }
    
    // MARK: - Functions
    
    func createDocument(
        _ collectionPath: collectionPaths,
        _ data: some Encodable,
        _ hanlder: @escaping(Result<String, Error>) -> ())
    {
        do {
            let firebaseDocument = try firebaseInstance.collection(collectionPath.fixCollectionPath(self.currentUserUUID)).addDocument(from: data, completion: { isError in
                if let isError = isError  {
                    hanlder(.failure(isError))
                    return
                }
            })
            hanlder(.success(firebaseDocument.documentID))

        } catch {
            hanlder(.failure(error))
        }
    }
    
    func retrieveLast(
        _ collectionPath: collectionPaths, retrieveAs: any Decodable.Type,
        orderBy: String!, whereField: String!, isEqualTo: Any,
        handler: @escaping(Result<Decodable, Error>) -> ()) {
        firebaseInstance.collection(collectionPath.fixCollectionPath(self.currentUserUUID)).order(by: orderBy, descending: true).whereField(whereField, isEqualTo: isEqualTo).limit(to: 1).getDocuments(completion: { queryResult, isError in
                guard let queryResult = queryResult else {
                    handler(.failure(RaknatiErrorCodes.dataIsInvaild))
                    return
                }
                if(queryResult.documents.isEmpty) {
                    handler(.failure(RaknatiErrorCodes.emptyCollection))
                    return
                }
                guard let queryDoucment = queryResult.documents.first else {
                    handler(.failure(RaknatiErrorCodes.failedToFetch))
                    return
                }
                do {
                    let decodedObject = try queryDoucment.data(as: retrieveAs)
                    handler(.success((decodedObject)))
                } catch {
                    handler(.failure(error))
                }
        })
    }
    
    func updateDocument(
        _ collectionPath: collectionPaths,
        _ documentUUID: String!,
        fields: [AnyHashable : Any],
        handler: @escaping(Result<Bool, Error>) -> ()) {
            firebaseInstance.collection(collectionPath.fixCollectionPath(self.currentUserUUID)).document(documentUUID).updateData(fields) { updateError in
                guard let updateError = updateError else {
                    handler(.success(true))
                    return
                }
                handler(.failure(updateError))
        }
    }
}

