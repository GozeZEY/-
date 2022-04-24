clear;
length=21904;
picture = imread('cover.jpg');
% image(picture);
double_picture = picture;
double_picture = double(double_picture);
zhang.txt_id = fopen('注意事项.txt','r');
% disp(isequal(zhang.txt_id,bitxor(zhang.txt_id,1)));
[msg2,len] = fread(zhang.txt_id,'ubit1');
one = ones(length,1);
msg = bitxor(msg2,one);
disp(isequal(msg,msg2));
[m,n] = size(double_picture);
p=1;
for f2 = 1:n
    for f1 = 1:m
        double_picture(f1,f2) = double_picture(f1,f2)-mod(double_picture(f1,f2),2)+msg(p,1);
        if p == len
            break;
        end
        p=p+1;
    end
    if p==len
        break;
    end
end
double_picture=uint8(double_picture);
imwrite(double_picture,'stego.bmp');
subplot(121);imshow(picture);title('未嵌入信息的图像');
subplot(122);imshow(double_picture);title('嵌入信息的图像');
fclose(zhang.txt_id);


picture = picture(:);
picture = picture(1:21904,:);
double_picture = double_picture(:);
double_picture = double_picture(1:21904,:);


tab1 = tabulate(picture(:));
tab2 = tabulate(double_picture(:));
figure;
bar(tab1(150:170,1),tab1(150:170,2)),title('before image');
figure;
bar(tab2(150:170,1),tab2(150:170,2)),title('after image');
disp(sum(abs(picture-double_picture)));

% subplot(2,1,1);
% histogram(picture);
% axis([0 100,0 2*1e3]);
% title('before image');
% subplot(2,1,2);
% histogram(double_picture);
% axis([0 100,0 2*1e3]);
% title('after image');


picture2 = imread('stego.bmp');
picture2 = double(picture2);
[m,n] = size(picture2);
frr = fopen('message.txt','a');
len = length;
p = 1;
for f2=1:n
    for f1=1:m
        if bitand(picture2(f1,f2),1) == 0
            fwrite(frr,1,'ubit1');
            result(p,1) = 1;
        else
            fwrite(frr,0,'ubit1');
            result(p,1) = 0;
        end
        if p == len
            break;
        end
        if p < len
               p=p+1;
        end
    end
    if p == len
        break;
    end
 end
    fclose(frr);
    disp(isequal(double_picture,picture2));
    disp(isequal(result,msg2));