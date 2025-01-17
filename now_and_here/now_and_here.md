now and here

```c
#include <time.h>

void now_and_here(time_t *now, const char **here) {
    *now = time(NULL);
    *here = __FILE__;
}
```

```smalltalk
now_and_here := Array
  with: Time now
  with: thisContext.
```

```haskell
import Data.Time.Clock (getCurrentTime, UTCTime)
import GHC.Stack (currentCallStack)

nowAndHere :: IO (UTCTime, [String])
nowAndHere = (,) <$> getCurrentTime <*> currentCallStack
```

```solidity
pragma solidity ^0.8.0;

contract NowAndHere {
    function now_and_here() public view returns (uint256, uint256) {
        return (block.timestamp, block.number);
    }
}
```

---

```ruby
def now_and_here
  Time.now, caller(0)
end
```

```js
function now_and_here() {
    return [Date.now(), new Error().stack]
}
```

```rust
use std::time::{SystemTime, UNIX_EPOCH};
use backtrace::Backtrace;

fn now_and_here() -> (SystemTime, Backtrace) {
    (SystemTime::now(), Backtrace::new())
}
```

```python
import time, inspect

def now_and_here():
    return time.time(), inspect.stack()
```

```perl
sub now_and_here {
    return (time(), [caller(0)]);
}
```
