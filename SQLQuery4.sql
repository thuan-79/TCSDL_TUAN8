
CREATE TABLE KH (
    MAKHACHHANG CHAR(6) PRIMARY KEY,
    TENCONGTY NVARCHAR(30) NOT NULL,
    TENGIAODICH NVARCHAR(30) NOT NULL,
    DIACHI NVARCHAR(90) NOT NULL,
    EMAIL NVARCHAR(40) UNIQUE,
    DIENTHOAI CHAR(11) NOT NULL,
    FAX VARCHAR(15)
);

CREATE TABLE NV (
    MANHANVIEN CHAR(6) PRIMARY KEY,
    HO NVARCHAR(10) NOT NULL,
    TEN NVARCHAR(10) NOT NULL,
    NGAYSINH DATE CHECK(NGAYSINH < GETDATE()),
    NGAYLAMVIEC DATE CHECK(NGAYLAMVIEC <= GETDATE()),
    DIACHI NVARCHAR(255) NOT NULL,
    DIENTHOAI CHAR(11) UNIQUE,
    LUONGCOBAN DECIMAL(10, 2) CHECK(LUONGCOBAN > 0),
    PHUCAP DECIMAL(10, 2) CHECK(PHUCAP >= 0),
    CONSTRAINT CHK_NHANVIEN_AGE CHECK (
        DATEDIFF(YEAR, NGAYSINH, GETDATE()) >= 18 AND
        DATEDIFF(YEAR, NGAYSINH, GETDATE()) <= 60
    )
);

CREATE TABLE NCC (
    MACONGTY CHAR(20) PRIMARY KEY NOT NULL,
    TENCONGTY VARCHAR(100) NOT NULL,
    TENGIAODICH VARCHAR(100) NOT NULL,
    DIACHI VARCHAR(255),
    DIEN_THOAI CHAR(11) UNIQUE,
    FAX CHAR(15) UNIQUE,
    EMAIL VARCHAR(100) UNIQUE
);

CREATE TABLE LH (
    MALOAIHANG CHAR(6) PRIMARY KEY,
    TENLOAIHANG VARCHAR(50)
);

CREATE TABLE MH (
    MAHANG CHAR(6) PRIMARY KEY,
    TENHANG VARCHAR(50),
    MACONGTY CHAR(20),
    MALOAIHANG CHAR(6),
    SOLUONG INT CHECK(SOLUONG >= 0),
    DONVITINH VARCHAR(50),
    GIAHANG DECIMAL(10, 2) CHECK(GIAHANG >= 0),
    FOREIGN KEY (MACONGTY) REFERENCES NCC(MACONGTY),
    FOREIGN KEY (MALOAIHANG) REFERENCES LH(MALOAIHANG)
);

CREATE TABLE DDH (
    SOHOADON INT PRIMARY KEY,
    MAKHACHANG CHAR(6),
    MANHANVIEN CHAR(6),
    NGAYDATHANG DATETIME NOT NULL,
    NGAYGIAOHANG DATETIME,
    NGAYCHUYENHANG DATETIME,
    NOIGIAOHANG VARCHAR(30) NOT NULL,
    FOREIGN KEY (MAKHACHANG) REFERENCES KH(MAKHACHHANG),
    FOREIGN KEY (MANHANVIEN) REFERENCES NV(MANHANVIEN),
    CHECK (NGAYGIAOHANG >= NGAYDATHANG),
    CHECK (NGAYCHUYENHANG >= NGAYDATHANG)
);

