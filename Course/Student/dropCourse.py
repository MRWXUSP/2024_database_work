# -*- coding: utf-8 -*-

# 说明：这是退课窗口应用程序，使用 PyQt5 库创建图形用户界面


from PyQt5 import QtWidgets, QtCore, QtGui
from PyQt5.QtCore import Qt, QSize
from PyQt5.QtWidgets import (QMainWindow, QWidget, QDialog, QStackedWidget,
                QGridLayout, QVBoxLayout, QHBoxLayout, QFormLayout,
                QLabel, QLineEdit,
                QFrame,
                QTableWidget,
                QTableView,
                QRadioButton,
                QPushButton, QMessageBox, 
                QAction, QApplication)
from PyQt5.QtGui import QFont, QIcon, QPixmap

import sys
import os 
sys.path.append(os.path.abspath(os.path.dirname(__file__)+'/'+'..'))
import sip
import util

usr = 1102
term = '2024-2025学年冬季'

'''
DropCourse 类继承自 QWidget，
用于创建退课窗口
构造函数初始化用户 ID 和学期，并调用 initUI 方法初始化界面。
'''
class DropCourse(QWidget):

    def __init__(self, usr=None, term=None):
        super().__init__()
        self.usr = usr
        self.term = term 
        self.initUI()

    def initUI(self):

        self.centerLayout = QVBoxLayout(self)
        self.msg = QLabel(self)
        self.rownum = 0
        self.showtable = None
        self.rbtns = []
        self.setLayout(self.centerLayout)

        self.createCenterTable(util.showSelectCourse(self.usr, self.term))
#当前显示的课程表和相关控件
    def delCenterTable(self):
        if self.msg.text() != '':
            self.centerLayout.removeWidget(self.msg)

        if self.rownum > 0 and self.showtable is not None:
            self.centerLayout.removeWidget(self.showtable)
            sip.delete(self.showtable)
            self.centerLayout.removeWidget(self.bottom)
            sip.delete(self.bottom)
            self.rbtns = []
            self.rownum = 0

    def createCenterTable(self, data):
        self.delCenterTable()
        if len(data) == 0:
            self.msg.setText('本学期您尚未选课')
            self.msg.setAlignment(Qt.AlignCenter)
            self.centerLayout.addWidget(self.msg)
            return None
        
        self.rownum = len(data)
        self.showtable = QTableWidget(self.rownum, 6)  
        self.showtable.setHorizontalHeaderLabels(['', '课程号', '课程名', '教师号', '教师', '上课时间'])
        self.rbtns = []
        for i in range(self.rownum):
            self.rbtns.append(QRadioButton())
            self.showtable.setCellWidget(i, 0, self.rbtns[i])
            for j in range(1, 6):
                self.showtable.setItem(i, j, QtWidgets.QTableWidgetItem(data[i][j-1]))
        
        #设置水平方向表格为自适应的伸缩模式
        self.showtable.horizontalHeader().setSectionResizeMode(QtWidgets.QHeaderView.Stretch)
        # 将表格变为禁止编辑
        self.showtable.setEditTriggers(QtWidgets.QAbstractItemView.NoEditTriggers)
        # 设置表格整行选中
        self.showtable.setSelectionBehavior(QtWidgets.QAbstractItemView.SelectRows)

        self.centerLayout.addWidget(self.showtable)
        
        self.selectbtn = QPushButton('确认退课')
        self.selectbtn.setIcon(QIcon('./image/exit.png'))
        self.selectbtn.clicked.connect(self.onSelect)
        #self.bottom 是一个新的 QWidget 对象，用于包含水平布局和按钮控件。
        self.bottom = QWidget()
        #hbox 是一个 QHBoxLayout 对象，用于水平排列控件。
        hbox = QHBoxLayout()
        #添加了弹性空间
        hbox.addStretch(1)
        hbox.addStretch(1)
        hbox.addStretch(1)
        hbox.addWidget(self.selectbtn)
        #添加按钮控件
        hbox.addStretch(1)
        hbox.addStretch(1)
        hbox.addStretch(1)
        self.bottom.setLayout(hbox)

        self.centerLayout.addWidget(self.bottom)
    '''
    onSelect 方法处理退课操作，
    检查用户选择的课程，
    并调用 util.dropSelectCourse 方法退课。
    如果退课成功，更新课程表。
    '''
    def onSelect(self):
        
        for i in range(self.rownum):
            if self.rbtns[i].isChecked() == True:
                reply = QMessageBox.question(self, '提示', '确认退课', QMessageBox.Yes | QMessageBox.No, QMessageBox.Yes)
                if reply == QMessageBox.No:
                    return None
                kh = self.showtable.item(i, 1).text()
                gh = self.showtable.item(i, 3).text()
                flag = util.dropSelectCourse(self.usr, self.term, kh, gh)
                if flag == True:
                    QMessageBox.information(self, '恭喜', '退课成功', QMessageBox.Yes)
                    self.rbtns.remove(self.rbtns[i])
                    self.showtable.removeRow(i)
                    self.rownum = self.rownum - 1
                    if self.rownum == 0:
                        self.createCenterTable([])
                return None
        QMessageBox.warning(self, 'warning', '对不起你没有选择任何课程', QMessageBox.Yes)

if __name__ == "__main__":
    #创建应用程序对象
    app = QApplication(sys.argv)
    #创建一个 QApplication 对象
    dropCourse = DropCourse(usr=usr, term=term)
    dropCourse.resize(700, 350)
    dropCourse.show()
    #动应用程序事件循环
    sys.exit(app.exec_())
