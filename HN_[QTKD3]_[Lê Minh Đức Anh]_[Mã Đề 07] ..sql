-- Phần I : THIẾT KẾ VÀ KHỞI TẠO CSDL --
                        -- Câu1 --
 create database HotelDB ;
use HotelDB ;

create table Guests(
guest_id INT,
guest_name VARCHAR(100),
birthday DATE,
gender VARCHAR(10),
phone VARCHAR(15)
);

create table Rooms(
room_id INT,
room_number VARCHAR(10),
type VARCHAR(50),
price_per_night DECIMAL(10, 2)
);
create  table  Bookings (
booking_id INT auto_increment  primary  key,
guest_id INT,
room_id INT,
check_in_date DATE,
check_out_date DATE,
constraint fk_guestid_Guests 
foreign key (guest_id) references  Guests(guest_id),
constraint  fk_roomid_Rooms
foreign key (room_id) references Rooms(room_id)
);

              -- Câu2 --
insert into Guests(guest_id,guest_name,birthday,gender,phone) values 
('Nguyen Van An', '1990-01-01', 'Nam', '0901111111'),
('Tran Thi Binh', '1995-05-05', 'Nu', '0902222222'),
('Le Van Cuong', '1988-08-08', 'Nam', '0903333333'),
('Pham Thi Dung', '1992-02-02', 'Nu', '0904444444'),
('Hoang Van Em', '2000-10-10', 'Nam', '0905555555'),
('Do Thi Hoa', '1998-12-12', 'Nu', '0906666666'),
('Vu Van Giang', '1985-03-03', 'Nam', '0907777777'),
('Bui Thi Hang', '1993-07-07', 'Nu', '0908888888'),
('Ngo Van Hung', '1991-09-09', 'Nam', '0909999999'),
('Trinh Thi Khoi', '1996-04-04', 'Nu', '0910000000');

insert into Rooms(room_id ,room_number,price_per_night) values 
('101', 'Standard', 500000),
('102', 'Standard', 500000),
('201', 'Deluxe', 1000000),
('202', 'Deluxe', 1000000),
('301', 'VIP', 2000000),
('302', 'VIP', 2000000),
('401', 'Standard', 550000),
('402', 'Deluxe', 1100000),
('501', 'President', 5000000),
('103', 'Standard', 450000);

insert into Bookings(booking_id,guest_id,room_id,check_in_date,check_out_date) values 
(1, 1, '2024-02-01', '2024-02-05'),
(2, 2, '2024-02-02', '2024-02-04'),
(3, 3, '2024-02-10', '2024-02-15'),
(4, 4, '2024-02-12', '2024-02-14'),
(5, 5, '2024-03-01', '2024-03-03'),
(6, 6, '2024-03-05', '2024-03-10'),
(7, 7, '2024-03-15', '2024-03-18'),
(8, 8, '2024-04-01', '2024-04-05'),
(9, 9, '2024-04-10', '2024-04-12'),
(10, 10, '2023-12-25', '2023-12-28');

                         -- PHẦN 2: THAO TÁC DỮ LIỆU --
                 -- Câu 3 --
-- 1. Cập nhật giá tất cả phòng VIP --
update Rooms
set  price_per_night = 2500000
where  type = 'VIP';
-- 2. Cập nhật số điện thoại của Nguyen Van An--
update  Guests
set  phone = '0999999999'
where  guest_name = 'Nguyen Van An';
                            -- Câu 4 --
-- 1. Xóa các bản ghi đặt phòng trước 2024-01-01 --
DELETE FROM Bookings
WHERE check_in_date < '2024-01-01';
-- 2. Xóa phòng số 103 --
DELETE FROM Rooms
WHERE room_number = '103';

                      -- PHẦN 3: TRUY VẤN DỮ LIỆU --
                           -- Câu 5 --
-- 1. Danh sách phòng loại Deluxe --
SELECT * FROM Rooms
WHERE type = 'Deluxe';
-- 2. Danh sách khách hàng giới tính Nam --
SELECT * FROM Guests
WHERE gender = 'Nam';
-- 3. Phòng có giá từ 1,000,000 trở lên --
SELECT * FROM Rooms
WHERE price_per_night >= 1000000;
-- 4. Tìm khách có tên chứa chữ "Hoa" --
SELECT * FROM Guests
WHERE guest_name LIKE '%Hoa%';
-- 5. 5 lần đặt phòng mới nhất --
ORDER BY check_in_date DESC
LIMIT 5;
                                -- Câu 6 --
-- 1.Lấy ra danh sách gồm: Tên khách hàng (guest_name), Số phòng (room_number), Ngày nhận phòng (check_in_date) và Ngày trả phòng (check_out_date).
--
SELECT 
g.guest_name,
r.room_number,
b.check_in_date,
b.check_out_date
FROM Bookings b
JOIN Guests g ON b.guest_id = g.guest_id
JOIN Rooms r ON b.room_id = r.room_id;
-- 2. Lấy ra tên khách hàng và loại phòng (type) mà họ đã đặt cho những đơn đặt phòng có giá trên 1,500,000 --
SELECT 
g.guest_name,
r.type,
r.price_per_night
FROM Bookings b
JOIN Guests g ON b.guest_id = g.guest_id
JOIN Rooms r ON b.room_id = r.room_id
WHERE r.price_per_night > 1500000;
-- 3.Hiển thị tên khách hàng và số ngày ở lại của từng lần đặt phòng (Gợi ý: Dùng hàm DATEDIFF(check_out_date, check_in_date) để tính số ngày, đặt tên cột là TotalDays).
--
SELECT 
g.guest_name,
DATEDIFF(b.check_out_date, b.check_in_date) AS TotalDays
FROM Bookings b
JOIN Guests g ON b.guest_id = g.guest_id;
-- 4. Hiển thị danh sách các phòng thuộc loại "Standard" và tên khách hàng đang đặt chúng.--
select 


                    -- Câu 7 --
-- 1. Thống kê số lượng phòng theo từng loại phòng (type).--
