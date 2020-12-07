{-#LANGUAGE LambdaCase#-}

import Text.Parsec
import Data.Tuple
import qualified Data.Map as M (Map,insert,empty,lookup)

main = do
  print =<< ((,) <$> solve1 <*> solve2)
    . map (\(Right x) -> x)
    . map (parse p "")
    . lines <$> readFile "inp7.txt"


solve2 ps = let e' = build swap ps
            in cost "shiny gold" e' - 1

solve1 ps = let e' = build snd ps
            in length $ filter (==True) $ map (\(Bag c _) -> reach c e') ps

build f p = foldl (\e (Bag c i) -> M.insert c (map f i) e) M.empty p

type EnvM  = M.Map String [String]
type EnvM2 = M.Map String [(String,Int)]

cost :: String -> EnvM2 -> Int
cost s e = case M.lookup s e of
  Nothing -> 1
  Just xs -> cost' xs e
 where
   cost' [] _ = 1
   cost' ((s,i):xs) e = i*(cost s e) + cost' xs e


reach :: String -> EnvM -> Bool
reach s e = case M.lookup s e of
  Nothing -> False
  Just xs -> case elem "shiny gold" xs of
    True -> True
    False -> reach' xs e
 where
   reach' [] _ = False
   reach' (x:xs) e = reach' xs e  || reach x e


---- PARSING ----
data Bag = Bag Colour [(Int,String)] deriving Show

type Colour = String

type BagP a = Parsec String () a

p :: BagP Bag
p = do
  col <- p_col
  string " bags contain "
  inc <- optionMaybe p_inc
  case inc of
    Nothing -> return $ Bag col []
    Just r -> return $ Bag col r


p_inc :: Parsec String () [(Int,String)]
p_inc = do
  skipMany space
  nr  <- (read :: String -> Int) <$> many1 digit 
  char ' '
  col <- p_col
  char ' '
  many1 letter
  sep <- char ',' <|> char '.'
  case sep of
    '.' -> return $ (nr,col) : []
    ',' -> do
      p2 <- many space >> p_inc
      return $ (nr,col) : p2

p_col :: Parsec String () Colour
p_col = many1 letter >>= \l -> spaces >> many1 letter >>= return . (l ++ ) . (' ' : )

