"""
Seminario de Solucion de Problemas de Inteligencia Artificial 1
Edgar Joel Arévalo Chavarín  215861967
Practica 1
"""

require 'nyaplot'

def f(x, exercise)
  case exercise
  when 1
    (x**4) + (5 * x**3) + (4 * x**2) - (4*x)
  when 2
    (Math.sin(2 * x))
  when 3
    ((Math.sin(x)) - (x * Math.cos(x)))
  end
end

def fi(x, exercise)
  case exercise
  when 1
    (4 * x**3) + (15 * x**2) + (8 * x) - 4
  when 2
    (2 * Math.cos(2 * x))
  when 3
    ((2 * Math.cos(x)) - (x * Math.sin(x)))
  end
end

def fii(x, exercise)
  case exercise
  when 1
    (12 * x**2) + (30 * x) + 8
  when 2
    (-4 * Math.sin(2 * x))
  when 3
    ((-3 * Math.sin(x)) - x * Math.cos(x))
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

def getDataGraphics(excercise, function, limit_inf, limit_sup, steps = 1)
  x = []; y = [];
  xa = limit_inf
  while xa < limit_sup
    x << xa
    case function
    when 1
      y << f(xa, excercise)
    when 2
      y << fi(xa, excercise)
    when 3
      y << fii(xa, excercise)
    end
    xa += steps
  end
  data = [x,y]
end

def ploting(excercise, limit_inf, limit_sup, steps = 0.1)
  colors = Nyaplot::Colors.qual(3)
  plot = Nyaplot::Plot.new
  res = getDataGraphics(excercise, 1, limit_inf, limit_sup, steps)
  x = res[0]
  y = res[1]
  plot.add(:line, x, y).title("f(x)").color(colors[0])

  res = getDataGraphics(excercise, 2, limit_inf, limit_sup, steps)
  x = res[0]
  y = res[1]
  fi = plot.add(:line, x, y).title("f'(x)").color(colors[1])

  res = getDataGraphics(excercise, 3, limit_inf, limit_sup, steps)
  x = res[0]
  y = res[1]
  plot.add(:line, x, y).title("f''(x)").color(colors[2])

  plot.legend(true)
  name = "graph" + excercise.to_s + ".html"
  # plot.export_html(name)
end

puts `clear`

number_sec = 4

puts "Ejercicio 1"
ploting(1, -4, 1)
puts "Zeros"
zeros = newthonRapson(1, -4, 1, 0.1, 50)
puts zeros
puts "Maximos y Minimos"
max_min(zeros, 1)
gets
# sleep(number_sec)
puts `clear`

puts "Ejercicio 2"
ploting(2, -4, 4)
puts "Zeros"
zeros =  newthonRapson(2, -4, 4, 1, 100)
puts zeros
puts "Maximos y Minimos"
max_min(zeros, 2)
gets
# sleep(number_sec)
puts `clear`

puts "Ejercicio 3"
ploting(3, -5, 5)
puts "Zeros"
zeros = newthonRapson(3, -5, 5, 1, 50)
puts zeros
puts "Maximos y Minimos"
max_min(zeros, 3)
gets
# sleep(number_sec)
puts `clear`
