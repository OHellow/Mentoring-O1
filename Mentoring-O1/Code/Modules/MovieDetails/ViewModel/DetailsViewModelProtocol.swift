import Foundation

protocol DetailsViewModelProtocol {
    var requestError: Observable<RequestError?> { get set }
    var detailsModel: Observable<DetailsModel?> { get set }
}
