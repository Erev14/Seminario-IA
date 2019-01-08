module IA
  class DE
    class << self
      def f(x)
        q = x.map{ |dim| dim *(Math::PI/180) }

        l1 = 0.5
        l2 = 0.5

        p = Array.new(3,0)
        p[0] = -Math.sin(q[0]-Math::PI/2)*(l1*Math.cos(q[1])+l2*Math.cos(q[1]+q[2]))
        p[1] = Math.cos(q[0]-Math::PI/2)*(l1*Math.cos(q[1])+l2*Math.cos(q[1]+q[2]))
        p[2] = l1*Math.sin(q[1])+l2*Math.sin(q[1]+q[2])
        p
      end

      def euclidean(a,b)
        sum = 0
        a.zip(b).each do |v1, v2|
          sum += (v1 - v2)**2
          # component = (v1 - v2)**2
          # sum += component
        end
        Math.sqrt(sum)
      end

      def initialize(limit_inf, limit_sup, end_point, poblation = 50, generations = 500, dimensions = 3)
        # function needed data

        # lower limit of the function
        @ql = limit_inf
        # upper limit of the function
        @qu = limit_sup
        # objetive that we want to get
        @end_point = end_point
        # number of dimensions of the function
        @dimensions = dimensions
        # number of generations that will be made
        @generations = generations

        # Factor to control the (xr2 − xr3) diferential amplification
        @F = 0.8;
        # recombination constant
        @CR = 0.5;
        # poblation
        @N = 70;

        # @x = Array.new(@N) { Array.new(@dimensions) }
        @v = Array.new(@N) { Array.new(@dimensions,0) }
        @u = Array.new(@N) { Array.new(@dimensions,0) }
        @fitness = Array.new(@N)

        best = 0

        @x = Array.new(@N) { Array.new(@dimensions) {|index| Random.rand(@ql[index]..@qu[index]) } }

        1.step(@generations) do |generation|

          0.step(@N - 1) do |i|
            @fitness[i] = euclidean(f(@x[i]), @end_point)

            r1 = Random.rand(0..@N - 1)
            r2 = Random.rand(0..@N - 1)
            r3 = Random.rand(0..@N - 1)

            while(r1 == r2 || r2 == r3 || r1 == i || r2 == i || r3 == i)
              r1 = Random.rand(0..@N - 1)
              r2 = Random.rand(0..@N - 1)
              r3 = Random.rand(0..@N - 1)
            end
            ra = Random.rand
            p = 0
            0.step(@dimensions - 1) do |j|
              @v[i][j] = @x[r1][j] + @F * (@x[r2][j] - @x[r3][j])
              if(ra <= @CR)
                  @u[i][j] = @v[i][j];
              else
                  @u[i][j] = @x[i][j];
              end
              # penality
              if(@ql[j]<= @u[i][j] && @u[i][j] <= @qu[j])
                  p += 0;
              else
                  p += 1;
              end

            end # every dimension

            # if( ( f(u[i]) + 1000 * g ) < f(x[i]) )
            if( euclidean(f(@u[i]), @end_point).abs < euclidean(f(@x[i]), @end_point ).abs)
              @x[i] = @u[i]
              # puts "@x[i]"
              # puts @x[i]
              # @fitness[i] = euclidean(f(@x[i]), @end_point)
            end

          end # end of poblation

        end # end of generations
        puts euclidean(@x.min, @end_point)
      end
    end
  end
end


# puts "ingresa posicion final en x"
# x = gets.chomp
# puts "ingresa posicion final en y"
# y = gets.chomp
# puts "ingresa posicion final en z"
# z = gets.chomp
# x = 100
# y = -20
# z = 50
# end_point = [x,y,z]

limit_inf = [-160, -150, -135]
limit_sup = [160, 150, 135]

a = IA::DE.initialize(limit_inf, limit_sup, end_point)
puts a
