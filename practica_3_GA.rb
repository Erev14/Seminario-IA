require 'nyaplot'
require 'nyaplot3d'

module GA
  class Basic
    class << self

      def f(x, y)
        if @function == 1
          x * (Math.exp(-x**2-y**2))
        else
          ((x-2)**2) + ((y-2)**2)
        end
      end

      def initialize(funcion, limit_inf, limit_sup, mutator_max = 0.4, poblation = 50, generations = 10, dimensions = 2)
        # function needed data

        # function that will be evaluated
        @function = funcion
        # lower limit of the function
        @limit_inf = limit_inf
        # upper limit of the function
        @limit_sup = limit_sup
        # number of dimensions of the function
        @dimensions = dimensions

        # data needed for the GA

        # poblation number
        @poblation = poblation
        # number of generations that will be made
        @generations = generations
        # probability to mutate for a son
        @mutator_probability = Random.rand(0.0..mutator_max)


        # value to compare initialize as infinite

        # vector for every individual
        @father_x = []
        @father_y = []

        # son initialition as emply array
        @son_x = []
        @son_y = []


        # pobation initialition
        poblationInit
        f_best = +1.0/0.0
        x_best = 0
        y_best = 0
        puts "mutator_probability"
        puts @mutator_probability
        # repeat until all the generations were complete
        1.step(@generations) do |generation|
          # sum of the aptitude of all the poblation
          @poblation_aptitud = 0
          # aptitud vectore, who aptitude is every father
          @aptitude = []
          # probability to be chose as a father for every individual in the poblation
          @elector_probability = []

          # calculate aptitud
          aptitud


          while @son_x.size < @poblation do
            # made rulet selection
            a = rulet
            # generate sons
            generateSons(a)
          end
          # puts @son_x.select{|i| i.nil?}.size

          # mutate sons
          mutate
          @father_x = @son_x.dup
          @father_y = @son_y.dup

          # clear sons
          @son_x.clear
          @son_y.clear

          @father_x.each_with_index.map do |value, i|
            f_val = f(value, @father_y[i])
            # puts f_val
            if(f_val < f_best)
              # puts i
              x_best = value
              y_best = @father_y[i]
              f_best = f_val
            end

          end
        end
        {best: {x: x_best, y: y_best}, f_val: f_best}
      end

      def poblationInit
        0.step(@poblation - 1) do |i|
          @father_x << @limit_inf + ( (@limit_sup - @limit_inf) * Random.rand(0.0..1.0) )
          @father_y << @limit_inf + ( (@limit_sup - @limit_inf) * Random.rand(0.0..1.0) )
        end
      end

      def aptitud
        0.step(@poblation - 1) do |i|
          value = f(@father_x[i], @father_y[i])
          @aptitude << aptitudEvalution(value)
        end
        @poblation_aptitud = @aptitude.reduce{ |a,b| a + b }
      end

      def aptitudEvalution(function_value)
        if (function_value < 0)
          1 + function_value.abs
        else
          1 / (1 + function_value)
        end
      end

      def rulet
        @elector_probability = @aptitude.map{|value| ruletValue(value)}
        i = selection
        j = selection
        while (i == j)
          j = selection
        end
        {father_1: i, father_2: j}
      end

      def ruletValue(evaluted)
        evaluted / @poblation_aptitud
      end

      def selection
        p_sum = 0
        index = -1
        # probability need to be chosen as father
        selector = Random.rand(0.0..1.0)

        @elector_probability.each_with_index.map do |value, i|
          p_sum += value
          if (p_sum >= selector)
            index = i
            break
          end
        end
        index = @elector_probability.size if index > @elector_probability.size
        index
      end

      def generateSons(a)
        pc = Random.rand(1..@dimensions)
        father_1 = a[:father_1]
        father_2 = a[:father_2]
        if(pc == 1)
          @son_x << @father_x[father_1]
          @son_y << @father_y[father_2]

          @son_x << @father_x[father_2]
          @son_y << @father_y[father_1]
        else
          @son_x << @father_x[father_2]
          @son_y << @father_y[father_2]

          @son_x << @father_x[father_1]
          @son_y << @father_y[father_1]
        end
      end

      def mutate
          0.step(@poblation - 1) do |j|
            0.step(@dimensions - 1) do |i|
            ra = Random.rand(0.0..1.1)
            rb = Random.rand(0.0..1.1)
            if(ra < @mutator_probability)
              mutate = @limit_inf + ( (@limit_sup - @limit_inf) * rb )
              if (@dimensions % 2 == 0)
                @son_x[j] = mutate
              else
                @son_y[j] = mutate
              end
            end

          end
        end

      end

    end
  end
end

def f(x, y, function)
  if function == 1
    x * (Math.exp(-x**2-y**2))
  else
    ((x-2)**2) + ((y-2)**2)
  end
end

def getDataGraphics(limit_inf, limit_sup, function, steps = 0.5)
  x = []; y = []; z = [];

  limit_inf.step(limit_sup, steps) do |i|
    limit_inf.step(limit_sup, steps) do |j|
      x << i
      y << j
      z << f(i,j, function)
    end
  end

  z.map!{|val| next (val.nan? ? 0 : val)}
  data = [x, y, z]
end

def ploting3D(global_min, limit_inf, limit_sup, function, steps = 0.1)
  res = getDataGraphics(limit_inf, limit_sup, function, steps)
  x = res[0]
  y = res[1]
  z = res[2]
  colors = Nyaplot::Colors.qual(3)
  plot = Nyaplot::Plot3D.new
  plot.add(:wireframe, x, y, z)

  x_min = []; y_min = []; z_min = [];
  x_min << global_min[:best][:x]
  y_min << global_min[:best][:y]
  z_min << global_min[:f_val]
  name_export = "GA excercise " + function.to_s
  plot.add(:particles, x_min, y_min, z_min).name(name_export).color(colors[2])
  plot.export_html(name_export + ".html")
end


puts "primera funcion f(x, y) = x e^(−x**2−y**2), x, y ∈ [−2, 2]"
a = GA::Basic.initialize(1, -2, 2, 1.0)
puts "\n"
puts a
puts "\n"
ploting3D(a, -2, 2, 1)
puts "segunda funcion f(x) = sum((xi − 2)^2) de i = 1 hasta d, d = 2"
b = GA::Basic.initialize(2, -2, 2, 1.5)
puts "\n"
puts b
puts "\n"
ploting3D(b, -2, 2, 2)
