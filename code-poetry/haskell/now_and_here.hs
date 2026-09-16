import Data.Time.Clock (getCurrentTime)
import GHC.Stack (currentCallStack)

nowAndHere :: IO (UTCTime, [String])
nowAndHere = (,) <$> getCurrentTime <*> currentCallStack
