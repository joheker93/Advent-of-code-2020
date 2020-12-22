import Data.List

import Control.Lens
import Data.Tuple (swap)


main = do
  pars <- ps . lines <$> readFile "inp20.txt"
  let solve1 = product
               . map (getTiles . snd)
               . take 4
               . sort
               . map swap
               . map (pretty . foldVals)
               . sort
                .map sort
                . (map <$> flip countMatches <*> id)

  print (solve1 pars)

-- ##AUXILARIES FOR PART1
getTiles = (read :: String -> Int) . takeWhile (/=':') . drop 1 . dropWhile (/=' ')
pretty (i,v,_) = (i,v)
foldVals xs = foldl1 (\(i,v,i2) (i',v2,i2')-> (i,v+v2,i2)) xs
countMatches (M id x) xs = map (\(i',el) ->  if length (intersect (allRots x) el) > 0 then (id,1,i') else (id,0,i')) xsElems
  where
    xsElems = map (\(M i ys) -> (i,allRots ys)) xs

-- ##BORDERS AND ROTATIONS
flipMat = reverse
rot = transpose . reverse

allRots = concatMap (^..each) . ((:) <$> ((,,,,,,,) <$> r1 <*> r2 <*> r3 <*> r4 <*> r5 <*> r6 <*> r7 <*> r8) <*> const [])
  where
    r1 = get
    r2 = get . rot
    r3 = get . rot . rot
    r4 = get . rot . rot . rot
    r5 = get . flipMat
    r6 = r2 . flipMat
    r7 = r3 . flipMat
    r8 = r4 . flipMat
    get = flip (!!) 0 



-- ## PARSING
data Mats = M String [String] deriving Show

ps s = case p s of
  (s,l,[]) -> [M s l]
  (s,l,xs) -> M s l : ps xs 


p = (,,)
  <$> concat . take 1
  <*> drop 1 . takeWhile (/="")
  <*> drop 1 . dropWhile (/="")
