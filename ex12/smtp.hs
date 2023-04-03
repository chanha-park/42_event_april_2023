{-# OPTIONS -Wall -Wextra #-}
{-# LANGUAGE OverloadedStrings #-}

import Data.Text.Internal qualified
import Data.Text.Lazy qualified
import Network.HaskellNet.Auth
import Network.HaskellNet.SMTP
import Network.HaskellNet.SMTP.SSL
import Network.Mail.Mime

-- | Your settings
server :: String
server = "smtp.naver.com"

-- port         = toEnum 587

username :: Network.HaskellNet.Auth.UserName
username = "foo"

password :: Network.HaskellNet.Auth.Password
password = "bar"

authType :: Network.HaskellNet.Auth.AuthType
authType = Network.HaskellNet.Auth.PLAIN

from :: Network.Mail.Mime.Address
from = "foo@bar.com"

to :: Network.Mail.Mime.Address
to = "hello@world.com"

subject :: Data.Text.Internal.Text
subject = "Network.HaskellNet.SMTP Test :)"

plainBody :: Data.Text.Lazy.Text
plainBody = "Hello world!"

htmlBody :: Data.Text.Lazy.Text
htmlBody = "<html><head></head><body><h1>Hello <i>world!</i></h1></body></html>"

attachments :: [(Data.Text.Internal.Text, FilePath)]
attachments = [("application/zip", "~/Downloads/attachments.zip"), ("text/plain", "./smtp.hs")]

-- | With authentication
main :: IO ()
main = doSMTPSTARTTLS server $ \conn -> do
    authSuccess <- authenticate authType username password conn
    if authSuccess
        then do
            mail <- simpleMail to from subject plainBody htmlBody attachments
            sendMail mail conn
        else putStrLn "Authentication failed."
