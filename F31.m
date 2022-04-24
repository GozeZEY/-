cover='cover.jpg';
stego='F3.jpg';
wen.txt_id=fopen('×¢ÒâÊÂÏî.txt','r');
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
for f2 =1:n
    for f1 =1:m
        if((dct_cover(f1,f2))==0)
            continue;
        end
        if(dct_cover(f1,f2)==1 &&msg(sum,1)==0)
            dct_cover(f1,f2)=0;
            continue;
        end
        
        if(dct_cover(f1,f2)>=1)
            odd=mod(dct_cover(f1,f2),2);
            if(msg(sum,1)~=odd)
                dct_cover(f1,f2)=dct_cover(f1,f2)-1;
            end
        end
        if(dct_cover(f1,f2)==-1 &&msg(sum,1)==0)
            dct_cover(f1,f2)=0;
            continue;
        end
        if(dct_cover(f1,f2)<=-1)
            odd=abs(mod(dct_cover(f1,f2),2));
            if(msg(sum,1)~=odd)
                dct_cover(f1,f2)=dct_cover(f1,f2)+1;
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
            
            
        
            
            
        
            
            
            
        
    
