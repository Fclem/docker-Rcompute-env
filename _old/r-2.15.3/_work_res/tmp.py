#!/usr/bin/python
f = open('setlibs.txt')
cnt=0
i = 0
buff = ''
exe = ''
for each in f.readlines():
	
	if i == 0:
		buff = ''
	if each.strip().replace('\n', '')!= '':
		buff += each.replace('RUN R', 'R').replace('; exit 0', '')
		i+=1
	if i==10:
		i=0
		buff = '#!/bin/bash\n%s' % buff
		name = 'lib_p%s.sh' % cnt
		open('out/%s' % name, 'w').write(buff)
		exe+='RUN %s;exit 0\n' % name
		cnt+=1

print exe

