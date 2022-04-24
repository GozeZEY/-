cover='cover.jpg';
stego='F3.jpg';
frr=fopen('msg_F3.txt','a');
try 
    jpeg_stego=jpeg_read(stego);
    dct_stego=jpeg_stego.coef_arrays{1};
catch
    error('Error');
end
len=7296;
sum=1;
[m,n]=size(dct_stego);
for f2 =1:n
    for f1 =1:m
        if(dct_stego(f1,f2)==0)
            continue;
        end
        odd=mod(dct_stego(f1,f2),2);
        fwrite(frr,odd,'ubit1');
        if(sum==len)
            break;
        end
        sum=sum+1;
        
    end
    if sum ==len
        break;
    end
end
fclose(frr);
            
            
        
            
            
        
            
            
            
        
    
