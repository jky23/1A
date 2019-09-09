clear all;
close all;

%% Matrice de quantification
Q=[16 11 10 16 24 40 51 61 ; 12 12 14 19 26 58 60 55; 14 13 16 24 40 57 69 56;...
    14 17 22 29 51 87 80 62; 18 22 37 56 68 109 103 77; 24 35 55 64 81 104 113 92; ...
    49 64 78 87 103 121 120 101; 72 92 95 98 112 100 103 99];

%% Ouverture de l'image
im = imread('barbara.png');
%im = im(1:128,1:128);
imshow(im);
s = size(im);

%% Separation en blocs
X = zeros(2*size(im,1),8,8);
count = 1;
for i = 0 : size(im,1)/8-1
    for j = 0 : size(im,2)/8 -1
        X(count,:,:) = squeeze(im(i*8+1:(i+1)*8,j*8+1:(j+1)*8));
        count = count +1;
    end
end

Xr = reconstruireIm(X);
isequal(im,Xr);
xsize = size(X);

%% DCT
XDCTed = zeros(xsize);
for i=1:xsize(1)
    f = dct2(X(i,:,:));
    g = reshape(f,8,8);
    XDCTed(i,:,:,:) = squeeze(g); 
end

%figure()
%imshow(reconstruireIm(X))

%% Quantification
XQtfied = zeros(size(XDCTed));
for i=1:size(XDCTed,1)
        c = squeeze(XDCTed(i,:,:));
        XQtfied(i,:,:) = c./Q;
end
XQtfied = round(XQtfied);

%figure()
%imshow(reshape(XQtfied(:,:,:,1),s(1),s(2)))

%% Zig Zag
Xzigzag = []; % Arrondi
for i= 1:size(XQtfied,1)
    Xzigzag = [Xzigzag; toZigzag(squeeze(round(XQtfied(i,:,:)))')];
end

%% RLE

[Xrle,Xdict] = rle(Xzigzag);
    
 %% Huffman
 
[dict,~] = huffmandict(Xdict(:,1),Xdict(:,2)/sum(Xdict(:,2)));
comp = huffmanenco(Xrle(:,1),dict);


 %% Codage canal
nSeparation = size(comp);
nSeparation = nSeparation(1);
 
SuiteATransmettre = [comp; Xrle(:,2)];
N = size(SuiteATransmettre);
N = N(1)/2;
[tebs_softP_inter_rs,bits_decodes_RS] = softP_inter_rs(SuiteATransmettre.',N, 100,(-3:3), 10^7);
 
compDecode = bits_decodes_RS(1:nSeparation,1);
XrleDecode = bits_decodes_RS(nSeparation:end,1);

%% Decompression Jpeg
%On a : comp et Xrle(:,2) et dict (supposé commun)
SymboleDecode = huffmandeco(compDecode,dict);

DecodeHuff = [];

for i = 1:size(SymboleDecode,1)
    for j = 1:XrleDecode(i)
        DecodeHuff = [DecodeHuff SymboleDecode(i,1)]; 
    end
end

n = size(DecodeHuff,2)/64;

%% Dezigzaguer
DecodeXzig = zeros(n,8,8);
for i =0:(n-1)
    Y =  invZigzag(DecodeHuff(i*64+1:(i+1)*64));
    DecodeXzig(i+1,:,:) = Y';
end

%isequal(DecodeXzig,fix(XQtfied))

%% Dequantifier
%DecodeXzig = reshape(DecodeXzig,[],8,8);
s2 = size(DecodeXzig);

DecodeXQtfied = zeros(s2);
for i=1:s2(1)
        c = squeeze(DecodeXzig(i,:,:));
        DecodeXQtfied(i,:,:) = c.*Q;
end

%isequal(DecodeXQtfied,fix(XDCTed))

%% Decosinuser
DecodeXDCTed = zeros(s2);
for i=1:size(DecodeXzig,1)
    f = idct2(DecodeXQtfied(i,:,:));
    g = reshape(f,8,8);
    DecodeXDCTed(i,:,:,:) = squeeze(g); 
end

%isequal(X,DecodeXDCTed);
DecodeX = reconstruireIm(DecodeXDCTed);
 figure;
 imshow(uint8(DecodeX));



