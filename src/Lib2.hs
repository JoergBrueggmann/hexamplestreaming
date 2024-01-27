module Lib2
    (
        main
    ) where


import qualified System.IO as Sys
import qualified System.IO.Echo as Sys
import qualified Streaming.Prelude as SP ( each, Of(..), yield, mapM, mapM_, maps )
import qualified Streaming as S ( Stream, intercalates )


main :: IO ()
main = 
    do
        Sys.setInputEcho False
        Sys.hSetBuffering Sys.stdout Sys.NoBuffering
        -- may be not needed:
        --Sys.hSetBuffering Sys.stdin Sys.NoBuffering
        SP.mapM_ putChar f
        --SP.mapM_ putChar $ showStream $ SP.mapM check $ SP.each ["12", "34", "56"]
        putStrLn ""

f :: Monad m => S.Stream (SP.Of Char) m ()
f = 
    do
        SP.yield '1'
        SP.yield '2'
        SP.yield '3'

check :: String -> IO String
check s = 
    do
        l <- getLine
        pure (l ++ (if l == s then "==" else "/=") ++ s)

showStream :: (Show a, Monad m) => S.Stream (SP.Of a) m r -> S.Stream (SP.Of Char) m r
showStream xs = 
    do
        SP.yield '['
        r <- S.intercalates (SP.each ",") $ SP.maps (\(x SP.:> r) -> r <$ SP.each (Prelude.show x)) xs
        SP.yield ']'
        pure r
