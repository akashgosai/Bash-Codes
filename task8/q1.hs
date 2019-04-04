insertAt :: a -> [a] -> Int -> [a]
insertAt x ls n = take (n-1) ls ++ [x] ++ drop (n-1) ls

incrrange :: Num t => [t] -> (Int, Int) -> [t]
incrrange ls r =  take ((fst r)-1) ls ++ [x+1 | x <- (take ((snd r)-(fst r)+1) (drop ((fst r)-1) ls))] ++ drop (snd r) ls

combination :: Eq a => Int -> [a] -> [[a]]
combination 0 _ = [[]]
combination _ [] = []
combination n (x:ls) = (map (x:) (combination (n-1) ls)) ++ (combination n ls)

unique :: Eq a => [a] -> [a]
unique [] = []
unique (x:ls) = x:unique (filter ((/=) x) ls)

combinations :: Eq a => Int -> [a] -> [[a]]
combinations n ls = unique (combination n ls) 

