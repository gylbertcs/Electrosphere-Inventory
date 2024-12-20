# ElectroSphere-Inventory

## Info

<p>Nama Aplikasi: ElectroSphere-Inventory</p>
<p>Tim Pengembang : Kelompok 3</p>

- Keisya - 221402006<br> Back-End  <i>()</i>
- Gylbert Chrismiguel Sitorus - 221402025
<br> Front-End, Documentation <i>()</i>
- Yohana Marito Marbun - 221402065
<br> Back-End  <i>()</i>
- Diva Anggreini Harahap - 221402094<br> Back-End  <i>()</i>
- Fenaya Cecilly Nababan - 221402100<br> Front-End  <i>()</i>
- Sakifa Indira Putri - 221402130<br> Front-End  <i>()</i>

## Desc
ELectroSphere Inventory adalah aplikasi mobile yang dirancang khusus untuk mengelola inventarisasi barang-barang elektronik secara efisien. Aplikasi ini menawarkan kemudahan dalam mengelola produk, melacak riwayat stok barang, hingga mengelola pegawai. Produk yang di kelola berupa produk elektronik seperti smartphone, laptop, televisi, hingga peralatan elektronik rumah tangga lainnya. Dengan antarmuka yang user-friendly, pengguna dapat lebih mudah dan efisien dalam melakukan pengelolaan stok produk elektronik.
## ⚙️ Features 

### Pemilik Toko 🧑‍🦱

####  Kelola Produk 🛠️
- Menambahkan produk (dilengkapi fitur scan barcode)
- Menghapus produk
- Mengedit produk (detail produk, harga produk)
- Muncul notifikasi jika stok hampir habis

#### Kelola Stok 📦
- Mengupdate stok manual
- Melihat riwayat stok masuk dan keluar
- Menentukan stok minimal produk

#### Laporan 📊
- Melihat laporan stok barang secara keseluruhan
- Melihat laporan penjualan berdasarkan produk atau kategori
- Ekspor laporan ke dalam format PDF atau Excel
- Melihat laporan pegawai mengenai barang rusak atau retur

#### Log
- Memantau aktivitas pegawai, seperti riwayat menambahkan produk

### Pegawai Toko (Sales)

####  Kelola Produk 🛠️
- Melihat produk
- Menambahkan produk
- Melaporkan barang yang rusak atau retur

### Kelola Stok 📦
- Mengupdate stok manual
- Melihat riwayat stok masuk dan keluar

## Permissions
- Kamera

## Library
TBA

## Sumber Daya Luar
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
   Pilih untuk platform Windows 64 bit dan paket Android Studio yang memiliki extension .exe
4. Melakukan clone repository <br>
   <li>Buka Visual Studio Code</li>
   <li>Ketik shortcut Ctrl + Shift + G</li>
   <li>Pilih "Clone Repository"</li>
   <li>Masukkan link repository ini (https://github.com/gylbertcs/Electrosphere-Inventory.git)</li>
   <li>Lakukan clone pada folder xampp/htdocs</li>
   <li>Pindahkan file api_electrosphereinventory ke folder xampp/htdocs, lalu ekstrak pada direktori tersebut</li>
5. Membuka aplikasi XAMPP lalu aktifkan Apache dan Mysql <br>
6. Ketik localhost/phpmyadmin/ di browser <br>
7. Buatlah database baru bernama electrosphere, lalu pilih menu import <br>
8. Masukkan file .sql yang ada didalam folder project lalu klik "import"

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
