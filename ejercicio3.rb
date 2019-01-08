#######################################################
# Busqueda Aleatoria:                                 #
# • f(x, y) = (x − 2)^2 + (y − 2)^2, x, y ∈ [−5, 5]   #
#                                                     #
# El mínimo global la ecuaciónes:                     #
# • f(xg, yg) = 0, xg = 2 y yg = 2                    #
#######################################################
require 'nyaplot'
require 'nyaplot3d'

def f(x, y)
   (x - 2)**2 + (y - 2)**2
end

def aleatorySearch(limit_inf, limit_sup, start = 0, ended = 10000)
  f_best = +1.0/0.0
  x_best = y_best = 0
  start.step(ended) do |i|
    xi = limit_inf + ( (limit_sup - limit_inf) * Random.rand(0.0..1.0) )
    yi = limit_inf + ( (limit_sup - limit_inf) * Random.rand(0.0..1.0) )
    f_val = f(xi, yi)
    if f_val < f_best
      f_best = f_val
      x_best = xi
      y_best = yi
    end
  end
  min = [x_best, y_best]
  {minimo: min, costo: f_best }
end

def getDataGraphics(limit_inf, limit_sup, steps = 0.5)
  x = []; y = []; z = [];
  xa = limit_inf
  limit_inf.step(limit_sup, steps) do |i|
    limit_inf.step(limit_sup, steps) do |j|
      x << i
      y << j
      z << f(i,j)
    end
  end
  z.map!{|val| next (val.nan? ? 0 : val)}
  data = [x, y, z]
end

def ploting(global_min, limit_inf, limit_sup, steps = 0.1)
  res = getDataGraphics(limit_inf, limit_sup, steps)
  x = res[0]
  y = res[1]
  z = res[2]
  plot = Nyaplot::Plot3D.new
  plot.add(:surface, x, y, z)

  x_min = []; y_min = []; z_min = [];
  x_min << global_min[:minimo][0]
  y_min << global_min[:minimo][1]
  z_min << global_min[:costo]
  plot.add(:particles, x_min, y_min, z_min).color('#8dd3c7')
  # plot.export_html("graph_surface.html")
end

global_min = aleatorySearch(-5, 5)
puts global_min
ploting(global_min, -5, 5)
