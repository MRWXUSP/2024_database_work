# -*- coding: utf-8 -*-

# @description: 提供通用数据库模块接口


import sys
import os 
sys.path.append(os.path.abspath(os.path.dirname(__file__)+'/'+'..'))

from BACK.util import getTerm
from BACK.score import (tranScore, getScore, getClassLists, updateStuScore, drawCourseScore)
from BACK.course import (showSelectCourse)