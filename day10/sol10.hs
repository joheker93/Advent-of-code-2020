import Data.List
main = print =<< ((,) <$> (solve1 . drop 1) <*> solve2)
  . sort
  . (0:)
  . ((:) <$> (+3) . maximum <*> id)
  .  map (read :: String -> Int)
  . lines <$> readFile "inp10.txt"


solve1 :: [Int] -> Int
solve1 = ((*) <$> fst <*> snd) . trav 0 (0,0)
  where
    trav _ t [] = t
    trav i (o,t) (x:xs) | x == i+1 = trav (i+1) (o+1,t) xs
                        | x == i+3 = trav (i+3) (o,t+1) xs

solve2 :: [Int] -> Int
solve2 = foldr1 (*) . map t . group . diffs
  where
    diffs  = zipWith (-) =<< tail
    t xs = let x = head xs in if x == 3 then 1 else tribs (length xs)
    tribs 1 = 1
    tribs 2 = 2
    tribs 3 = 4
    tribs n = tribs (n-1) + tribs (n-2) + tribs (n-3)

