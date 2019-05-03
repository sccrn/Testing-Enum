import Foundation

//In this enum, I have all product's types. I putted it CaseIterable because after I'll use an array with all the cases,
//and String, because if this code will be use genericlly, when the Bag's array will be made, I'll just need to use the .rawValue
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
//array with all the products that enum of Product contains.
let products = Product.allCases

func checkout(bag: [Product]) -> Double {
    let filterBag = productsInArray(bag: bag)
    var total: Double = 0
    for product in filterBag {
        switch product {
           case .apples:
                let quantity: Double  = Double(quantityOfProduct(bag: bag, product: product))
                let needsDiscount = quantity >= 2
                //I'm using Ternary Conditional Operator, cause I prefer and the code seems more clean, I was nervous, 
                //that's why I didn't putted it in this way before.
                let discount = ((Double(quantity) * product.price()) * 0.2)
                total += needsDiscount ? ((Double(quantity) * product.price()) - discount) :  product.price()
           case .peaches:
                let quantity: Double  = Double(quantityOfProduct(bag: bag, product: product))
                total += quantity * product.price()
           case .bags: 
                let quantity: Int = quantityOfProduct(bag: bag, product: product)
                //I'm converting to Double after because in the next line, needs to be Int.
                let bagsTotal = (Double(quantity) * product.price()/2)
                if quantity % 2 == 0 {
                    total += bagsTotal
                } else {
                    total += quantity == 1 ? product.price() : (bagsTotal + product.price())
                }
       }
    }
    return total
}

//When I received the bag in my another function, I'm gonna see which elements in my array, with all products,
//which product I have in this bag and I'm gonna return it. 
private func productsInArray(bag: [Product]) -> [Product] {
    return products.filter(bag.contains)
}

//I'm getting the number of times that this element repeats in the array, using filter to check when it's equal to the product
//that I'm using.
private func quantityOfProduct(bag: [Product], product: Product) -> Int {
    return bag.filter{$0 == product}.count
}
