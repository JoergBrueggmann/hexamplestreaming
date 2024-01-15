module Lib
    (
        main
    ) where


import qualified System.IO as Sys
import qualified System.IO.Echo as Sys
import Streaming.Prelude as S
import Streaming as S


main :: IO ()
main = 
    do
        Sys.setInputEcho False
        Sys.hSetBuffering Sys.stdout Sys.NoBuffering
        -- may be not needed:
        --Sys.hSetBuffering Sys.stdin Sys.NoBuffering
        S.mapM_ putChar $ showStream $ S.mapM check $ S.each ["12", "34", "56"]
        putStrLn ""

check :: String -> IO String
check s = 
    do
        l <- getLine
        pure (l ++ (if l == s then "==" else "/=") ++ s)

showStream :: (Show a, Monad m) => Stream (Of a) m r -> Stream (Of Char) m r
showStream xs = 
    do
        S.yield '['
        r <- S.intercalates (S.each ", ") $ S.maps (\(x :> r) -> r <$ S.each (Prelude.show x)) xs
        S.yield ']'
        pure r