CREATE TABLE CTDH (
    SOHOADON INT NOT NULL,
    MAHANG CHAR(6) NOT NULL,
    GIABAN DECIMAL(5,2) CHECK(GIABAN >= 0),
    SOLUONG INT DEFAULT 1 CHECK(SOLUONG >= 0),
    MUCGIAMGIA DECIMAL(5,2) DEFAULT 0 CHECK(MUCGIAMGIA >= 0),
    PRIMARY KEY (SOHOADON, MAHANG),
    FOREIGN KEY (SOHOADON) REFERENCES DDH(SOHOADON),
    FOREIGN KEY (MAHANG) REFERENCES MH(MAHANG)
);
-- Bảng NhanVien
set dateformat dmy;
insert into NV(MANHANVIEN,HO,TEN,DIENTHOAI,DIACHI,NGAYSINH,NGAYLAMVIEC,LUONGCOBAN)
values	('NV0001',N'Trần Đặng', 'Như Quỳnh','0768469188','02 Thanh Sơn,Thanh Bình,Hải Châu, Đà Nẵng','16/05/2005' , '16/05/2024','5000000'),
		('NV0002', N'Nguyễn Thị', 'Hằng','0981234120','39 Cao Thắng,Thanh Bình,Hải Châu, Đà Nẵng','16/05/2005','16/05/2024' ,'5000000'),
		('NV0003', N'Nguyễn','Anh Tuấn','0981234222','09 Thanh Sơn,Thanh Bình,Hải Châu, Đà Nẵng','16/05/2005', '20/04/2023','5000000'),
		('NV0004', N'Trương Thi', 'Kiều Nhi','0981234333','152 - 158 Hàm Nghi, Thạc Gián, Thanh Khê, Đà Nẵng.','16/05/2005', '12/04/2022','5000000'),
		('NV0005', N'Trương Thị', 'Nhã Uyên','0931234444',' 48 Hùng Vương, Huế, Thừa Thiên Huế','16/05/2005', '23/06/2000','5000000'),
		('NV0006', N'Nguyễn', 'Nhật Vy', '0248563822', '152-158 Hàm Nghi, Đà Nẵng','16/05/2005', '13/03/2003','5000000'),
		('NV0007', N'Hoàng', 'Quân','0931234555','02 Lý Tự Trọng,Thanh Bình,Hải Châu, Đà Nẵng','16/05/2005', '10/12/1999','5000000'),
		('NV0008', N'Lê', 'Trần Mỹ', '0938553569', 'Quảng Xương,Hoà Vang, Đà Nẵng','16/05/2005', '1/06/1995','5000000'),
		('NV0009', N'Hà', 'Văn Phong','0921234321','Hải Phong,Thanh Bình,Hải Châu, Đà Nẵng','16/05/2005', '30/04/1995','5000000'),
		('NV0010', N'Nguyễn', 'Thị Hường', '03275058545','199 Đóng Đa,Thanh Bình,Hải Châu, Đà Nẵng','16/05/2005', '07/05/1995','5000000');
	select *
	From NHANVIEN;
-- Bảng KhachHang
insert into KH(MAKHACHHANG, TENCONGTY, TENGIAODICH,DIACHI, DIENTHOAI, EMAIL, FAX)
values ('KH0001' , 'Công ty Cổ phần Chứng khoán SSI', 'Giao dịch abc','02 Thanh Sơn', '0123456789', 'khanhquin@gmail.com', '19004566'),
		('KH0002', 'Công ty cổ phần Hoàng Anh Gia Lai','Giao dịch bóng đá','02 Thanh Sơn', '0152465468', 'hoanglam@gmail.com','19006522' ),
		('KH0003', 'Công ty cổ phần ô tô Trường Hải', 'Giao dịch aaa','02 Thanh Sơn','0562489245', 'baotram@gmail.com', '18464444'),
		('KH0004','Công ty Cổ phần sản xuất nhựa Duy Tân.', 'Giao dịch acc','02 Thanh Sơn','0586127946', 'longnhat@gmail.com', '19008113'),
		('KH0005','Công ty Cổ phần Vingroup','Giao dịch VinMart', '02 Thanh Sơn','0234615874', 'linh@gmail.com', '19002322'),
		('KH0006', 'Công ty Cổ phần FPT Corporation','Trường học','02 Thanh Sơn', '0642580642', 'duchuy@gmail.com', '19004433'),
		('KH0007','Công ty Cổ phần Thế Giới Di Động','Giao dịch trực tuyến','02 Thanh Sơn', '0361058924', 'phuongmai@gmail.com', '19006638'),
		('KH0008', 'Công ty Cổ phần Bia Sài Gòn ','Sản phẩm bia', '02 Thanh Sơn','0648237952', 'vietha@gmail.com', '19003330'),
		('KH0009', 'Công ty Cổ phần Hàng không VietJet','Giao dịch đặt vé trực tuyến','02 Thanh Sơn', '0369157428', 'giabao@gmail.com', '19001207'),
		('KH0010', 'Công ty Cổ phần Tập đoàn Hoa Sen','Giao dịch vật liệu xây dựng', '02 Thanh Sơn','0956248316', 'haian@gmail.com', '19002455');
select *
From KHACHHANG;

