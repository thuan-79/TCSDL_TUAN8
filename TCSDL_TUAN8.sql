﻿
USE master;

IF EXISTS (SELECT name FROM sys.databases WHERE name = 'TCSDL_NHOM6')
BEGIN   
    ALTER DATABASE TCSDL_NHOM6 SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE TCSDL_NHOM6;
END;

CREATE DATABASE TCSDL_NHOM6;
GO
USE TCSDL_NHOM6;

-- Create KHACHHANG table
CREATE TABLE KHACHHANG (
    MAKHACHHANG CHAR(6) PRIMARY KEY,
    TENCONGTY NVARCHAR(30) NOT NULL,
    TENGIAODICH NVARCHAR(30) NOT NULL,
    DIACHI NVARCHAR(90) NOT NULL,
    EMAIL NVARCHAR(40) UNIQUE,
    DIENTHOAI CHAR(11) NOT NULL,
    FAX VARCHAR(15)
);

-- Create NHANVIEN table
CREATE TABLE NHANVIEN (
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

-- Create NHACUNGCAP table
CREATE TABLE NHACUNGCAP (
    MACONGTY CHAR(20) PRIMARY KEY NOT NULL,
    TENCONGTY VARCHAR(100) NOT NULL,
    TENGIAODICH VARCHAR(100) NOT NULL,
    DIACHI VARCHAR(255),
    DIEN_THOAI CHAR(11) UNIQUE,
    FAX CHAR(15) UNIQUE,
    EMAIL VARCHAR(100) UNIQUE
);

-- Create LOAIHANG table
CREATE TABLE LOAIHANG (
    MALOAIHANG CHAR(6) PRIMARY KEY,
    TENLOAIHANG VARCHAR(50)
);

-- Create MATHANG table
CREATE TABLE MATHANG (
    MAHANG CHAR(6) PRIMARY KEY,
    TENHANG VARCHAR(50),
    MACONGTY CHAR(20),
    MALOAIHANG CHAR(6),
    SOLUONG INT CHECK(SOLUONG >= 0),
    DONVITINH VARCHAR(50),
    GIAHANG DECIMAL(10, 2) CHECK(GIAHANG >= 0),
    FOREIGN KEY (MACONGTY) REFERENCES NHACUNGCAP(MACONGTY),
    FOREIGN KEY (MALOAIHANG) REFERENCES LOAIHANG(MALOAIHANG)
);

-- Create DONDATHANG table
CREATE TABLE DONDATHANG (
    SOHOADON INT PRIMARY KEY,
    MAKHACHANG CHAR(6),
    MANHANVIEN CHAR(6),
    NGAYDATHANG DATETIME NOT NULL,
    NGAYGIAOHANG DATETIME,
    NGAYCHUYENHANG DATETIME,
    NOIGIAOHANG NVARCHAR(30),
    FOREIGN KEY (MAKHACHANG) REFERENCES KHACHHANG(MAKHACHHANG),
    FOREIGN KEY (MANHANVIEN) REFERENCES NHANVIEN(MANHANVIEN),
    CHECK (NGAYGIAOHANG >= NGAYDATHANG),
    CHECK (NGAYCHUYENHANG >= NGAYDATHANG)
);

-- Create CHITIETDATHANG table
CREATE TABLE CHITIETDATHANG (
    SOHOADON INT NOT NULL,
    MAHANG CHAR(6) NOT NULL,
    GIABAN DECIMAL(5,2) CHECK(GIABAN >= 0),
    SOLUONG INT DEFAULT 1 CHECK(SOLUONG >= 0),
    MUCGIAMGIA DECIMAL(5,2) DEFAULT 0 CHECK(MUCGIAMGIA >= 0),
    PRIMARY KEY (SOHOADON, MAHANG),
    FOREIGN KEY (SOHOADON) REFERENCES DONDATHANG(SOHOADON),
    FOREIGN KEY (MAHANG) REFERENCES MATHANG(MAHANG)
);

-- Thêm dữ liệu vào bảng KHACHHANG
INSERT INTO KHACHHANG (MAKHACHHANG, TENCONGTY, TENGIAODICH, DIACHI, EMAIL, DIENTHOAI, FAX)
VALUES 
('KH001', N'Công ty Z', N'Công ty Z GD', N'Địa chỉ Z', 'z@example.com', '0123456789', '123456789'),
('KH002', N'Công ty B', N'Công ty B GD', N'Địa chỉ B', 'b@example.com', '0123456790', '123456780'),
('KH003', N'Công ty C', N'Công ty C GD', N'Địa chỉ C', 'c@example.com', '0123456791', '123456781'),
('KH004', N'Công ty D', N'Công ty D GD', N'Địa chỉ D', 'd@example.com', '0123456792', '123456782'),
('KH005', N'Công ty E', N'Công ty E GD', N'Địa chỉ E', 'e@example.com', '0123456793', '123456783'),
('KH006', N'Công ty F', N'Công ty F GD', N'Địa chỉ F', 'f@example.com', '0123456794', '123456784'),
('KH007', N'Công ty G', N'Công ty G GD', N'Địa chỉ G', 'g@example.com', '0123456795', '123456785'),
('KH008', N'Công ty H', N'Công ty H GD', N'Địa chỉ H', 'h@example.com', '0123456796', '123456786'),
('KH009', N'Công ty T', N'Công ty T GD', N'Địa chỉ T', 'T@example.com', '0123456797', '123456787'),
('KH010', N'Công ty J', N'Công ty J GD', N'Địa chỉ J', 'j@example.com', '0123456798', '123456788');


-- Thêm dữ liệu vào bảng NHANVIEN
INSERT INTO NHANVIEN (MANHANVIEN, HO, TEN, NGAYSINH, NGAYLAMVIEC, DIACHI, DIENTHOAI, LUONGCOBAN, PHUCAP)
VALUES 
('NV001', N'Nguyễn', N'A', '1990-01-01', '2020-01-01', N'Địa chỉ NV A', '0123456780', 10000, 0),
('NV002', N'Trần', N'B', '1992-02-02', '2020-01-01', N'Địa chỉ NV B', '0123456781', 12000, 0),
('NV003', N'Lê', N'C', '1988-03-03', '2020-01-01', N'Địa chỉ NV C', '0123456782', 11000, 0),
('NV004', N'Phạm', N'D', '1991-04-04', '2020-01-01', N'Địa chỉ NV D', '0123456783', 11500, 0),
('NV005', N'Hoàng', N'E', '1989-05-05', '2020-01-01', N'Địa chỉ NV E', '0123456784', 13000, 0),
('NV006', N'Đặng', N'F', '1993-06-06', '2020-01-01', N'Địa chỉ NV F', '0123456785', 14000, 0),
('NV007', N'Bùi', N'G', '1987-07-07', '2020-01-01', N'Địa chỉ NV G', '0123456786', 13500, 0),
('NV008', N'Vũ', N'H', '1995-08-08', '2020-01-01', N'Địa chỉ NV H', '0123456787', 15000, 0),
('NV009', N'Ngô', N'I', '1985-09-09', '2020-01-01', N'Địa chỉ NV I', '0123456788', 14500, 0),
('NV010', N'Đỗ', N'J', '1986-10-10', '2020-01-01', N'Địa chỉ NV J', '0123456789', 15500, 0);

-- Thêm dữ liệu vào bảng NHACUNGCAP
INSERT INTO NHACUNGCAP (MACONGTY, TENCONGTY, TENGIAODICH, DIACHI, DIEN_THOAI, FAX, EMAIL)
VALUES 
('VC001', N'VINAMILK', N'VINAMILK GD', N'Địa chỉ VINAMILK', '0123456799', '123456790', 'vinamilk@example.com'),
('VC002', N'Công ty A', N'Công ty A GD', N'Địa chỉ A', '0123456870', '123456791', 'a@example.com'),
('VC003', N'Công ty B', N'Công ty B GD', N'Địa chỉ B', '0123456801', '123456792', 'b@example.com'),
('VC004', N'Công ty Q', N'Công ty Q GD', N'Địa chỉ Q', '0123456800', '123054791', 'q@example.com'),
('VC005', N'Công ty L', N'Công ty S GD', N'Địa chỉ S', '0123411101', '123456745', 's@example.com'),
('VC006', N'Công ty M', N'Công ty M GD', N'Địa chỉ M', '0123456802', '123456793', 'm@example.com'),
('VC007', N'Công ty N', N'Công ty N GD', N'Địa chỉ N', '0123456803', '123456794', 'n@example.com'),
('VC008', N'Công ty O', N'Công ty O GD', N'Địa chỉ O', '0123456804', '123456795', 'o@example.com'),
('VC009', N'Công ty P', N'Công ty P GD', N'Địa chỉ P', '0123456805', '123456796', 'p@example.com'),
('VC010', N'Công ty R', N'Công ty R GD', N'Địa chỉ R', '0123456807', '123456798', 'r@example.com');

-- Thêm dữ liệu vào bảng LOAIHANG
INSERT INTO LOAIHANG (MALOAIHANG, TENLOAIHANG)
VALUES 
('LH001', N'Thực phẩm'),
('LH002', N'Đồ uống'),
('LH003', N'Hóa phẩm'),
('LH004', N'Thiết bị'),
('LH005', N'Dịch vụ'),
('LH006', N'Sản phẩm điện tử'),
('LH007', N'Đồ gia dụng'),
('LH008', N'Thời trang'),
('LH009', N'Nội thất'),
('LH010', N'Đồ chơi');


-- Thêm dữ liệu vào bảng MATHANG
INSERT INTO MATHANG (MAHANG, TENHANG, MACONGTY, MALOAIHANG, SOLUONG, DONVITINH, GIAHANG)
VALUES 
('MH001', N'Sữa đặc', 'VC001', 'LH001', 100, N'Hộp', 20000),
('MH002', N'Sữa tươi', 'VC001', 'LH001', 150, N'Lít', 30000),
('MH003', N' Nước giải khát', 'VC001', 'LH002', 200, N'Chai', 25000),
('MH004', N'Bột giặt', 'VC002', 'LH003', 50, N'Gói', 40000),
('MH005', N'Dầu ăn', 'VC002', 'LH001', 70, N'Lít', 50000),
('MH006', N'Nước rửa chén', 'VC003', 'LH003', 30, N'Chai', 35000),
('MH007', N'Xà phòng', 'VC003', 'LH003', 80, N'Viên', 10000),
('MH008', N'Điện thoại', 'VC004', 'LH006', 20, N'Cái', 3000000),
('MH009', N'Tivi', 'VC005', 'LH006', 15, N'Cái', 7000000),
('MH010', N'Bàn ăn', 'VC006', 'LH009', 10, N'Cái', 2000000);

-- Thêm dữ liệu vào bảng DONDATHANG
INSERT INTO DONDATHANG (SOHOADON, MAKHACHANG, MANHANVIEN, NGAYDATHANG, NGAYGIAOHANG, NGAYCHUYENHANG, NOIGIAOHANG)
VALUES 
(1, 'KH001', 'NV001', '2022-01-01', '2022-01-05', NULL, NULL), 
(2, 'KH002', 'NV002', '2023-01-02', '2023-01-06', NULL, NULL), 
(3, 'KH003', 'NV003', '2023-01-03', '2023-01-07', NULL, NULL),
(4, 'KH004', 'NV004', '2023-01-04', '2023-01-08', NULL, 'D'),
(5, 'KH005', 'NV004', '2023-01-05', '2023-01-09', NULL, 'E'),
(6, 'KH006', 'NV006', '2023-01-06', '2023-01-10', NULL, 'F'),
(7, 'KH007', 'NV008', '2023-01-07', '2023-01-11', NULL, 'G'),
(8, 'KH008', 'NV008', '2023-01-08', '2023-01-12', NULL, 'H'),
(9, 'KH009', 'NV009', '2023-01-09', '2023-01-13', NULL, 'I'),
(10, 'KH010', 'NV010', '2023-01-10', '2023-01-14', NULL, 'J');


-- Thêm dữ liệu vào bảng CHITIETDATHANG
INSERT INTO CHITIETDATHANG (SOHOADON, MAHANG, GIABAN, SOLUONG, MUCGIAMGIA)
VALUES 
(1, 'MH001', 45.99, 100, 5.00),    
(1, 'MH002', 30.50, 1, 5.00),    
(2, 'MH003', 12.75, 3, 1.00),    
(3, 'MH004', 99.99, 2, 5.00),    
(4, 'MH005', 25.00, 1, 2.50),   
(5, 'MH006', 15.40, 5, 5.00),    
(6, 'MH007', 8.99, 10, 5.00),    
(7, 'MH008', 22.30, 1, 5.00),    
(8, 'MH009', 55.00, 1, 5.00),    
(9, 'MH010', 10.50, 1, 5.00);    



-- a) Cập nhật NGAYCHUYENHANG với NGAYDATHANG cho các bản ghi có NGAYCHUYENHANG là NULL
UPDATE DONDATHANG
SET NGAYCHUYENHANG = NGAYDATHANG
WHERE NGAYCHUYENHANG IS NULL;
select *
from DONDATHANG 

