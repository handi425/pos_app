Aplikasi POS Offline Flutter + Kasbon

**Peran & Tujuan**
Anda adalah arsitek dan lead engineer Flutter. Buat aplikasi **Point of Sale (POS) offline** untuk usaha kecil/menengah yang **tetap berfungsi tanpa internet**, dengan fitur utama **penjualan kasir**, **manajemen stok**, **pencatatan hutang/piutang (kasbon)**, dan **laporan ringkas**. Hasilkan **kode Flutter siap jalan** (Flutter stable terbaru, Dart 3), struktur proyek rapi, dan dokumentasi singkat.

**Ketentuan Teknis**

* **Flutter**: versi stable terbaru, **Material 3**.
* **State management**: **Riverpod** (flutter_riverpod).
* **Routing**: **go_router**.
* **Database lokal (offline-first)**: **Drift** (moor) atau **Isar** (pilih satu dan jelaskan alasan). Prefer **Drift** untuk relasi SQL dan query kompleks.
* **Model**: `freezed` + `json_serializable`.
* **Format Rupiah**: `intl` (IDR), pemformatan otomatis.
* **Barcode**: scan via kamera (QR/Barcode) untuk SKU.
* **Print Struk** (opsional tapi disiapkan): driver **ESC/POS Bluetooth** (abstract service + adapter, mockable).
* **UI/UX**: ringan, responsif (phone/tablet), tema gelap/terang, layout kasir efisien (min. tap).
* **Testing**: unit minimal untuk service harga/stock/kasbon; widget test untuk layar utama kasir.
* **Tanpa backend wajib**: aplikasi harus 100% usable offline. (Opsional: desain hook untuk sinkronisasi di masa depan).

**Fitur Inti**

1. **Kasir/Penjualan**

   * Cari produk via nama, SKU, atau scan barcode.
   * Tambah ke keranjang, ubah qty, diskon per item & per transaksi (Rp/%).
   * Hitung subtotal, diskon, pajak (opsional), total, bayar (tunai/transfer), **kembalian**.
   * Simpan transaksi & item detail; auto-kurangi stok.
   * Cetak/preview struk (58mm) dan simpan PDF (opsional).

2. **Produk & Stok**

   * CRUD kategori & produk (nama, SKU, harga jual, HPP opsional, stok, barcode).
   * **Riwayat stok**: pembelian/penyesuaian/retur (Stock In/Out).
   * Peringatan stok menipis (threshold per produk).

3. **Pelanggan**

   * CRUD pelanggan (nama, telp, catatan).
   * Riwayat transaksi pelanggan.

4. **Hutang/Piutang (Kasbon)**

   * Tandai transaksi sebagai **kasbon** ketika pembayaran < total (atau nol).
   * Simpan **saldo kasbon** per pelanggan.
   * **Pembayaran kasbon** parsial/total di kemudian hari (kas/transfer).
   * Riwayat pembayaran kasbon.
   * Validasi: tidak boleh negatif; catat user & waktu.

5. **Laporan Ringkas**

   * Harian/mingguan/bulanan: penjualan (qty, omzet, diskon), **piutang baru**, **pembayaran piutang**, arus kas ringkas, **laba kotor** sederhana (berdasar HPP jika diisi).
   * Export CSV sederhana (lokal).

6. **Keamanan & Pengguna**

   * Multi-user lokal sederhana: **Admin** & **Kasir** (tanpa auth server; PIN lokal).
   * Audit minimal: cap waktu & user pada transaksi, stok, kasbon.

**Skema Data (Drift)**
Buat tabel dan relasi berikut (sertakan definisi tabel & index):

* `categories(id, name)`
* `products(id, categoryId, name, sku, barcode, price, cost, stock, lowStockThreshold, isActive)`
* `customers(id, name, phone, notes)`
* `sales(id, datetime, customerId?, subtotal, discount, tax, total, paid, change, paymentMethod, isCredit)`
* `sale_items(id, saleId, productId, qty, price, discount, total)`
* `stock_movements(id, productId, type[IN|OUT|ADJUST], qty, note, createdAt, userId)`
* `debts(id, customerId, saleId, principal, remaining, createdAt, status[OPEN|CLOSED])`
* `debt_payments(id, debtId, amount, method, datetime, userId, note)`
* `cash_ledger(id, type[IN|OUT], amount, refType[SALE|DEBT_PAYMENT|ADJUSTMENT|PURCHASE], refId, note, datetime, userId)`
* `users(id, name, role[ADMIN|CASHIER], pinHash, createdAt, isActive)`

> Sertakan **view** atau helper query populer: saldo kasbon per pelanggan; stok saat ini per produk; ringkasan penjualan per hari.

**Aturan Bisnis Kunci**

* **Kasbon**:

  * Saat `paid < total`, set `isCredit=true`, buat `debts` dengan `principal = total - paid`, `remaining` sama nilainya.
  * Pembayaran kasbon mengurangi `remaining`. Jika `remaining==0` → `status=CLOSED`.
  * Catat ke `cash_ledger` setiap penerimaan pembayaran kasbon.
* **Stok**:

  * Penjualan mengurangi stok (`stock_movements OUT`).
  * Penyesuaian stok manual via modul Stok (ADJUST).
