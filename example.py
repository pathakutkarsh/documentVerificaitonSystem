def RotateStringBykStep(str,k):
    temp1 = str.split(' ')
    temp2=[]
    for i in range (k,len(temp1)):
	    temp2.append(temp1[i])

    for j in range(0,k):
        temp2.append(temp1[j])
    return temp2.join
print(RotateStringBykStep('hello world',1))