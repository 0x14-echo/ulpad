# 2026-03-22 File Open Failure Note

## Tarih
- 2026-03-22T20:45:00+03:00

## Belirti
- `./zig-out/bin/ulpad nano`
- `./zig-out/bin/ulpad asasdasd`
- Beklenen davranis: dosya yoksa yeni bos buffer acilsin ve kayit yolu bu isim olsun.
- Gercek davranis: uygulama `error: FileNotFound` ile cikiyor.
- Ek semptom: cikis sirasinda `DebugAllocator` `line_index` kaynakli leak raporluyor.

## Tekrar Uretim
```bash
./zig-out/bin/ulpad does-not-exist
```

## Stack Trace Ozet
- `src/app.zig:82`
- `src/editor_io.zig:24`
- `std.Io.Dir.readFileAlloc(...)`
- `error.FileNotFound`

## Kök Neden
1. `Editor.init` her zaman once `Document.initEmpty` ile bos belge kuruyor.
2. Komut satirindan bir path verilince kod bunu kosulsuz `loadDocument(...)` ile acmaya zorluyor.
3. Path yoksa `loadDocument` `FileNotFound` donduruyor.
4. Bu hata `Editor.init` icinde yakalanmadigi icin uygulama yeni dosya acma moduna gecemeden patliyor.
5. Hata donerken `Editor.init` icindeki onceden olusturulmus bos `Document` temizlenmiyor.
6. Bu nedenle `LineIndex.rebuild("")` icinde alinan allocation serbest birakilmadan kaliyormus gibi gorunuyor.

## Neden Yasandi
- "Var olan dosyayi ac" akisi ile "olmayan dosya adiyla yeni buffer baslat" akisi birbirinden ayrilmamis.
- `FileNotFound` terminal editoru acisindan fatal hata degil. Yeni dosya semantigi olmaliydi.
- `Editor.init` icinde local kaynaklar icin `errdefer` eksik.

## Beklenen Duzeltme
- Path verilmis ve dosya yoksa bos belge ile devam et.
- Bu durumda `file_path` yine de verilen ad olsun.
- `Editor.init` icinde yerel `Document` ve path kaynaklari `errdefer` ile korunmali.
- Bu davranis test ile kilitlenmeli.
