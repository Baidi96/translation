#!/usr/bin/python
import re

p1 = re.compile("[a-zA-Z]\w*\'?:[a-zA-Z]\w*\'?$") #X;S
p2 = re.compile("\A\\\\[a][n][d](.+)$") #phi1 /\ phi2
p3 = re.compile("\A\\\\[n][o][t](.+)$") #not(phi)
p4 = re.compile("\A\\\\[e][x][i][s][t][s](.+)$") #exists x:s,phi
p5 = re.compile("\A\\\\?[a-zA-Z]+(.+)$") #app(phi1,pih2,...,phin)
#pattern = str(raw_input("Enter a pattern :"))

def lift(str):
	if p1.match(str):
		return "#variable(" + \
    	       (re.search("([a-zA-Z]\w*\'?):([a-zA-Z]\w*\'?)",line).group(1)) + \
               ",#sort(" + \
               (re.search("([a-zA-Z]\w*\'?):([a-zA-Z]\w*\'?)",line).group(2)) + \
                "))"
	elif p2.match(str):
		tmp = str[5:len(str)-2] 
		pos = tmp.index(",")
		while 1 :
			if tmp[0:pos].count('(') == tmp[0:pos].count(')'):
				return "#and(" + \
				   	lift(tmp[0:pos]) + \
				   	"," + \
				   	lift(tmp[pos+1:len(tmp)]) + \
				   	")"
			else: 
				pos = pos + tmp[pos+1:len(tmp)].index(",") + 1

	elif p3.match(str):
		return "#not(" + \
			   lift(str[5:len(str)-2]) + \
			   ")"
	elif p4.match(str):
		tmp = str[8:len(str)-2]
		return "#exists(" + \
			   (re.search("([a-zA-Z]\w*\'?):([a-zA-Z]\w*\'?),(.+)",tmp).group(1)) + \
               ",#sort(" + \
               (re.search("([a-zA-Z]\w*\'?):([a-zA-Z]\w*\'?),(.+)",tmp).group(2)) + \
			   ")," + \
			   lift((re.search("([a-zA-Z]\w*\'?):([a-zA-Z]\w*\'?),(.+)",tmp).group(3))) + \
			   ")"
	elif p5.match(str):
		pos_paren = str.index("(")
		liftList = ""
		tmp = str[pos_paren+1:len(str)-2]
		liftList = ""
		pos = tmp.index(",")
		i = 0
		t = """while pos < len(tmp) - 1 :
			if tmp[i:pos].count('(') == tmp[i:pos].count(')'):
				liftList += "," + lift(tmp[i:pos]) 
				i = pos + 1
			elif tmp[pos+1:len(tmp)].count(",") == 0 : break 
			else : pos = pos + tmp[pos+1:len(tmp)].index(",") + 1"""
		return "#application(#symbol(\"" + str[0:pos_paren] + \
				"\",#sort(...)..." + \
				liftList + \
			   ")"
	else :
		return "(" + str + ") is not pattern"

file_object = open('input.txt')
for line in file_object:
	print line 
	print lift(line)
	print "------------"

