import Foundation

enum Product: String, CaseIterable {
    case apples
    case peaches
    case bags

    func price() -> Double {
       switch self {
           case .apples: return 3 
           case .peaches: return 7
           case .bags: return 5
       }
    }
}

func checkout(bag: [Product]) -> Double {
    var filterBag = productsInArray(bag: bag)
    var total: Double = 0
    for product in filterBag {
        switch product {
           case .apples:
                let quantity: Double  = Double(quantityOfProduct(bag: bag, product: product))
                let needsDiscount = quantity >= 2
                total += needsDiscount ? ((Double(quantity) * product.price()) * 0.2) :  product.price()
           case .peaches:
                let quantity: Double  = Double(quantityOfProduct(bag: bag, product: product))
                total += quantity * product.price()
           case .bags: 
                let quantity: Int = quantityOfProduct(bag: bag, product: product)
                let bagsTotal = (Double(quantity) * product.price()/2)
                total += quantity % 2 == 0 ? bagsTotal : (bagsTotal + product.price())
       }
    }
    return total
}

private func productsInArray(bag: [Product]) -> [Product] {
    let products = Product.allCases
    return products.filter(bag.contains)
}

private func quantityOfProduct(bag: [Product], product: Product) -> Int {
    return bag.filter{$0 == product}.count
}