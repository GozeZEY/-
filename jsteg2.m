cover='cover.jpg';
stego='jsteg.jpg';
frr=fopen('meg_jsteg.txt','a');
try 
    jpeg_stego=jpeg_read(stego);
    dct_stegot=jpeg_stego.coef_arrays{1};
catch
    error('Error');
end
len=21904;
sum=1;
[m,n]=size(dct_stegot);
for f2 =1:n
    for f1 =1:m
        if(abs(dct_stegot(f1,f2))<=1)
            continue;
        end
        if(dct_stegot(f1,f2)>1)
            odd=mod(dct_stegot(f1,f2),2);
            if(odd==0)
               fwrite(frr,0,'ubit1');
            end
            if( odd==1)
               fwrite(frr,1,'ubit1');
            end
        end
        if(dct_stegot(f1,f2)<-1)
            odd=abs(mod(dct_stegot(f1,f2),2));
            if(odd==0)
                fwrite(frr,1,'ubit1');
            end
            if(odd==1)
               fwrite(frr,0,'ubit1');
            end
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
            
            
        
            
            
        
            
            
            
        
    
