
function image_smooth = imageSmooth2D(image, fov, kernel_fwhm)


[n, m, q] = size(image);
image_smooth = zeros(size(image));

[y,x] = meshgrid([-n/2:n/2-1].*(fov(2)/n),[-m/2:m/2-1].*(fov(1)/m));
r = x.^2 + y.^2;
kernel = (1/(kernel_fwhm*sqrt(2*pi))).*exp(-r./(2*kernel_fwhm^2));
kernel = kernel./ sum(sum(kernel));

% display(['Sum kernel ' num2str(sum(sum(kernel)))])

% figure(5);imagesc(kernel);title('Kernel')
% pause

k_kernel = fftshift(fft2(fftshift(kernel)));
% figure(5);imagesc(abs(k_kernel));title('abs k-Kernel')
% pause
% figure(5);imagesc(real(k_kernel));title('real k-Kernel')
% pause
% figure(5);imagesc(abs(fftshift(fft2(fftshift(image(:,:,50))))));;title('abs k-image')
% pause
% figure(5);imagesc(real(fftshift(fft2(fftshift(image(:,:,50))))));title('real k-image')
% pause

for p = 1:q

    k = fftshift(fft2(fftshift(image(:,:,p))));
    
    image_smooth(:,:,p) = fftshift(ifft2(fftshift( k.*k_kernel )));
end