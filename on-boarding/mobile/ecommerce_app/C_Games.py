T= int(input())
for _ in range(T):
    n = int(input())
    arr = list(map(int,input().split()))

    arr.sort()
   
    alice = 0
    bob = 0
    flag = True
    for i in range(len(arr)-1,-1,-1):
       
        if flag :
            if arr[i] % 2 == 0:
                alice += arr[i] 
            flag = False

            
        else:
            if arr[i] % 2 != 0:
                bob += arr[i]
            flag = True
  
    if alice < bob :
        print("Bob") 
    elif alice > bob:
        print("Alice")
    else:
        print("Tie") 
    

