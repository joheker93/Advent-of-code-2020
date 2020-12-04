{-#LANGUAGE LambdaCase#-}
import Data.List.Split
import Text.Parsec
import Data.List
import Data.Char


-- Self-documenting code ofc

main = do
  ps <- map Person . ps . p  <$> lines <$> readFile "inp4.txt"
  let sol1 = filter solve1 ps
  let sol2 = filter solve2 sol1
  print $ (length sol1, length sol2)

solve1 :: Person -> Bool
solve1 (Person xs) | length xs == 8 = True
                   | otherwise = length xs == 7 && length [x | (Cid x) <- xs] == 0

solve2 :: Person -> Bool
solve2 (Person xs) = and $ map validPartial xs

validPartial :: PartialInfo -> Bool
validPartial = \case
  BYear i   -> i <= 2002 && i >= 1920
  IYear i   -> i <= 2020 && i >= 2010
  ExpYear i -> i <= 2030 && i >= 2020
  Height s  -> case dropWhile isDigit s of
    "in" -> r s >= 59  && r s <= 76
    "cm" -> r s >= 150 && r s <= 193
    _ -> False
  HColour s -> case head s of
    '#' -> length (tail s) == 6 && val (tail s)
    _   -> False
  EColour s -> valEye s
  Pid s     -> all isDigit s && length s == 9
  Cid s     -> True
 where
   r       = read . takeWhile isDigit
   val     = and  . map valChar
   valChar = flip elem "abcdefg0123456789"
   valEye  = flip elem ["amb","blu","brn","gry","grn","hzl","oth"]


---- PARSING ----

data Person = Person [PartialInfo] deriving Show
data PartialInfo = BYear   Int
                 | IYear   Int
                 | ExpYear Int
                 | Height  String
                 | HColour String
                 | EColour String
                 | Pid     String
                 | Cid     String deriving Show

type P = ([String],[String])

ps :: P -> [[PartialInfo]]
ps ([],_) = []
ps (h,[]) = map toPartial h : []
ps (h,t)  = map toPartial h : ps (p t)

p :: [String] -> P
p = (,) <$> concatMap words . takeWhile (/= "") <*> drop 1 . dropWhile (/= "")

toPartial :: String -> PartialInfo
toPartial = take 3 >>= \case
  "byr" -> BYear   . r
  "iyr" -> IYear   . r
  "eyr" -> ExpYear . r
  "hgt" -> Height  . d
  "hcl" -> HColour . d
  "ecl" -> EColour . d
  "pid" -> Pid     . d
  "cid" -> Cid     . d
 where
   r = read . d
   d = drop 4
