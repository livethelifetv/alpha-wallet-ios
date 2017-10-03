// Copyright SIX DAY LLC. All rights reserved.

import Foundation
import UIKit

struct TransactionViewCellViewModel {

    let transaction: Transaction

    init(transaction: Transaction) {
        self.transaction = transaction
    }

    var title: String {
        switch transaction.direction {
        case .incoming: return "Received"
        case .outgoing: return "Sent"
        }
    }

    var subTitle: String {
        switch transaction.direction {
        case .incoming: return "\(transaction.from)"
        case .outgoing: return "\(transaction.to)"
        }
    }

    var subTitleTextColor: UIColor {
        return Colors.gray
    }

    var subTitleFont: UIFont {
        return UIFont.systemFont(ofSize: 12, weight: UIFontWeightThin)
    }

    var amount: String {
        let value = EthereumConverter.from(value: BInt(transaction.value), to: .ether, minimumFractionDigits: 3)
        switch transaction.direction {
        case .incoming: return "+\(value)"
        case .outgoing: return "-\(value)"
        }
    }

    var amountTextColor: UIColor {
        switch transaction.direction {
        case .incoming: return Colors.green
        case .outgoing: return Colors.red
        }
    }

    var amountFont: UIFont {
        return UIFont.systemFont(ofSize: 17, weight: UIFontWeightMedium)
    }

    var backgroundColor: UIColor {
        switch transaction.transactionState {
        case .error, .completed:
            return .white
        case .pending:
            return UIColor(hex: "f4f4f4")
        }
    }

    var statusImage: UIImage? {
        switch transaction.transactionState {
        case .error: return R.image.transaction_error()
        case .completed:
            switch transaction.direction {
            case .incoming: return R.image.transaction_received()
            case .outgoing: return R.image.transaction_sent()
            }
        case .pending:
            return R.image.transaction_pending()
        }
    }
}
