import Foundation

protocol DetailsViewModelProtocol {
    var detailsResult: Observable<Result<DetailsModel, RequestError>?> { get set }
}
