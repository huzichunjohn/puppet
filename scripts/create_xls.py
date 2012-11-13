#!/bin/env python
import xlwt

workbook = xlwt.Workbook()
sheet = workbook.add_sheet("server infomation")
sheet.write(0,0,"server")
sheet.write(0,1,"idc")
sheet.write(0,2,"ip address")
workbook.save("server.xls")
