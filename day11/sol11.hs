{-#LANGUAGE LambdaCase#-}
import Data.Matrix (fromList,fromLists,(!),mapPos,nrows,getRow,getCol,getDiag)
import Control.Monad
main = print =<< ((,) <$> solve1 <*> solve2) . fromLists . lines <$> readFile "inp11.txt"

solve1 = occs . run "p1"
solve2 = occs . run "p2"
occs = sum . mapPos (\_ x -> if x == '#' then 1 else 0)
run p mat = if new == mat then new else run p new
  where
    new = mapPos (\(r,c) a -> satisfied r c mat a p) mat

    satisfied x y mat 'L' "p1"= if length (sats x y mat) == 0  then '#' else 'L'
    satisfied x y mat '#' "p1"= if length (sats x y mat) >= 4 then 'L' else '#'
    satisfied x y mat 'L' "p2"= if length (sats2 x y mat) == 0 then '#' else 'L'
    satisfied x y mat '#' "p2"= if length (sats2 x y mat) >= 5 then 'L' else '#'
    satisfied _ _ _ x _= x

    sats x y mat = filter (=='#') [mat ! x | x <- neighs x y mat]
    sats2 x y mat = filter (=='#') (n2 (x,y) mat)

    neighs x y mat = inside $ filter (/=(x,y)) $ map (\[x',y'] -> (x+x',y+y')) $ replicateM 2 [-1,0,1]
    inside = filter (\(x,y) -> x > 0 && x <= nrows mat && y > 0 && y <= nrows mat)

n2 p mat = [chaseSlope p 0 1       mat
           ,chaseSlope p 1 0       mat
           ,chaseSlope p 1 1       mat
           ,chaseSlope p (-1) (-1) mat
           ,chaseSlope p 1 (-1)    mat
           ,chaseSlope p (-1) 1    mat
           ,chaseSlope p (-1) 0    mat
           ,chaseSlope p 0 (-1)    mat]
  where indices = [(x,y) | x <- [1..nrows mat], y <- [1..nrows mat]]

chaseSlope (x,y) dx dy mat = case (x+dx > (nrows mat))  || (y+dy > (nrows mat)) || x+dx < 1 || y+dy < 1 of
  True -> '.'
  _    -> if mat ! chase == '#' then '#' else if mat ! chase == 'L' then 'L' else chaseSlope chase dx dy mat
  where chase = (x+dx,y+dy)



