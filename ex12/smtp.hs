{-# LANGUAGE OverloadedStrings #-}
{-# OPTIONS_GHC -Wall -Wextra #-}

import Data.Maybe
import Data.Text qualified
import Data.Text.IO qualified
import Data.Text.Lazy.IO qualified
import Network.HaskellNet.Auth qualified
import Network.HaskellNet.SMTP
import Network.HaskellNet.SMTP.SSL
import Network.Mail.Mime
import System.Console.Haskeline

-- | Your settings
server :: String
server = "smtp.naver.com"

authType :: Network.HaskellNet.Auth.AuthType
authType = Network.HaskellNet.Auth.PLAIN

mysettings :: System.Console.Haskeline.Settings IO
mysettings = defaultSettings{historyFile = Nothing}

attachments :: [(Data.Text.Text, FilePath)]
attachments = [("text/plain", "./smtp.hs")]

getAddr :: IO Network.Mail.Mime.Address
getAddr = Network.Mail.Mime.Address Nothing <$> Data.Text.IO.getLine

main :: IO ()
main = do
    putStr "naver login id: "
    username <- getLine
    password <- runInputT mysettings (getPassword (Just '*') "login password: ")

    let fromAddr = username <> "@naver.com"
    putStrLn ("sender address: " <> fromAddr)

    let from = Network.Mail.Mime.Address Nothing . Data.Text.pack $ fromAddr

    putStr "reciever address: "
    to <- getAddr

    putStrLn "title:"
    subject <- Data.Text.IO.getLine
    putStrLn "content:"
    htmlBody <- Data.Text.Lazy.IO.getLine

    doSMTPSTARTTLS server $ \conn -> do
        authSuccess <- authenticate authType username (fromJust password) conn
        if authSuccess
            then do
                mail <- simpleMail to from subject "" htmlBody attachments
                sendMail mail conn
            else putStrLn "Authentication failed."
