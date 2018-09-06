
function [soft_tissue, fat] = createUMapsMR(image_in, a, b, varargin)
% createUMapMR soft tissue and fat maps
%  a, b fractions of maximum pixel intensity

n_slices = size(image_in,3);
m = max(max(max(image_in)));
soft_tissue = zeros(size(image_in));
fat = zeros(size(image_in));

for p = 1:n_slices

    ima = image_in(:,:,p);
    
    ind=find(ima>=a*m);
    st=zeros(size(ima));
    mask=zeros(size(ima));
    mask(ind)=1;
    ind=find(ima<=b*m);
    mask1=zeros(size(ima));
    mask1(ind)=1;
    mask2=zeros(size(ima));
    ind=find(ima>b*m);
    mask2(ind)=1;
    st=mask.*mask1.*(1-mask2);
    f=mask2;
    
    soft_tissue(:,:,p) = st;
    fat(:,:,p) = f;
end

if (length(varargin) >=1)     
    n = varargin{1};
end
% GM ommitted - these figures wouldn't plot
figure
imagesc(soft_tissue(:,:,round(n_slices/2)));daspect([1 1 1]);axis off;title('Soft tissue')
figure
imagesc(fat(:,:,round(n_slices/2)));daspect([1 1 1]);axis off;title('Fat')
