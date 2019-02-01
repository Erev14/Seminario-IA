"""
Seminario de Solucion de Problemas de Inteligencia Artificial 1
Edgar Joel Arévalo Chavarín  215861967
Practica 1
"""

def f(x, exercise)
  case exercise
  when 1
    (4 * x**3) + (15 * x**2) + (8 * x) - (4)
  when 2
    (x - 5)**2
  when 3
    ((Math.sin(2*x)))
  end
end

def fi(x, exercise)
  case exercise
  when 1
    (12 * x**2) + (30 * x) + 8
  when 2
    2 * (x - 5)
  when 3
    ((2 * Math.cos(2*x)))
  end
end

def fii(x, exercise)
  case exercise
  when 1
    (24 * x) + 30
  when 2
    2
  when 3
    (-4 * Math.sin(2*x))
  end
end

def exclude(arr)
  sorted = arr.reject{|element| element.nan?}.to_a.sort
  filtered = Array.new()
  to_filter = Array.new()
  for i in 0..sorted.count-2
    if !to_filter.include?(sorted[i].round)
      filtered << sorted[i]
      to_filter << sorted[i].round
    end
  end
  return filtered
end

def newthonRapson(excercise, start, ended, steps = 1, limit_iterations = 50)
  arr = (start..ended).step(steps).to_a().map do |xi|
    (0..limit_iterations).map do |i|
      xi = xi - (fi(xi, excercise) / fii(xi, excercise))
    end.last
  end
 exclude(arr)
end

def max_min(ceros, excercise)
  ceros = ceros.sort
  for cero in ceros
    evaluate = fii(cero, excercise)
    if evaluate > 0
      puts "Minimo"
    elsif evaluate < 0
      puts "Maximo"
    end
    puts evaluate
  end
end

puts `clear`

number_sec = 4

puts "Ejercicio 1"

puts "Zeros"
zeros = newthonRapson(1, -4, 1, 0.1, 50)
puts zeros
puts "Maximos y Minimos"
max_min(zeros, 1)
gets
# sleep(number_sec)
puts `clear`

puts "Ejercicio 2"
puts "Zeros"
zeros =  newthonRapson(2, -10, 10, 0.1, 100)
puts zeros
puts "Maximos y Minimos"
max_min(zeros, 2)
gets
# sleep(number_sec)
puts `clear`

puts "Ejercicio 3"
puts "Zeros"
zeros = newthonRapson(3, -5, 5, 1, 50)
puts zeros
puts "Maximos y Minimos"
max_min(zeros, 3)
gets
# sleep(number_sec)
puts `clear`
