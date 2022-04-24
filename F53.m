cover='cover.jpg';
stego='F5.jpg';
wen.txt_id=fopen('1.txt','r');
[msg,L]=fread(wen.txt_id,'ubit1');
try 
    jpeg_cover=jpeg_read(cover);
    dct_cover=jpeg_cover.coef_arrays{1};
    dct_cover2=jpeg_cover.coef_arrays{1};
catch
    error('Error');
end

len=length(msg);
sum=1;
[m,n]=size(dct_cover);
id = 1;
x=zeros(1,512*512);
y=zeros(1,512*512);
num_cover=zeros(1,512*512);
bit_cover=zeros(1,512*512);
condition_cover=zeros(1,512*512);
len2=512*512;
for f2 =1:n
    for f1 =1:m
        if((dct_cover(f1,f2))==0)
            continue;
        end
        if((dct_cover(f1,f2))>0)
            x(1,id)=f1;
            y(1,id)=f2;
            num_cover(1,id)=dct_cover(f1,f2);  
            odd=mod(dct_cover(f1,f2),2);
            condition_cover(1,id)=odd;
            id=id+1;
            disp(dct_cover(f1,f2));
        end
        if((dct_cover(f1,f2))<0)
            x(1,id)=f1;
            y(1,id)=f2;
            num_cover(1,id)=dct_cover(f1,f2);  
            odd=mod(dct_cover(f1,f2),2);
            condition_cover(1,id)=bitxor(odd,1);
            disp(dct_cover(f1,f2));
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
i=1
flag=0;
now= zeros(1,3);
now2 = zeros(1,3);
sum2=1;
now(1,1)=1;
now(1,2)=2;
now(1,3)=3;
while i<=id&&sum2<=len
    disp(dct_cover(x(1,now(1,1)),y(1,now(1,1))));
    disp(dct_cover(x(1,now(1,2)),y(1,now(1,2))));
    disp(dct_cover(x(1,now(1,3)),y(1,now(1,3))));
    disp(msg(sum2,1));
    disp(msg(sum2+1,1));
    if abs(dct_cover(x(1,now(1,1)),y(1,now(1,1))))==1
        if msg(sum2,1)~=bitxor(condition_cover(1,now(1,1)),condition_cover(1,now(1,2)))&&msg(sum2+1,1)==bitxor(condition_cover(1,now(1,2)),condition_cover(1,now(1,3)))
            dct_cover(x(1,now(1,1)),y(1,now(1,1)))=0;
            now(1,1)=now(1,2);
            now(1,2)=now(1,3);
            now(1,3)=now(1,3)+1;
            flag=flag+1;
            continue;
        end
    end
    if abs(dct_cover(x(1,now(1,2)),y(1,now(1,2))))==1
        if msg(sum2,1)~=bitxor(condition_cover(1,now(1,1)),condition_cover(1,now(1,2)))&&msg(sum2+1,1)~=bitxor(condition_cover(1,now(1,2)),condition_cover(1,now(1,3)))
            dct_cover(x(1,now(1,2)),y(1,now(1,2)))=0;
            now(1,2)=now(1,3);
            now(1,3)=now(1,3)+1;
            flag=flag+1;
            continue;
        end
    end
    if abs(dct_cover(x(1,now(1,3)),y(1,now(1,3))))==1
        if msg(sum2,1)==bitxor(condition_cover(1,now(1,1)),condition_cover(1,now(1,2)))&&msg(sum2+1,1)~=bitxor(condition_cover(1,now(1,2)),condition_cover(1,now(1,3)))
            dct_cover(x(1,now(1,3)),y(1,now(1,3)))=0;
            now(1,3)=now(1,3)+1;
           flag=flag+1;
            continue;    
        end
    end
    if msg(sum2,1)~=bitxor(condition_cover(1,now(1,1)),condition_cover(1,now(1,2)))&&msg(sum2+1,1)==bitxor(condition_cover(1,now(1,2)),condition_cover(1,now(1,3)))
        if (dct_cover(x(1,now(1,1)),y(1,now(1,1)))>0)
            dct_cover(x(1,now(1,1)),y(1,now(1,1)))=dct_cover(x(1,now(1,1)),y(1,now(1,1)))-1;
        end
        if (dct_cover(x(1,now(1,1)),y(1,now(1,1)))<0)
            dct_cover(x(1,now(1,1)),y(1,now(1,1)))=dct_cover(x(1,now(1,1)),y(1,now(1,1)))+1;
        end
    end
    if msg(sum2,1)~=bitxor(condition_cover(1,now(1,1)),condition_cover(1,now(1,2)))&&msg(sum2+1,1)~=bitxor(condition_cover(1,now(1,2)),condition_cover(1,now(1,3)))
        if (dct_cover(x(1,now(1,2)),y(1,now(1,2)))>0)
            dct_cover(x(1,now(1,2)),y(1,now(1,2)))=dct_cover(x(1,now(1,2)),y(1,now(1,2)))-1;
        end
        if (dct_cover(x(1,now(1,2)),y(1,now(1,2)))<0)
            dct_cover(x(1,now(1,2)),y(1,now(1,2)))=dct_cover(x(1,now(1,2)),y(1,now(1,2)))+1;
        end
    end
    if msg(sum2,1)==bitxor(condition_cover(1,now(1,1)),condition_cover(1,now(1,2)))&&msg(sum2+1,1)~=bitxor(condition_cover(1,now(1,2)),condition_cover(1,now(1,3)))
        if (dct_cover(x(1,now(1,3)),y(1,now(1,3)))>0)
            dct_cover(x(1,now(1,3)),y(1,now(1,3)))=dct_cover(x(1,now(1,3)),y(1,now(1,3)))-1;
        end
        if (dct_cover(x(1,now(1,3)),y(1,now(1,3)))<0)
            dct_cover(x(1,now(1,3)),y(1,now(1,3)))=dct_cover(x(1,now(1,3)),y(1,now(1,3)))+1;
        end
    end
    sum2=sum2+2;
    disp(dct_cover(x(1,now(1,1)),y(1,now(1,1))));
    disp(dct_cover(x(1,now(1,2)),y(1,now(1,2))));
    disp(dct_cover(x(1,now(1,3)),y(1,now(1,3))));
    now(1,1)=now(1,3)+1;
    now(1,2)=now(1,3)+2;
    now(1,3)=now(1,3)+3;
    i=now(1,1);
end
    
        
        
      
try 
    jpeg_cover.coef_arrays{1}=dct_cover;
    jpeg_cover.optimize_coding=1;
    jpeg_write(jpeg_cover,stego);
catch
    error('ERROR2')
end
subplot(2,2,1);
imshow(cover);
title('before image');
subplot(2,2,2);
imshow(stego);
title('after image');


subplot(2,2,3);
histogram(dct_cover2);
axis([-10 10,0 2*1e4]);
title('before image');
subplot(2,2,4);
histogram(dct_cover);
axis([-10 10,0 2*1e4]);
title('after image');
disp(isequal(dct_cover,dct_cover2)); 
            
        
            
            
        
            
            
            
        
    
