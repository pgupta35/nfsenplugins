Testing Plugins which are created to test the system while installing NfSen. this plugins are used to test if we can store all the data in database or not. This works on the following process simultaneously.

  1. File collector -> (nfcapd)
  1. file reader ->(nfdump)
  1. output to database -> (nfsen backend plugin)
  1. output from database to web interface (nfsen frontend plugin)