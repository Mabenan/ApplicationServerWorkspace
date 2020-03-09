python
import sys 
import os
sys.path.append(os.path.abspath('./debug'))
from qt_printers_gdb import register_qt_printers
register_qt_printers (None)
end
set print pretty 1