--bảng NhaCungCap
insert into NCC(MACONGTY,TENCONGTY,TENGIAODICH,DIACHI,DIEN_THOAI,FAX,EMAIL)
values ('CT0001','Công ty Cổ phần Chứng khoán SSI','Giao dịch quỹ đầu tư','02 Thanh Sơn,Thanh Bình,Hải Châu, Đà Nẵng','0635942786','0272 760 221','nguyenthi@rch-asia.com'),
		('CT0002','Công ty cổ phần Hoàng Anh Gia Lai','Giao dịch bất động sản','142 Nguyễn Thị Minh Khai, Phường Hải Châu 1, Quận Hải Châu, Đà Nẵng.','0256635469',' 0272 38734883','info@dyechem-vn.com'),
		('CT0003','Công ty cổ phần ô tô Trường Hải','Giao dịch Thaco Bus','02 Thanh Sơn, Thanh Bình, Hải Châu, Đà Nẵng','0684545256','0918560273','trannamhuong@2011@gmail.com'),
		('CT0004','Công ty Cổ phần sản xuất nhựa Duy Tân','Sản phẩm nhựa công nghiệp','12 Nguyễn Văn Linh, Quận Hải Châu, Đà Nẵng.','0355112542','0272 8212 802','info@fecon.com.vn'),
		('CT0005','Công ty Cổ phần Vingroup','VinMart','45 Đường 2 tháng 9, Quận Hải Châu, Đà Nẵng','0256848689','0272 8213 808','anh.dv@vnt-invest.com.vn'),
		('CT0006','Công ty Cổ phần FPT Corporation','Trường học','Tầng 15, Tòa nhà FPT, Số 10 Phạm Văn Bạch, Quận Cầu Giấy, Hà Nội.','0256348556','0272 38734883','keytechvn11@gmail.com'),
		('CT0007','Công ty Cổ phần Thế Giới Di Động','Giao dịch trực tuyến','414 Nguyễn Thị Minh Khai, Phường 5, Quận 3, TP.HCM.','0562492556','0272 38735.777','logistics@sotrans.com.vn'),
		('CT0008','Công ty Cổ phần Tập đoàn Hoa Sen','Giao dịch vật liệu xây dựng','9-11 Đường 5, KCN Biên Hòa II, TP.Biên Hòa, Tỉnh Đồng Nai.','0563294182','8428 3940 2566','hanoi@sotrans.com.vn'),
		('CT0009','Công ty Cổ phần Hàng không VietJet','Giao dịch đặt vé trực tuyến','0 Nguyễn Thái Bình, Phường 12, Quận Tân Bình, TP.HCM.','0235448912','8424 3732 1119','log@vinalinklogistics.com'),
		('CT0010','Công ty Cổ phần Bia Sài Gòn ','Sản phẩm bia','6 Đường Lê Lợi, Quận 1, TP.HCM.','0965426585',' 0838488570','cpn8866@gmail.com');

--bảng loại hàng
insert into LH(MALOAIHANG,TENLOAIHANG)
values ('MLH001',N'áo'),
		('MLH002',N'cặp xách'),
		('MLH003',N'máy tính'),
		('MLH004',N'đồ mỹ thuật'),
		('MLH005',N'vở sách'),
		('MLH006',N'giày'),
		('MLH007',N'đồng phục'),
		('MLH008',N'đồ makeup'),
		('MLH009',N'dụng cụ thể thao'),
		('MLH010',N'đồ điện tử');


		--bảng MẶT HÀNG
insert into MH(MAHANG,TENHANG,MACONGTY,MALOAIHANG,SOLUONG,DONVITINH,GIAHANG)
values ('MH0001','áo phao','CT0001','MLH001','30','cái','190.000'),
		('MH0002','balo da','CT0002','MLH002','25','cái','150.000'),
		('MH0003','máy tính cầm tay','CT0003','MLH003','35','cái','470.000'),
		('MH0004','màu nước','CT0004','MLH004','40','hộp','40.000'),
		('MH0005','sách giáo khoa','CT0005','MLH005','17','cuốn','20.000'),
		('MH0006','giày búp bê','CT0006','MLH006','19','đôi','220.000'),
		('MH0007','váy','CT0007','MLH007','32','cái','230.000'),
		('MH0008','cushion','CT0008','MLH008','24','hộp','310.000'),
		('MH0009','vợt cầu lông','CT0009','MLH009','19','chiếc','290.000'),
		('MH0010','đồng hồ','CT0010','MLH010','22','cái','580.000');
		-- Bảng DonDatHang
set dateformat dmy;
insert into DDH(SOHOADON,MAKHACHANG,MANHANVIEN,NGAYDATHANG,NGAYGIAOHANG,NGAYCHUYENHANG,NOIGIAOHANG)
values ('HD0001', 'KH0001', 'NV0001', '20/10/2024', '29/10/2024', '21/10/2024', 'Hà Nội'),
		('HD0002', 'KH0001', 'NV0001', '26/10/2024', '31/10/2024', '27/10/2024', 'Hải Phòng'),
		('HD0003', 'KH0003', 'NV0002', '20/8/2024', '24/8/2024', '21/8/2024','Hải Phòng'),
		('HD0004', 'KH0009', 'NV0002', '18/10/2024', '21/10/2024', '19/10/2024','Sơn La'),
		('HD0005', 'KH0008', 'NV0003', '2/7/2024', '5/7/2024',  '3/7/2024','Nha Trang'),
		('HD0006', 'KH0004', 'NV0003', '4/10/2024', '6/10/2024',  '5/10/2024','Đà Lạt'),
		('HD0007', 'KH0003', 'NV0004', '30/10/2024', '31/10/2024', '30/10/2024','Điện Biên'),
		('HD0008', 'KH0009', 'NV0004', '5/9/2024', '10/9/2024', '6/10/2024','Đà Nẵng'),
		('HD0009', 'KH0010', 'NV0005', '7/6/2024', '10/6/2024', '8/16/2024','Quãng Nam'),
		('HD0010', 'KH0006', 'NV0005', '2/10/2024', '7/10/2024', '3/10/2024','Đà Nẵng');


