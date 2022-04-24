stego='F5.jpg';

len=10304;
frr=fopen('msg_F5.txt','a');

try
    jpeg_stego = jpeg_read(stego); 
    dct_stego = jpeg_stego.coef_arrays{1}; 
catch
    error('ERROR');
end
[m,n]=size(dct_stego);
idD=1;
id=0;
id = 1;
x=zeros(1,512*512);
y=zeros(1,512*512);
num_stego=zeros(1,512*512);
bit_stego=zeros(1,512*512);
condition_stego=zeros(1,512*512);
len2=512*512;
sum=1;
for f2 =1:n
    for f1 =1:m
        if((dct_stego(f1,f2))==0)
            continue;
        end
        if((dct_stego(f1,f2))>0)
            x(1,id)=f1;
            y(1,id)=f2;
            num_stego(1,id)=dct_stego(f1,f2);  
            odd=mod(dct_stego(f1,f2),2);
            condition_stego(1,id)=odd;
            id=id+1;
        end
        if((dct_stego(f1,f2))<0)
            x(1,id)=f1;
            y(1,id)=f2;
            num_stego(1,id)=dct_stego(f1,f2);  
            odd=mod(dct_stego(f1,f2),2);
            condition_stego(1,id)=bitxor(odd,1);
            id=id+1;
        end
        if(sum==len2)
            break;
        end
        sum=sum+1;
    end
    if sum ==len2
        break;
    end
end
disp(num_stego(1,1:40));
sum2=1;
msgnum=1;
message=zeros(1,len);
while msgnum<=len
    message(1,msgnum)=bitxor(condition_stego(1,sum2),condition_stego(1,sum2+1));
    message(1,msgnum+1)=bitxor(condition_stego(1,sum2+1),condition_stego(1,sum2+2));
    msgnum=msgnum+2;
    sum2=sum2+3;
end
disp(isequal(msg.',message));
for i=1:len
    fwrite(frr,message(1,i),'ubit1');
end
fclose(frr);

        