# app/models/shipping_calculator.rb
class ShippingCalculator
  SHIPPING_RATES = {
    'QLD' => { normal: 8, fast: 12 },
    'NSW' => { normal: 12, fast: 18 },
    'VIC' => { normal: 15, fast: 22 },
    'SA' => { normal: 18, fast: 27 },
    'WA' => { normal: 20, fast: 30 },
    'NT' => { normal: 18, fast: 27 },
    'TAS' => { normal: 15, fast: 22 }
  }.freeze

  def self.calculate(state, fast_shipping = false)
    shipping_rate = SHIPPING_RATES[state]
    cost = fast_shipping ? shipping_rate[:fast] : shipping_rate[:normal]
    cost.round(2)
  end
end
