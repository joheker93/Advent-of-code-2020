import Data.List
import Text.Parsec
type Inf = ((Int,Int),Char,String)

par :: Parsec String () Inf
par = do
  l <- many1 digit
  char '-'
  h <- many1 digit
  char ' '
  c <- letter
  string ": "
  s <- many1 letter
  return ((read l,read h),c,s)

main :: IO Int
main = length
      . filter solve2
      . map ((\(Right x)  -> x) . parse par "")
      <$> lines <$> readFile "inp2.txt"

solve1 :: Inf -> Bool
solve1 (b,c,s) = lower && upper
  where lower = f s >= fst b
        upper = f s <= snd b
        f = length . filter (==c) 

solve2 :: Inf -> Bool
solve2 ((l,u),c,s) = lower && not upper || not lower && upper
  where
    lower = s !! (l-1) == c
    upper = s !! (u-1) == c