* **Pembulatan**: gunakan `num` → `int` (sen) untuk nilai uang di DB (hindari float error); tampilkan diformat Rupiah.
* **Diskon**: prioritas diskon per item, lalu diskon transaksi. Pastikan tidak membuat total negatif.
* **Laporan**: filter by date range, user, metode bayar, pelanggan.

**Layar Minimum (Wireframe Fungsional)**

* Onboarding (buat PIN admin, seed data contoh).
* Login PIN (lokal).
* Dashboard ringkas (kartu: Penjualan hari ini, Piutang tertagih hari ini, Stok menipis).
* Kasir (scan/cari produk, cart, ringkasan total, tombol Bayar, opsi Kasbon).
* Pelanggan (list + detail + saldo kasbon + tombol Bayar Kasbon).
* Produk & Stok (list, form, riwayat stok).
* Laporan (tab: Penjualan, Kasbon, Arus Kas).
* Pengaturan (profil toko, pajak default, printer Bluetooth, backup/restore lokal).

**Struktur Proyek (contoh)**

```
lib/
  main.dart
  app/router.dart
  core/ (constants, utils/money.dart, result.dart, exceptions)
  data/
    db/ (drift database, daos, migrations)
    models/ (*.dart via freezed)
    repos/ (interfaces + impl)
  domain/ (entities, usecases)
  features/
    auth/...
    sales/...
    products/...
    stock/...
    customers/...
    debts/...
    reports/...
    settings/...
  widgets/
```

**Keluaran yang Diharapkan**

1. **Kode lengkap** dengan dependency di `pubspec.yaml`.
2. **Implementasi database Drift** (tabel, DAO, migration, seed data).
3. **Layar utama** kasir lengkap (flow transaksi normal & kasbon).
4. **Modul kasbon** (buat kasbon dari penjualan, daftar kasbon, pembayaran parsial/total).
5. **Modul produk & stok** (CRUD, riwayat stok).
6. **Modul pelanggan** (CRUD, saldo kasbon & riwayat).
7. **Laporan ringkas** + export CSV (lokal).
8. **Service abstraksi printer** (mock + interface; implementasi BLE dapat menyusul).
9. **Testing contoh** (unit: kalkulasi total/diskon/kembalian/kasbon; widget: kasir add-to-cart).
10. **Dokumentasi singkat**: cara run, build, daftar fitur, batasan, dan catatan sinkronisasi (opsional).

**Contoh Kasus Uji (harus lulus)**

* Penjualan Rp100.000, bayar Rp60.000 → kasbon Rp40.000; saldo kasbon pelanggan bertambah Rp40.000; ledger IN Rp60.000.
* Pembayaran kasbon Rp15.000 → remaining Rp25.000; tidak boleh negatif; ledger IN Rp15.000.
* Diskon item 10% + diskon transaksi 5% → perhitungan benar dan tidak minus.
* Penjualan qty 2 produk A → stok A berkurang 2; tercatat `OUT`.
* Laporan harian cocok dengan transaksi & ledger.

**Kualitas Kode**

* Null-safety, lint ketat (`flutter_lints`).
* Pemisahan domain/data/presentation.
* Provider scope jelas; tidak ada logic berat di Widget.
* Komponen reusable untuk kartu info, tabel, dan form.

---

## Sub-Prompt Modular (Opsional)

### 1) Skema Database & DAO (Drift)

> Buat file Drift lengkap (tabel, index, foreign key, DAO, migration), sesuai skema di prompt utama. Gunakan tipe **int (sen)** untuk uang. Tambahkan helper query:
>
> * saldo kasbon per pelanggan,
> * total penjualan by date range,
> * stok saat ini per produk,
> * daftar kasbon open dengan aging (0–30, 31–60, >60 hari).

### 2) Layar Kasir & Proses Penjualan

> Implementasikan layar kasir dengan: pencarian produk, scan barcode, cart, diskon item/transaksi, kalkulasi total, input pembayaran (tunai/transfer), kembalian, tombol **Simpan** atau **Kasbon**. Simpan ke DB; kurangi stok; catat ledger. Buat widget test sederhana.

### 3) Modul Kasbon (Hutang/Piutang)

> Tambahkan daftar kasbon per pelanggan, detail kasbon, form pembayaran (parsial/total), validasi, update ledger, tutup kasbon saat lunas. Buat ringkasan saldo kasbon per pelanggan. Sertakan export CSV riwayat pembayaran.

### 4) Produk & Stok

> CRUD produk & kategori, riwayat stok (IN/OUT/ADJUST), threshold stok menipis, dan notifikasi visual. Implementasikan batch import CSV untuk produk (opsional).

### 5) Laporan

> Buat tab laporan: Penjualan (total, qty, diskon, pajak), Kasbon (baru & tertagih), Arus Kas, Laba Kotor (pakai cost). Filter tanggal & export CSV. Validasi dengan data dummy.

### 6) Pengaturan & Printer

> Halaman pengaturan toko, pajak default, preferensi printer. Buat **interface** printer ESC/POS Bluetooth + mock agar UI bisa “cetak struk (preview)” meski tanpa perangkat.

---

## Catatan Tambahan

* Pastikan **offline-first** benar-benar jalan: semua operasi CRUD & laporan bekerja tanpa koneksi.
* Jika memilih Isar alih-alih Drift, jelaskan mapping relasi & query yang ekuivalen serta trade-off.
* Jaga performa: indeks pada kolom pencarian (sku, barcode, name), pagination untuk list besar.

---