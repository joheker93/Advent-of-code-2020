{-#LANGUAGE FlexibleContexts#-}


main :: IO ()
main = do
  print =<<  solve1 <$> lines <$> readFile "inp3.txt"


solve1 :: [String] -> Int
solve1 inp = f $ (pather (g inp) (h inp) (l inp) 0 1 3)

solve2 :: [String] -> Int
solve2 inp = let g_n = [j | (i,j) <- zip [0..] inp, even i]
                 p_app  = (f .) . pather (g inp) (h inp) (l inp) 0
                 p_app2 = (f .) . (pather (g g_n) (h g_n) (l inp) 0)
                 ps = [p_app 1 1,p_app 1 3,p_app 1 5,p_app 1 7, p_app2 1 1]
                 in foldl1 (*) ps

pather g h l i d r | i >= h = []
                   | otherwise = g !! (pos i l d r) : pather g h l (i+1) d r
 where pos x l d r = l*x + r*x `mod` l

-- Aux

h = length
l = length . head
g = concat
f = length . filter (=='#')



