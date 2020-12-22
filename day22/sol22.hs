import Data.List

main = print =<< ((,) <$> solve1 <*> solve2) . p . lines <$> readFile "inp22.txt"

solve1 = count . uncurry play
solve2 = count . snd . uncurry (play2 [])
count = sum . zipWith (*) [1..] . reverse

p = (,) <$> reads . drop 1 . takeWhile (/="") <*> reads . drop 1. dropWhile (/="Player 2:")
  where reads = map (read :: String -> Int)

play [] ys = ys
play xs [] = xs
play (x:xs) (y:ys) | x > y = play (xs ++ [x,y]) ys
                   | y > x = play xs (ys ++ [y,x])


data Winner = P1 | P2 deriving Show

play2 _ [] ys = (P2,ys)
play2 _ xs [] = (P1,xs)
play2 t p1@(x:xs) p2@(y:ys)
  | elem p1 t || elem p2 t = (P1,p1)
  | x <= length xs && y <= length ys = case recursiveCombat [] (take x xs) (take y ys)  of
      P1 -> p1wins
      P2 -> p2wins
  | x > y = p1wins
  | x < y = p2wins
  where
    p1wins = play2 (p1 : p2 : t) (xs ++ [x,y]) ys
    p2wins = play2 (p1 : p2 : t) xs (ys ++ [y,x])

recursiveCombat  = ((fst .) .) . play2
