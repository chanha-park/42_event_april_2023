{-# OPTIONS_GHC -Wall -Wextra #-}

import Control.Monad
import System.Environment

main :: IO ()
main = do
    args <- getArgs
    when (length args == 1) (putStr . unlines . sastantua . readInt $ head args)

sastantua :: Int -> [String]
sastantua size
    | size <= 0 = []
    | otherwise = sastantua' (bottomWidth size) size

sastantua' :: Int -> Int -> [String]
sastantua' maxWidth 1 = makeFloor maxWidth 1
sastantua' maxWidth currFloor = sastantua' maxWidth (currFloor - 1) <> makeFloor maxWidth currFloor

makeFloor :: Int -> Int -> [String]
makeFloor maxWidth currFloor = map (makeLine maxWidth currFloor) [1 .. floorHeight currFloor]

makeLine :: Int -> Int -> Int -> String
makeLine maxWidth currFloor nth
    | (maxWidth == bottomWidth currFloor)
        && (floorHeight currFloor - nth < doorSize currFloor) =
        spaces <> "/" <> starsWithDoor <> "\\"
    | otherwise = spaces <> "/" <> stars <> "\\"
  where
    currWidth = topWidth currFloor + 2 * (nth - 1)
    spaces = replicate (div (maxWidth - currWidth) 2) ' '
    stars = replicate (currWidth - 2) '*'
    starsWithDoor = replicate (div (currWidth - doorSize currFloor - 2) 2) '*' <> doors <> replicate (div (currWidth - doorSize currFloor - 2) 2) '*'
    doors =
        if doorSize currFloor >= 5 && nth == floorHeight currFloor - div (doorSize currFloor) 2
            then replicate (doorSize currFloor - 2) '|' <> "$|"
            else replicate (doorSize currFloor) '|'

readInt :: String -> Int
readInt = read

topWidth :: Int -> Int
topWidth 1 = 3
topWidth n = bottomWidth (n - 1) + 2 * (2 + div n 2)

bottomWidth :: Int -> Int
bottomWidth n = topWidth n + 2 * (n + 1)

floorHeight :: Int -> Int
floorHeight = (+ 2)

doorSize :: Int -> Int
doorSize n = 1 + 2 * div (n - 1) 2
