.model small
org 100h

.data
    buffer  db 36,?,36 dup(?)
    c0      db '==========================================$'
    c1      db 13,10,'*<^> GALON SETIA GANK <^>* $'
    c2      db 13,10,'==========================================$'
    c3      db 13,10, '$'
    c4      db 13,10, '1. Air Galon Aqua $'
    c5      db 13,10, '2. Air Galon Cleo $'
    c6      db 13,10, '3. Air Galon Le Minerale $'
    c8      db 13,10, 'Galon apa yang ingin anda pesan [1...3] : $'
    c9      db '$',13,10,
    kata1   db 13,10,'======= Air Galon Aqua,- =========',13,10,'$'
    kata2   db 13,10,'======= Air Galon Cleo,- ==========',13,10,'$'
    kata3   db 13,10,'======= Air Galon Le Minerale,- ==========',13,10,'$'
    CHa     db 13,10,'A. Ukuran 19L RP.20.000',13,10,'B. Ukuran 12L RP 15.000 $'
    CHb     db 13,10,'A. Ukuran 19L RP.22.000',13,10,'B. Ukuran 12L RP 16.000$'
    CHc     db 13,10,'A. Ukuran 19L RP.23.000',13,10,'B. Ukuran 12L RP 17.000$'
    CHd     db '$',13,10,
    CHi     db 13,10,'Ukuran galon apa yang anda pilih : $'
    CHsalah db 13,10,'MAAF PILIHAN ANDA TIDAK ADA DI MENU ',13,10,'$'
    kembali db 13,10,'Tekan key untuk keluar: $'
    CHe     db 13,10,'===============================$'
    CHf     db 13,10,'* SILAHKAN DITUNGGU * $'
    CHg     db 13,10,'* PESANAN AKAN SEGERA DIANTAR *$'
    CHh     db 13,10,'============================== $'

.code
POSISI macro baris, kolom
    mov ah,02h
    mov dh,baris
    mov dl,kolom
    mov bh,00h
    int 10h
endm

cetak_klm macro klm
    mov ah,09
    lea dx,klm
    int 21h
endm

buffernya macro buf
    mov ah,0Ah
    lea dx,buffer
    int 21h
    lea bx,buffer + 2
endm

cls proc near
    mov ah,06h
    mov cx,11111011b
    mov dh,24
    mov dl,79
    mov al,00
    mov bh,00000000b
    int 10h
    jmp p1
    POSISI 0,0
cls endp

Tdata:
    POSISI 0,0
    jmp cls

p1:
    cetak_klm c0
    cetak_klm c1
    cetak_klm c2
    cetak_klm c3
    cetak_klm c4
    cetak_klm c5
    cetak_klm c6
    cetak_klm c8
    cetak_klm c9
    buffernya
    jmp pilihan

pilihan:
    cmp byte ptr [bx], '1'
    je paket1
    cmp byte ptr [bx], '2'
    je paket2
    cmp byte ptr [bx], '3'
    je paket3
    jmp salah

paket1:
    cetak_klm kata1
    cetak_klm CHa
    cetak_klm CHi
    buffernya
    jmp makanan

paket2:
    cetak_klm kata2
    cetak_klm CHb
    cetak_klm CHi
    buffernya
    jmp makanan

paket3:
    cetak_klm kata3
    cetak_klm CHc 
    cetak_klm CHi
    buffernya
    jmp makanan

makanan:
    cmp byte ptr [bx], 'A'
    je makasih
    cmp byte ptr [bx], 'B'
    je makasih
    jmp salah

makasih:
    cetak_klm CHe
    cetak_klm CHf
    cetak_klm CHg
    cetak_klm CHh
    buffernya
    jmp cetakback

salah:
    cetak_klm CHe
    cetak_klm CHsalah
    jmp cetakback

cetakback: 
    cetak_klm CHe
    cetak_klm kembali
    jmp coice

coice:
    mov ah,01
    int 21h
    mov bh, al
    cmp bh, 'B'
    je Tdata
    jmp exit

exit:
    int 20h
    end Tdata
