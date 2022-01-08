//Паттерн Адаптер - приводит интерефейс одного объекта к интерфейсу другого объекта. Оборачивает приводимый объект, хранит ссылку на него и отвечает непосредственно за конвретацию интерфейса одного объекта к интерефейсу требуемо объекта
protocol BMRImperialCalculation {
    func bmr(height:Double, weight:Double,age:Int) -> Int
}
struct BMRCalculator: BMRImperialCalculation {
    func bmr(height: Double, weight: Double, age: Int) -> Int {
        return Int(66+(6.2*weight) + (12.9 * height) - (6.76 * Double(age)))
    }
}

protocol BMRMetricCalculation {
    func metricBMR(height:Double,weight:Double,age:Int) ->String
    
}

struct BMRCalculatorAdapter:BMRMetricCalculation {
    
    private var adaptee: BMRImperialCalculation
    
    init(adaptee:BMRImperialCalculation){
        
        self.adaptee = adaptee
    }
    func metricBMR(height: Double, weight: Double, age: Int) -> String {
        let iHeight = height * 3.3085
        let iWeight = weight * 4.4000
        let result = adaptee.bmr(height: iHeight, weight: iWeight, age: age)
        return "BMR is \(result). \(result > 1000 ? "High." : "Low.")"
    }
}
struct Person {
    func checkBMR (calculator:BMRMetricCalculation)
    {
        print(calculator.metricBMR(height: 1.74, weight: 65, age: 20))
    }
}
let person = Person()
person.checkBMR(calculator: BMRCalculatorAdapter(adaptee: BMRCalculator()))

