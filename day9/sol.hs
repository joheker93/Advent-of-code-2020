{-# LANGUAGE LambdaCase#-}
import Data.List

main = do
  print =<< ((,) <$> solve1 <*> solve2) . map read . words <$> readFile "inp9.txt"

solve1 = snd . run
solve2 i = let s = solve1 i
               r = filter (<=s) i
               m = sort . head . filter (\y -> sum y == s) $ subSeq r
           in head m + last m
 where subSeq = concat . map inits . tails

run = (f <$> t <*> d ) >>= \case
  [] -> (,) <$> t <*> d
  _  -> run . tail
  where
    f xs x = [True | y <- xs, z <- xs, z+y == x]
    d = head . drop 25
    t = take 25



