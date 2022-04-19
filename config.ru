require_relative 'app'
require_relative 'middleware/runtime'
require_relative 'middleware/logger'
require_relative 'middleware/time'

use Runtime

use AppLogger
use AppTime
run App.new
