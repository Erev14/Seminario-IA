#########################################################
# • f(x, y) = x e^(−x**2−y**2), x, y ∈ [−2, 2]          #
#                                                       #
# • f(x) = sum((xi − 2)^2) de i = 1 hasta d, d = 2      #
#                                                       #
# El mínimo global para la primera ecuaciónes:          #
# • f(xg, yg) = −0.42888, xg = −0.70711 y yg = 0        #
# y para la segunda:                                    #
# • f(xg) = 0, xg = (2, · · · , 2)                      #
#########################################################
require 'nyaplot'
require 'nyaplot3d'


#function definitions
def f(x, y, excercise)
    if excercise == 2
      # y in this case is for d = 2
      l = 1..y
      l.reduce { |a, b| a + (x - 2)**2 }
   else
     x * (Math.exp(-x**2-y**2))
   end
end

# Aleatoria
def aleatorySearch(excercise, limit_inf, limit_sup, start = 0, ended = 50)
  #this is equal to Infinite  when you make a comparation, this is always biger
  f_best = +1.0/0.0
  x_best = y_best = 0
  start.step(ended) do |i|
    xi = limit_inf + ( (limit_sup - limit_inf) * Random.rand(0.0..1.0) )
    yi = limit_inf + ( (limit_sup - limit_inf) * Random.rand(0.0..1.0) )
    if excercise == 2
      f_val = f(xi, 2, excercise)
    else
      f_val = f(xi, yi, excercise)
    end
    if f_val < f_best
      f_best = f_val
      x_best = xi
      y_best = yi
    end
  end
  if excercise == 2
    min = [x_best]
  else
    min = [x_best, y_best]
  end
  {minimo: min, costo: f_best }
end

# Gradiente Descendiente
def gradient3Dim(limit_iterations, init_x = 0, init_y = 0)
  puts "h"
  h = Random.rand(0.0..0.01)
  puts h
  puts "dx and dy"
  dx = Random.rand(0.0..0.015)
  puts dx

  x = init_x
  y = init_y
  (0..limit_iterations).map do |i|
    x = x - (h * ( f(x + (dx / 2), y, 1) - f(x - (dx / 2), y, 1) ) / dx )
    y = y - (h * ( f(x, y + (dx / 2), 1) - f(x, y - (dx / 2), 1) ) / dx )
  end
  {minimo: [x, y], costo: f(x, y, 1) }
end

def gradient2Dim(limit_iterations)
  puts "h"
  h = Random.rand(0.0..0.5)
  puts h
  puts "dx"
  dx = Random.rand(0.0..0.5)
  puts dx

  xi = 0.7
  (0..limit_iterations).map do |i|
    inc = f(xi + (dx / 2), 2, 2)
    dec = f(xi - (dx / 2), 2, 2)
    grad_x = ( inc - dec ) / dx
    xi -= (h * grad_x)
  end
  {minimo: [xi], costo: f(xi, 2, 2) }
end

# Graphics
def getDataGraphics(limit_inf, limit_sup, dimensions = 2, steps = 0.5)
  x = []; y = []; z = [];
  if dimensions == 2
    limit_inf.step(limit_sup, steps) do |i|
      x << i
      y << f(i, 2, 2)
    end
  else
    limit_inf.step(limit_sup, steps) do |i|
      limit_inf.step(limit_sup, steps) do |j|
        x << i
        y << j
        z << f(i,j,1)
      end
    end
  end
  z.map!{|val| next (val.nan? ? 0 : val)}
  if dimensions == 2
    data = [x, y]
  else
    data = [x, y, z]
  end
end

def ploting3D(global_min_ale, global_min_gra, limit_inf, limit_sup, steps = 0.1)
  res = getDataGraphics(limit_inf, limit_sup, 3, steps)
  x = res[0]
  y = res[1]
  z = res[2]
  colors = Nyaplot::Colors.qual(3)
  plot = Nyaplot::Plot3D.new
  plot.add(:wireframe, x, y, z)

  x_min = []; y_min = []; z_min = [];
  x_min << global_min_ale[:minimo][0]
  y_min << global_min_ale[:minimo][1]
  z_min << global_min_ale[:costo]
  plot.add(:particles, x_min, y_min, z_min).name("aleatorySearch").color(colors[0])

  x_min = []; y_min = []; z_min = [];
  x_min << global_min_gra[:minimo][0]
  y_min << global_min_gra[:minimo][1]
  z_min << global_min_gra[:costo]
  plot.add(:particles, x_min, y_min, z_min).name("gradientDesc").color(colors[1])
  plot.export_html("graph_1.html")
end

def ploting(global_min_ale, global_min_gra, limit_inf, limit_sup, steps = 0.1)
  colors = Nyaplot::Colors.qual(3)
  plot = Nyaplot::Plot.new
  res = getDataGraphics(limit_inf, limit_sup, 2,steps)
  x = res[0]
  y = res[1]
  plot.add(:line, x, y).title("f(x)").color(colors[0])

  x_min = []; y_min = [];
  x_min << global_min_ale[:minimo][0]
  y_min << global_min_ale[:costo]
  plot.add(:scatter, x_min, y_min).title("minimo global aleatorySearch").color(colors[1])

  x_min = []; y_min = [];
  x_min << global_min_gra[:minimo][0]
  y_min << global_min_gra[:costo]
  plot.add(:scatter, x_min, y_min).title("minimo global gradientDesc").color(colors[2])
  plot.legend(true)
  name = "graph_2.html"
  plot.export_html(name)
end


puts "primera funcion f(x, y) = x e^(−x**2−y**2), x, y ∈ [−2, 2]"
puts "busqueda aleatoria"
global_min_ale = aleatorySearch(1, -2, 2, 0, 100)
puts "minimo global de busqueda aleatoria"
puts global_min_ale
puts "gradiente descendiente"
global_min_gra = gradient3Dim(100,-1,0)
puts "minimo global gradiente descendiente"
puts global_min_gra
ploting3D(global_min_ale, global_min_gra, -2, 2)



puts "segunda funcion f(x) = sum((xi − 2)^2) de i = 1 hasta d, d = 2"
puts "busqueda aleatoria"
global_min_ale = aleatorySearch(2, -2, 2, 0, 150)
puts "minimo global de busqueda aleatoria"
puts global_min_ale
puts "gradiente descendiente"
global_min_gra = gradient2Dim(100)
puts "minimo global gradiente descendiente"
puts global_min_gra
ploting(global_min_ale, global_min_gra, -2, 2)
