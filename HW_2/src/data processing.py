import csv as csv
import numpy as np
csv_file_object = csv.reader(open('train.csv', 'r'))
header=csv_file_object.__next__()
data=[] 
t=0												# Create a variable to hold the data

# for row in csv_file_object:# Skip through each row in the csv file,
# 	if row[5]<'10':
# 		row[5]='kid'
# 	elif row[5]<'20':
# 		row[5]='teenager'
# 	else:
# 		row[5]='elder'
for row in csv_file_object:
	data.append(row[0:])
    # t=t+1 								
data = np.array(data)
t=np.size(data[0::,1].astype(np.float)) 
for i in range(t):
	if data[i][1]=='0':
		data[i][1]='notSurvived'
	else:
		data[i][1]='Survived'
	if data[i][2]=='1':
		data[i][2]='low'
	elif data[i][2]=='2':
		data[i][2]='mid'
	else:
		data[i][2]='high'
	if data[i][5]<'10':
		data[i][5]='kid'
	elif data[i][5]<'20':
 		data[i][5]='teenager'
	elif data[i][5]<'40':
 		data[i][5]='youth'
	elif data[i][5]<'60':
 		data[i][5]='midage'
	else:
 		data[i][5]='elder'
	if data[i][6]=='1':
 		data[i][6]='has'
	else:
 		data[i][6]='nohas'
	if data[i][9]<'20':
 		data[i][9]='poor'
	elif data[i][9]<'50':
 		data[i][9]='midclass'
	elif data[i][9]<'100':
 		data[i][9]='rich'
	else:
 		data[i][9]='superrich'

	#print(data[i][5])								
#print(data)
data1=[]
for i in range(t):
	data1.append([data[i][1],data[i][2],data[i][4],data[i][5],data[i][6],data[i][9]])
data1=np.array(data1)
#print(data1)
pre_data_file=open("pre_data.csv","w")
pre_data_file_object=csv.writer(pre_data_file)
pre_data_file_object.writerow(["Survived","PClass","Sex","Age","SibSp","Fare"])
pre_data_file_object.writerows(data1)
# for i in range(t):
# 	pre_data_file_object.writerow(data1[i])
pre_data_file.close()


