Success = Struct.new(:succesful?, :failed?, :result, keyword_init: true)
Failure = Struct.new(:succesful?, :failed?, :errors, keyword_init: true)

