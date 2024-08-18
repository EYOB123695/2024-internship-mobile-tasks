n,m = map(int,input().split())
arr = list(map(int,input().split()))
arrtwo = list(map(int,input().split()))
arr.sort()
arrtwo.sort()
ans = [0] *(len(arrtwo))
l = 0 
r = 0 
while l < len(arr) and r < len(arrtwo):
    if arr[l] >= arrtwo[r]:
        ans[r] = l 
        x = l 
        r += 1
    else:

        l+=1 


while r < len(arrtwo):
    ans[r] = l
    r+=1
res = [str(x) for x in ans] 
print(" ". join(res))
    
    


