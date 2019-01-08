"""
Semaxario de Solucion de Problemas de Inteligencia Artificial 1
Edgar Joel Arévalo Chavarín  215861967
Practica 1
"""

require 'nyaplot'

#function definitions
def f(l)
  large = 20
  (large-2*l)**2*l
end

# Aleatoria
def aleatorySearch(limit_inf, limit_sup, start = 0, ended = 50)
  #this is equal to Infinite  when you make a comparation, this is always biger
  # f_best = +1.0/0.0
  f_best = -1.0/0.0
  x_best = 0
  start.step(ended) do |i|
    xi = limit_inf + ( (limit_sup - limit_inf) * Random.rand(0.0..1.0) )
    f_val = f(xi)

    if f_val > f_best
      f_best = f_val
      x_best = xi
    end

  end
  max = x_best
  {maximo: max, costo: f_best }
end

# Graphics
def getDataGraphics(limit_inf, limit_sup, dimensions = 2, steps = 0.5)
  x = []; y = [];
  limit_inf.step(limit_sup, steps) do |i|
    x << i
    y << f(i)
  end
  data = [x, y]
end

def ploting(global_max_ale, limit_inf, limit_sup, steps = 0.1)
  colors = Nyaplot::Colors.qual(3)
  plot = Nyaplot::Plot.new
  res = getDataGraphics(limit_inf, limit_sup, 2,steps)
  x = res[0]
  y = res[1]
  plot.add(:line, x, y).title("f(x)").color(colors[0])

  x_max = []; y_max = [];
  x_max << global_max_ale[:maximo]
  y_max << global_max_ale[:costo]
  plot.add(:scatter, x_max, y_max).title("maximo global aleatorySearch").color(colors[1])
  plot.legend(true)
  name = "extra.html"
  plot.export_html(name)
end


puts "primera funcion f(l) = (20-2*l)**2*l, x ∈ [0, 10]"
puts "busqueda aleatoria"
global_max = {maximo: 0, costo: -1.0/0.0 }
for i in 0..20
  current_max_ale = aleatorySearch(0, 10, 0, 50)
  puts current_max_ale
  if current_max_ale[:costo] > global_max[:costo]
    global_max = current_max_ale
  end
end

puts "maximo global despues de 20 veces aplicado"
puts global_max


ploting(global_max, 0, 10)
