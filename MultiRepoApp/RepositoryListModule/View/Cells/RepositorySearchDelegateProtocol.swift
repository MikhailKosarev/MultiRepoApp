/// A protocol that defines the delegate methods for when the text of the search field changes.
protocol RepositorySearchDelegateProtocol: AnyObject {
    /// This method is called by the search field to notify its delegate that the text has changed.
    /// - Parameter searchText: The new text entered by the user.
    func searchTextChanged(searchText: String)
}
