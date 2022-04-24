cover='cover.jpg';
stego='F4.jpg';
frr=fopen('msg_F4.txt','a');
try 
    jpeg_stego=jpeg_read(stego);
    dct_stego=jpeg_stego.coef_arrays{1};
catch
    error('Error');
end
len=21904;
sum=1;
[m,n]=size(dct_stego);
for f2 =1:n
    for f1 =1:m
        if(dct_stego(f1,f2)==0)
            continue;
        end
        if dct_stego(f1,f2)>0
            odd=mod(dct_stego(f1,f2),2);
            fwrite(frr,odd,'ubit1');
        else
            odd=mod(dct_stego(f1,f2),2);
            fwrite(frr,mod(odd+1,2),'ubit1');
        end
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
            
            
        
            
            
        
            
            
            
        
    
