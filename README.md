# ElectroSphere-Inventory

## ElectroSphere UI
Link Figma : [LINK](https://www.figma.com/design/gPAEbwKWjsyXgeInVxLrRq/Pemob---Inventory?node-id=250-149&t=aTD7qhuXyFqz013D-1)

## Info
<p>Nama Aplikasi: ElectroSphere-Inventory</p>
<p>Tim Pengembang : Kelompok 3</p>

- Keisya - 221402006<br>  <i>(Fullstack fitur login dan dashboard, figma design, finishing)</i>
- Gylbert Chrismiguel Sitorus - 221402025
<br> <i>(Setup Awal (Database, Model, Config), Figma design dan PPT)</i>
- Yohana Marito Marbun - 221402065
<br> <i>(Fullstack fitur kelola stock out, additional history, finishing)</i>
- Diva Anggreini Harahap - 221402094<br> <i>(Fullstack fitur History dan Kelola Stok IN, figma design, PPT)</i>
- Fenaya Cecilly Nababan - 221402100<br> <i>(Fullstack employee, finishing)</i>
- Sakifa Indira Putri - 221402130<br> <i>(Fullstack Kelola Produk, figma design, PPT)</i>

## Desc
ELectroSphere Inventory adalah aplikasi mobile yang dirancang khusus untuk mengelola inventarisasi barang-barang elektronik secara efisien. Aplikasi ini menawarkan kemudahan dalam mengelola produk, melacak riwayat stok barang, hingga mengelola pegawai. Produk yang di kelola berupa produk elektronik seperti smartphone, laptop, televisi, hingga peralatan elektronik rumah tangga lainnya. Dengan antarmuka yang user-friendly, pengguna dapat lebih mudah dan efisien dalam melakukan pengelolaan stok produk elektronik.


## ⚙️ Features 

### Admin 🧑‍🦱

####  Login
- Menggunakan email dan password
  
####  Kelola Produk 🛠️
- Menambahkan produk
- Menghapus produk
- Mengedit produk

#### Menu Riwayat stok 📦
- Melihat daftar riwayat stok IN dan OUT secara keseluruhan
- Melakukan filter berdasarkan tanggal
- Menghapus riwayat stok IN atau stok OUT

#### Kelola Stok IN (stok masuk) 📊
- Melihat daftar riwayat stok IN
- Melihat visualisasi statistik dari riwayat stok IN
- Melakukan filter berdasarkan tanggal
- Melihat detail dari suatu riwayat stok IN
- Menghapus riwayat stok IN
- Menambah data stok IN

#### Kelola Stok OUT (stok keluar) 📊
- Melihat daftar riwayat stok OUT
- Melihat visualisasi statistik dari riwayat stok OUT
- Melakukan filter berdasarkan tanggal
- Melihat detail dari suatu riwayat stok OUT
- Menghapus riwayat stok OUT
- Menambah data stok OUT

#### Kelola Pegawai
- Menambah pegawai
- Menghapus pegawai

### Pegawai Toko

####  Kelola Produk 🛠️
- Menambahkan produk
- Menghapus produk
- Mengedit produk

####  Menu Riwayat stok 📦
- Melihat daftar riwayat stok IN dan OUT secara keseluruhan
- Melakukan filter berdasarkan tanggal

#### Kelola Stok IN (stok masuk) 📊
- Melihat daftar riwayat stok IN
- Melihat visualisasi statistik dari riwayat stok IN
- Melakukan filter berdasarkan tanggal
- Melihat detail dari suatu riwayat stok IN
- Menambah data stok IN

#### Kelola Stok OUT (stok keluar) 📊
- Melihat daftar riwayat stok OUT
- Melihat visualisasi statistik dari riwayat stok OUT
- Melakukan filter berdasarkan tanggal
- Melihat detail dari suatu riwayat stok OUT
- Menambah data stok OUT

## Library
TBA

## Environment
- Aplikasi ini hanya bisa dijalankan pada perangkat android
- Operating System : Windows 11 Professional <br>
  Processor : Intel Core i5 atau AMD RYZEN 5 <br>
  RAM : 8GB
  
## Instalasi dan Setup
1. Install XAMPP for Windows versi 8.0.30 / PHP 8.0.30 [disini](https://www.apachefriends.org/download.html) <br>
   Lokasi disk penginstallan XAMPP dibebaskan kepada masing-masing pengguna (baik di C:\ maupun D:\) <br>
2. Install Visual Studio Code versi Windows [disini](https://code.visualstudio.com/download) <br>
3. Install Android Studio [disini](https://developer.android.com/studio?hl=id) <br>
   Pilih untuk platform Windows 64 bit dan paket Android Studio yang memiliki `extension .exe`
4. Melakukan clone repository <br>
   <li>Buka Visual Studio Code</li>
   <li>Ketik shortcut Ctrl + Shift + G</li>
   <li>Pilih Clone Repository </li>
   <li>Masukkan link repository ini (https://github.com/gylbertcs/Electrosphere-Inventory.git)</li>
   <li>Lakukan clone pada folder xampp/htdocs</li>
   <li>Pindahkan file api_electrosphereinventory ke folder xampp/htdocs, lalu ekstrak pada direktori tersebut</li>
5. Membuka aplikasi XAMPP lalu aktifkan Apache dan Mysql <br>
6. Ketik `localhost/phpmyadmin/` di browser <br>
7. Buatlah database baru bernama `db_inventory`, lalu pilih menu import <br>
8. Masukkan file .sql yang ada didalam folder project lalu klik "import"
9. Jalankan Command Prompt (atau terminal sejenis) dan ketik `ipconfig` untuk melihat alamat IP perangkat
10. Pastikan alamat IP yang dicatat sesuai dengan perangkat dan dapat diakses dalam jaringan yang sama
11. Buka file `api.dart` yang berada di folder `/lib/config`
12. Ubah baris berikut untuk memperbarui URL Base API <br>
    ```dart
    static const_baseURL = 'http://<ip_perangkat>/api_electrosphereinventory';
    ```
    dengan alamat IP perangkat.
    
## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
