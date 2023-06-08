import SwiftUI

// Produtos
enum SnackType: String {
    case snicker = "Snicker"
    case kitKat = "KitKat"
    case sevenStar = "7Star"
    case caribe = "Caribe"
}

struct Snack {
    let type: SnackType
    var price: Double
    var quantity: Int
}

var snacks: [Int: Snack] = [
    1: Snack(type: .snicker, price: 1.50, quantity: 10),
    2: Snack(type: .kitKat, price: 1.50, quantity: 5),
    3: Snack(type: .sevenStar, price: 2.50, quantity: 3),
    4: Snack(type: .caribe, price: 2.00, quantity: 7)
]

// Visualização de produtos
func myMachine() {
    for (key, value) in snacks {
        let snack = value
        print("\(key): \(snack.type.rawValue) - R$\(snack.price) - Quantidade: \(snack.quantity)")
    }
}

// Função comprar
func buySnack(snackKey: Int) {
    if let snack = snacks[snackKey] {
        if snack.quantity > 0 {
            print("Compra realizada com sucesso: \(snack.type.rawValue)")
            snacks[snackKey]?.quantity -= 1
        } else {
            print("Produto indisponível: \(snack.type.rawValue)")
        }
    } else {
        print("Produto não encontrado para a chave: \(snackKey)")
    }
}

// Simulando Compras
buySnack(snackKey: 1)
buySnack(snackKey: 1)
buySnack(snackKey: 1)
buySnack(snackKey: 1)

myMachine()
