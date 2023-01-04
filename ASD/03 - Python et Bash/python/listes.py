tab = ["pain", "orange", "eau", "fruit", "legume"]
for x in tab:
    print(x)




tab_a = [15,20,5,14,1,0,19,26,4,6,5]
tab_b = [3,26,18,3,7,6,9,20,8,1,23]
loop=0
newList=[]
for x in tab_a:
    if x > tab_b[loop]:
        newList.append(x)
    else:
        newList.append(tab_b[loop])
    loop=loop+1
print("Les plus grands sont :", newList)



serie_a = [1,5,1,6,8,4,5,9,5,6,1,1,4,7,6,2,5,6,0,0,7,8,5,6,1,2]
exo1=sorted(serie_a)
print(exo1)

currentLoop=0
maxLoop=9
while currentLoop <= maxLoop:
    count= serie_a.count(currentLoop)
    print(currentLoop, 'apparait : ', count)
    currentLoop=currentLoop+1
