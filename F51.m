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
id = 0;
flag=0;
for f2 =1:n
    for f1 =1:m
        if id<3
            if((dct_cover(f1,f2))==0)
                continue;
            end
            if(dct_cover(f1,f2)>0)
                odd=mod(dct_cover(f1,f2),2);
                if id==0
                    isum(1).x=f1;
                    isum(1).y=f2;
                    isum(1).cover=dct_cover(f1,f2);
                    isum(1).bit= odd;
                end
                if id==1
                    isum(2).x=f1;
                    isum(2).y=f2;
                    isum(2).cover=dct_cover(f1,f2);
                    isum(2).bit= odd;
                end
                if id==2
                    isum(3).x=f1;
                    isum(3).y=f2;
                    isum(3).cover=dct_cover(f1,f2);
                    isum(3).bit= odd;
                end
                id=id+1;
                continue;
            end
            if(dct_cover(f1,f2)<0)
                odd=mod(dct_cover(f1,f2),2);
                if id==0
                    isum(1).x=f1;
                    isum(1).y=f2;
                    isum(1).cover=dct_cover(f1,f2);
                    isum(1).bit= bitxor(odd,1);
                end
                if id==1
                    isum(2).x=f1;
                    isum(2).y=f2;
                    isum(2).cover=dct_cover(f1,f2);
                    isum(2).bit= bitxor(odd,1);
                end
                if id==2
                    isum(3).x=f1;
                    isum(3).y=f2;
                    isum(3).cover=dct_cover(f1,f2);
                    isum(3).bit= bitxor(odd,1);
                end
                id=id+1;
                continue;
            end
        end
        if id==3
            id=0;
            if (abs(dct_cover(isum(1).x,isum(1).y))==1||msg(sum,1)~=bitxor(isum(1).bit,isum(2).bit)&&msg(sum+1,1)==bitxor(isum(2).bit,isum(3).bit))
                dct_cover(isum(1).x,isum(1).y)=0;
                flag=1;
            end
            if (abs(dct_cover(isum(3).x,isum(3).y))==1||msg(sum,1)~=bitxor(isum(1).bit,isum(2).bit)&&msg(sum+1,1)==bitxor(isum(2).bit,isum(3).bit))
                dct_cover(isum(3).x,isum(3).y)=0;
                flag=3;
            end
            if (abs(dct_cover(isum(2).x,isum(2).y))==1||msg(sum,1)~=bitxor(isum(1).bit,isum(2).bit)&&msg(sum+1,1)==bitxor(isum(2).bit,isum(3).bit))
                dct_cover(isum(2).x,isum(2).y)=0;
                flag=2;
            end
            
            if flag==0
                if(msg(sum,1)~=bitxor(isum(1).bit,isum(2).bit)&&msg(sum+1,1)==bitxor(isum(2).bit,isum(3).bit))
                    if (dct_cover(f1,f2)>0)
                        dct_cover(isum(1).x,isum(1).y)=dct_cover(isum(1).x,isum(1).y)-1;
                    end
                    if (dct_cover(f1,f2)<0)
                        dct_cover(isum(1).x,isum(1).y)=dct_cover(isum(1).x,isum(1).y)+1;
                    end
                end
                if(msg(sum,1)==bitxor(isum(1).bit,isum(2).bit)&&msg(sum+1,1)~=bitxor(isum(2).bit,isum(3).bit))
                    if (dct_cover(f1,f2)>0)
                        dct_cover(isum(3).x,isum(3).y)=dct_cover(isum(3).x,isum(3).y)-1;
                    end
                    if (dct_cover(f1,f2)<0)
                        dct_cover(isum(3).x,isum(3).y)=dct_cover(isum(3).x,isum(3).y)+1;
                    end
                end
                if(msg(sum,1)~=bitxor(isum(1).bit,isum(2).bit)&&msg(sum+1,1)~=bitxor(isum(2).bit,isum(3).bit))
                    if (dct_cover(f1,f2)>0)
                        dct_cover(isum(2).x,isum(2).y)=dct_cover(isum(2).x,isum(2).y)-1;
                    end
                    if (dct_cover(f1,f2)<0)
                        dct_cover(isum(2).x,isum(2).y)=dct_cover(isum(2).x,isum(2).y)+1;
                    end
                end
                flag=0;
            end
        end
        if(sum>=len)
            break;
        end
        sum=sum+2;
    end
    if sum >=len
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
            
            
        
            
            
        
            
            
            
        
    
