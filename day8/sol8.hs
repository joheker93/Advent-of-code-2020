
main = print =<< ((,) <$> solve1 <*> solve2) . map p . lines <$> readFile "inp8.txt"

solve1 = run 0 [] 0
solve2 = uncurry (try (run 0 [] 0 )) . ((,) <$> id <*> length)

-- Run a sequence of instructions until a loop is found or it terminates
-- and return the acc value
run :: Int -> [Int] -> Int -> [([Char], Int)] -> ([Char], Int)
run n p a xs =
  if n `elem` p
  then ("loop", a)
  else (if n < (length xs) then
          (let (n', a') = go (xs !! n) (n, a) in run n' (n : p) a' xs)
        else ("terminated", a))
  where
    go ("acc", x) (n, a) = (n + 1, a + x)
    go ("jmp", x) (n, a) = (n + x, a)
    go ("nop", _) (n, a) = (n + 1, a)

-- Try different combinations of replacements and return at first occurance
-- of a terminating program
try :: ([(String, b)] -> (String, b)) -> [(String, b)] -> Int -> (String, b)
try f xs i =
  let l = zipWith newList (replicate i xs) [1..]
  in head . filter ((== "terminated") . fst) $ map f l
  where
    newList xs i = at i (c (xs !! i)) xs

    at _ _ [] = []
    at 0 y (x : xs) = y : xs
    at n y (x : xs) = x : at (n -1) y xs

    c ("jmp", i) = ("nop", i)
    c ("nop", i) = ("jmp", i)
    c x = x

---- PARSING ----
p :: String -> (String, Int)
p = ((,) <$> head <*> r . i . tail) . words
  where
    r = read :: String -> Int
    i = (\i'@(x : xs) -> if x == '+' then xs else i') . head
