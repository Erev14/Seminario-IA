function [ p ] = penalizacion( x,xl,xu )
  p = x;

  if x(1)>xl(1) && x(1)<xu(1)
    p(1) = x(1);
  else
    p(1) = xl(1)+(xu(1)-xl(1))*rand;
  end

  if xl(2)<x(2) && x(2)<xu(2)
    p(2) = x(2);
  else
    p(2) = xl(2)+(xu(2)-xl(2))*rand;
  end
