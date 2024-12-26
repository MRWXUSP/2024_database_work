# -*- coding: utf-8 -*-

# @description: 提供通用数据接口模块

import sys
import os 
sys.path.append(os.path.abspath(os.path.dirname(__file__)+'/'+'..'))

from BACK.util import getclasstime
from BACK.course import (searchCourse, selectCourse, dropSelectCourse, showSelectCourse, finishedCourse)
from BACK.course import (openCourse, delOpenCourse)
