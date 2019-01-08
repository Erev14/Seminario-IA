require "mini_magick"
# require 'rmagick'

module IA
  class DE
    class << self
      def ncc(img,temp,x,y)
        # 640,480
        # width, height
        # a = {height_o: img[0].size, width_o: img.size, height: temp[0].size, width: temp.size, x: x, y: y}#82,63
        # puts a
        # puts img[temp.size + x - 1][j + y]
        sum_img = 0.0
        sum_temp = 0.0
        sum_2 = 0.0
        0.step(temp.size - 1) do |i|
          0.step(temp[i].size - 1) do |j|
            # a = {i: i, j: j, x: x, y: y, ix: i+x, jy: j+y, height_o: img[0].size, width_o: img.size}
            # puts a
            sum_img += (img[i + y][j + x])**2
            sum_temp += (temp[i][j])**2
            sum_2 += (img[i + y][j + x]) * (temp[i][j])
          end
        end
        sum_2 / ( Math.sqrt(sum_img)* Math.sqrt(sum_temp) )
        # sum_img = sum_img + double(img(y+j,x+i))^2;
        # sum_temp = sum_temp + double(temp(j,i))^2;
        # sum_2 = sum_2 + double(img(y+j,x+i))*double(temp(j,i));
        #
        # val = sum_2/(sqrt(double(sum_img))*sqrt(double(sum_temp)));
      end

      def initialize(limit_inf, limit_sup, image, template, poblation = 150, generations = 100, dimensions = 2)
        # function needed data

        # lower limit of the function
        @ql = limit_inf
        # upper limit of the function
        @qu = limit_sup
        # number of dimensions of the function
        @dimensions = dimensions
        # number of generations that will be made
        @generations = generations

        # Factor to control the (xr2 − xr3) diferential amplification
        @F = 0.6;
        # recombination constant
        @CR = 0.9;
        # poblation
        @N = poblation;

        # @x = Array.new(@N) { Array.new(@dimensions) }
        @v = Array.new(@dimensions,0)
        @u = Array.new(@dimensions,0)

        @best_val = -1.0/0.0
        @best_pos = []

        @x = Array.new(@N) { Array.new(@dimensions) {|index| Random.rand(@ql[index]..@qu[index]) } }

        1.step(@generations) do |generation|
          0.step(@N - 1) do |i|

            r1 = Random.rand(0..(@N - 1) )
            r2 = Random.rand(0..(@N - 1))
            r3 = Random.rand(0..(@N - 1))

            while(r1 == r2 || r2 == r3 || r1 == i || r2 == i || r3 == i)
              r1 = Random.rand(0..(@N - 1))
              r2 = Random.rand(0..(@N - 1))
              r3 = Random.rand(0..(@N - 1))
            end
            ra = Random.rand
            p = 0
            0.step(@dimensions - 1) do |j|
              @v[j] = @x[r1][j] + @F * (@x[r2][j] - @x[r3][j])
              if(ra <= @CR)
                  @u[j] = @v[j];
              else
                  @u[j] = @x[i][j];
              end
              # penality
              if(@u[j] < @ql[j] || @u[j] > @qu[j])
                  @u[j] = @ql[j] + (@qu[j] - @ql[j]) * Random.rand(0.0..1.0);
              end

            end # every dimension

            @u = @u.map { |e| e.to_i }
            f_val = ncc(image, template, @u[0], @u[1])
            if( f_val > ncc(image, template, @x[i][0], @x[i][1]))
              @x[i] = @u
              if(f_val > @best_val)
                @best_val = f_val
                @best_pos = @u.map { |e| e.to_i  }
                puts Hash[:val => f_val, :pos => @u]
              end
            end
          end # end of poblation
        end # end of generations
        {costo: @best_val, pos: @best_pos}
      end

    end
  end
end

# convert = MiniMagick::Tool::Convert.new
# convert << "Image_1.bmp"
# convert.colorspace "Gray"
# convert << "temp.jpg"
# convert.call


def RGB2GRAY(pixels)
  pixels_new = Array.new(pixels.size) { Array.new(pixels[0].size,0) }
  0.step(pixels.size - 1) do |i|
    0.step(pixels[0].size - 1) do |j|
      pixels_new[i][j] = Integer(0.2126*pixels[i][j][0] + 0.7152*pixels[i][j][1] + 0.0722*pixels[i][j][2])
    end
  end
  pixels_new
end

image = MiniMagick::Image.open("Image_1.bmp")
pixels = image.get_pixels
pixels_gray = RGB2GRAY(pixels)
img = image.dimensions

template = MiniMagick::Image.open("Template.bmp")
pixels_tem = template.get_pixels
pixels_tem_gray = RGB2GRAY(pixels_tem)
tem = template.dimensions

limit_inf = [0,0]
limit_sup = img.each_with_index.map { |e, i|  e - tem[i]}

a = IA::DE.initialize(limit_inf, limit_sup, pixels_gray, pixels_tem_gray)

end_pos = a[:pos].each_with_index.map { |e, i|  e + tem[i]}

puts "Plantilla encontrada de la coordenada #{a[:pos]} a la coordenada #{end_pos}"
puts "con costo #{a[:costo]}"

# image = Magick::Image.read("Image_1.bmp").first
# gc = Magick::Draw.new
# gc.stroke = 'white'
# gc.fill = 'white'
# # gc.rectangle a[:pos][0], a[:pos][1], (a[:pos][0] + template.width), (a[:pos][1] + template.height)
# gc.rectangle a[:pos][0], a[:pos][1], end_pos[0], end_pos[1]
# gc.draw(image)
# image.write "result.jpg"


# fitnes 0.9527371937105861
# (262, 290)
# (325, 372)
