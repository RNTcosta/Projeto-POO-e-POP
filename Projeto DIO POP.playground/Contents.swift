import SwiftUI

//Projeto DIO

//Classe mãe com atributos incomun a todos inimigos
class Enemies {
    let name: String
    let speed: Double
    let power: Int
    var life: Int
    let damage: Double
    
    init(name: String, speed: Double, power: Int, life: Int, damage: Double){
        self.name = name
        self.speed = speed
        self.power = power
        self.life = life
        self.damage = damage
    }
    func attack(target: mainCharacter){
        let damage = power
        target.life -= damage
        print("\(name) atacou \(target.name) causando \(damage) de dano.")
    }
}
//Subclasse do inimigo tipo único: Aliens
class Aliens: Enemies {
    let numberOfTentacles: Int
    init(name: String, speed: Double, power: Int, life: Int, damage: Double, numberOfTentacles: Int) {
        self.numberOfTentacles = numberOfTentacles
        super.init(name: name, speed: speed, power: power, life: life, damage: damage)
    }
}
//Protocolo para criar inimigos do tipo Predador
protocol Predator {
    var isInvisible: Bool { get }
}
//Subclasses Predadores
class PredatorX: Enemies, Predator {
    let isInvisible: Bool
    init(name: String, speed: Double, power: Int, life: Int, damage: Double, isInvisible: Bool) {
        self.isInvisible = isInvisible
        super.init(name: name, speed: speed, power: power, life: life, damage: damage)
    }
}
class PredatorY: Enemies, Predator {
    let isInvisible: Bool
    let weakPoint: Bool
    init(name: String, speed: Double, power: Int, life: Int, damage: Double, isInvisible: Bool, weakPoint: Bool) {
        self.isInvisible = isInvisible
        self.weakPoint = weakPoint
        super.init(name: name, speed: speed, power: power, life: life, damage: damage)
    }
}
//    Criando inimigos
    let enemiesJupiter = Aliens(name: "Aliens J", speed: 3.5, power: 5, life: 85, damage: 12, numberOfTentacles: 4)
    let enemiesGalaxy2 = PredatorX(name: "Predator X", speed: 4.5, power: 6, life: 92, damage: 15, isInvisible: false)
    let enemiesGalaxy4 = PredatorY(name: "Predator Y", speed: 4.9, power: 7, life: 95, damage: 10, isInvisible: true, weakPoint: true)

//    Array de inimigos
    let allEnemies = [enemiesGalaxy2, enemiesGalaxy4, enemiesJupiter]

//Função que verifica o inimigo mais forte!
func mostPowerfullEnemy(){
    let sortedEnemies = allEnemies.sorted { $0.power > $1.power }
    
    if let strongestEnemy = sortedEnemies.first {
        print("O inimigo mais poderoso é: \(strongestEnemy.name)")
    } else {
        print("Não há inimigos na lista.")
    }
}

//Função que seleciona os inimigos e informa seus atributos
func selectedEnemy(_ enemy: Enemies) {
    switch enemy {
    case let aliens as Aliens:
        print("O inimigo selecionado foi: \(aliens.name) e possui os atributos: Velocidade: \(aliens.speed) | Força: \(aliens.power) | Saúde: \(aliens.life) | Dano: \(aliens.damage)")
    case let predatorX as PredatorX:
        print("O inimigo selecionado foi: \(predatorX.name) e possui os atributos: Velocidade: \(predatorX.speed) | Força: \(predatorX.power) | Saúde: \(predatorX.life) | Dano: \(predatorX.damage)")
    case let predatorY as PredatorY:
        print("O inimigo selecionado foi: \(predatorY.name) e possui os atributos: Velocidade: \(predatorY.speed) | Força: \(predatorY.power) | Saúde: \(predatorY.life) | Dano: \(predatorY.damage)")
    default:
        print("Inimigo desconhecido.")
    }
}

// Personagem principal do game
class mainCharacter {
    let name: String
    let speed: Double
    let power: Int
    var life: Int
    let damage: Double
    
    init(name: String, speed: Double, power: Int, life: Int, damage: Double){
        self.name = name
        self.speed = speed
        self.power = power
        self.life = life
        self.damage = damage
    }
    
    func attack(target: Enemies){
        let damage = power
        target.life -= damage
        print("\(name) atacou \(target.name) causando \(damage) de dano.")
    }
    
}
//Criando personagem principal
let exterminator = mainCharacter(name: "Exterminator", speed: 3, power: 50, life: 100, damage: 35)
//Função para checar vida do único personagem principa, caso contrario seria preciso criar um array e realizar loop for conforme fiz na checkEnemyHealth abaixo!
func checkMainCharacterHealth()async{
    if exterminator.life <= 0 {
        print("O \(exterminator.name) foi derrotado")
    }
}

//Simulação de ataque
exterminator.attack(target: enemiesGalaxy2)
exterminator.attack(target: enemiesGalaxy2)
exterminator.attack(target: enemiesJupiter)
exterminator.attack(target: enemiesJupiter)
enemiesGalaxy2.attack(target: exterminator)
enemiesGalaxy4.attack(target: exterminator)


//Loop for para checar vida dos inimigos
func checkEnemyHealth() async {
        for enemy in allEnemies {
            if enemy.life <= 0 {
                print("\(enemy.name) foi derrotado!")
            } else {print("\(enemy.name) está com \(enemy.life) de vida!")}
        }
    }

// Chamando funções assíncronas
Task {
    await checkEnemyHealth()
    await checkMainCharacterHealth()
}
