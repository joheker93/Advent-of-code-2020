import Data.List.Split
import Data.List


main = do
  print =<< ((,) <$> solve1 <*>  solve2)  . splitWhen (=="") . lines <$> readFile "inp6.txt"

solve1 = sum . map (length . nub . concat)
solve2 = sum . map (length . foldr1 intersect)
