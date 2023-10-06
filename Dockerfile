# Sử dụng hình ảnh nginx mặc định từ Docker Hub
FROM nginx

# Sao chép các tệp tài liệu (trang web) vào thư mục root của Nginx
COPY html /usr/share/nginx/html

# Khai báo cổng mà Nginx lắng nghe (mặc định là 80)
EXPOSE 80

# Lệnh để chạy Nginx trong container khi container được khởi chạy
CMD ["nginx", "-g", "daemon off;"]