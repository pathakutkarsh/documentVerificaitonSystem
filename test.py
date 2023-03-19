email = ['vijay@gmail.com', 'swapnil@hotmail.com','nitesh@yahoo.com', 'kanav@gmail.com','mayur@gmail.com','raj@hotmail.com','rahul@yahoo.com','sanjay@rediffmail.com','krishna@hotmail.com','gaurav@gmail.com']
outputDictonary={}
test = 'abd@gmail.com'
for i in range(len(email)):
    if(email[i].split('@')[1] not in outputDictonary):

        outputDictonary[email[i].split('@')[1]] = 1
    else:
         outputDictonary[email[i].split('@')[1]] = outputDictonary.get(email[i].split('@')[1])+1
for j in outputDictonary:
    print(j.split('.')[0] ,'-',outputDictonary[j])