--bảng ChiTietDatHang
insert into CTDH(SOHOADON,MAHANG,GIABAN,SOLUONG,MUCGIAMGIA)
values		('HD0001','MH0002','150.000','2','0'),
		('HD0002','MH0001','190.000','4','0'),
		('HD0003','MH0003','470.00','3','0'),
		('HD0004','MH0002','150.000','2','0'),
		('HD0005','MH0005','20.000','4','0'),
		('HD0006','MH0001','190.000','7','0'),
		('HD0007','MH0007','230.000','6','0'),
		('HD0008','MH0009','290.000','6','0'),
		('HD0009','MH0001','190.000','4','0'),
		('HD0010','MH0001','190.000','5','0');
---a, Cập nhật lại giá trị trường NGAYCHUYENHANG của những bản ghi có NGAYCHUYENHANG chưa xác định (NULL) trong bảng DONDATHANG bằng với giá trị của trường NGAYDATHANG.
UPDATE DDH
SET NGAYCHUYENHANG = NGAYDATHANG
WHERE NGAYCHUYENHANG IS NULL;
--- b, Tăng số lượng hàng của những mặt hàng do công ty VINAMILK cung cấp lên gấp đôi:
UPDATE MH
SET SOLUONG = SOLUONG * 2
WHERE MACONGTY = (
    SELECT MACONGTY 
    FROM NCC 
    WHERE TENCONGTY = 'VINAMILK'
);
--- c, Cập nhật NOIGIAOHANG bằng địa chỉ khách hàng nếu NOIGIAOHANG là NULL
UPDATE DDH
SET NOIGIAOHANG = KH.DIACHI
FROM DDH
JOIN KH ON DDH.MAKHACHANG = KH.MAKHACHHANG
WHERE DDH.NOIGIAOHANG IS NULL;

---d, Đồng bộ thông tin khách hàng với nhà cung cấp nếu tên công ty và tên giao dịch trùng nhau
UPDATE KH
SET DIACHI = KH.DIACHI, 
    DIENTHOAI = KH.DIENTHOAI, 
    FAX = KH.FAX, 
    EMAIL = KH.EMAIL,
FROM NCC
JOIN NCC NCC 
  ON KH.TENCONGTY = NCC.TENCONGTY 
  AND KH.TENGIAODICH = NCC.TENGIAODICH;
  ---e, Tăng lương gấp rưỡi cho nhân viên bán hơn 100 đơn hàng trong năm 2022
 UPDATE NHANVIEN
SET LUONGCOBAN = LUONGCOBAN * 1.5
WHERE MANHANVIEN IN (
    SELECT MANHANVIEN
    FROM DONDATHANG DDH
    JOIN CHITIETDATHANG CTDH ON DDH.SOHOADON = CTDH.SOHOADON
    WHERE YEAR(DDH.NGAYDATHANG) = 2022
    GROUP BY MANHANVIEN
	HAVING SUM(CTDH.SOLUONG) > 100
);
---f, Tăng phụ cấp lên bằng 50% lương cho những nhân viên bán được hàng nhiều nhất.
WITH SalesSummary AS (
    SELECT MANHANVIEN, SUM(SOLUONG) AS TONG_SOLUONG
    FROM DONDATHANG DDH
    JOIN CHITIETDATHANG CTDH ON DDH.SOHOADON = CTDH.SOHOADON
    GROUP BY MANHANVIEN
),
MaxSales AS (
    SELECT MANHANVIEN
    FROM SalesSummary
    WHERE TONG_SOLUONG = (
        SELECT MAX(TONG_SOLUONG) FROM SalesSummary
    )
)
UPDATE NHANVIEN
SET PHUCAP = 0.5 * LUONGCOBAN
WHERE MANHANVIEN IN (SELECT MANHANVIEN FROM MaxSales);

---g, Giảm 25% lương cho những nhân viên không lập đơn hàng nào trong năm 2023:
UPDATE NHANVIEN
SET LUONGCOBAN = LUONGCOBAN * 0.75
WHERE MANHANVIEN NOT IN (
    SELECT MANHANVIEN 
    FROM DONDATHANG
    WHERE YEAR(NGAYDATHANG) = 2023
);
select *
from NHANVIEN;