-- b) Tăng gấp đôi số lượng hàng của các mặt hàng do VINAMILK cung cấp
UPDATE MATHANG
SET SOLUONG = SOLUONG * 2
WHERE MACONGTY = (SELECT MACONGTY FROM NHACUNGCAP WHERE TENCONGTY = 'VINAMILK');
select *
from MATHANG

-- c) Cập nhật NOIGIAOHANG bằng địa chỉ khách hàng cho các đơn hàng mà NOIGIAOHANG là NULL
UPDATE DONDATHANG
SET NOIGIAOHANG = KH.DIACHI
FROM DONDATHANG DD
JOIN KHACHHANG KH ON DD.MAKHACHANG = KH.MAKHACHHANG
WHERE DD.NOIGIAOHANG IS NULL;
SELECT *
FROM DONDATHANG;

  
-- d) Cập nhật dữ liệu trong KHACHHANG để địa chỉ, điện thoại, fax và email giống với nhà cung cấp nếu trùng tên
UPDATE KHACHHANG
SET DIACHI = NC.DIACHI,
    DIENTHOAI = NC.DIEN_THOAI,
    FAX = NC.FAX,
    EMAIL = NC.EMAIL
FROM KHACHHANG K
JOIN NHACUNGCAP NC ON K.TENCONGTY = NC.TENCONGTY AND K.TENGIAODICH = NC.TENGIAODICH;
select *
from KHACHHANG
-- e) Tăng lương lên gấp rưỡi cho những nhân viên bán được số lượng hàng > 100 trong năm 2022
UPDATE NHANVIEN
SET LUONGCOBAN = LUONGCOBAN * 1.5
WHERE MANHANVIEN IN (
    SELECT D.MANHANVIEN
    FROM CHITIETDATHANG C
    JOIN DONDATHANG D ON C.SOHOADON = D.SOHOADON
    WHERE YEAR(D.NGAYDATHANG) = 2022
    GROUP BY D.MANHANVIEN
    HAVING SUM(C.SOLUONG) > 100
);
select * 
from NHANVIEN


-- f) Tăng phụ cấp lên bằng 50% lương cho những nhân viên bán hàng nhiều nhất
UPDATE NHANVIEN
SET PHUCAP = LUONGCOBAN * 0.5
WHERE MANHANVIEN IN (
    SELECT TOP 1 MANHANVIEN
    FROM (
        SELECT MANHANVIEN, SUM(SOLUONG) AS TONGDH
        FROM DONDATHANG DDH, CHITIETDATHANG CT
        WHERE DDH.SOHOADON = CT.SOHOADON
        GROUP BY MANHANVIEN
    ) AS DOANHSO
    ORDER BY TONGDH DESC
);
select * 
from NHANVIEN

-- g) Giảm 25% lương cho những nhân viên không lập được đơn đặt hàng nào trong năm 2023
UPDATE NHANVIEN
SET LUONGCOBAN = LUONGCOBAN * 0.75
WHERE MANHANVIEN NOT IN (
    SELECT DISTINCT D.MANHANVIEN
    FROM DONDATHANG D
    WHERE YEAR(D.NGAYDATHANG) = 2023
);
select * 
from NHANVIEN

