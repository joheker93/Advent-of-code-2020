
sol1 :: IO Int
sol1 = do
  xs <- map (read :: String -> Int) <$> words <$> readFile "inp1.txt"
  let x = [x'*y'| x' <-xs , y' <- xs,z'<-xs , x'+y' == 2020]
  return $ (head x)



