{-#LANGUAGE LambdaCase#-}
import Control.Monad
import Data.List

main = do
  print =<< ap ((,) . solve1) solve2 . words <$> readFile "inp5.txt"

solve1 = maximum . solveGen
solve2 = gap . sort . solveGen

solveGen =  map (uncurry ((+) . (8 *))) . uncurry zip . ap ((,) . map row) (map seat)
  where
    row  = fst . foldl range (0,127) . take 7
    seat = fst . foldl range (0,7)   . drop 7

range :: (Int,Int) -> Char -> (Int,Int)
range (x,y) = let d = div (y-x) 2 in \case
  'F' -> (x,x+d)
  'B' -> (x+d+1,y)
  'L' -> (x,x+d)
  'R' -> (x+d+1,y)

gap :: [Int] -> Int
gap (x:y:xs) = if x+1 /= y then x+1 else gap (y:xs)
