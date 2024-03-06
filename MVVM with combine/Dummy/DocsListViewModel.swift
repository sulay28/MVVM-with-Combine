//
//  DocsListViewModel.swift
//  Dummy
//
//  Created by Sulay on 06/03/24.
//

import Foundation
import Combine

final class DocsListViewModel: ObservableObject {
    
    // MARK: - Properties
    
    private let docsRequest: DocsRequest
    
    @Published var documents: [Doc] = []
    
    init(docsRequest: DocsRequest = DocsRetrivalRequest()) {
        self.docsRequest = docsRequest
    }
    
    func fetchDocs() async throws {
        let document = try await docsRequest.loadDocs()
        
        await MainActor.run {
            self.documents = document
        }
    }
    
    func docs(atIndexPath indexPath: IndexPath) -> Doc {
        documents[indexPath.row]
    }
}


